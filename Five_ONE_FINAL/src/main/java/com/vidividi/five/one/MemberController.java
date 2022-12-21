package com.vidividi.five.one;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;


import java.io.PrintWriter;
import java.io.Reader;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.json.JSONParser;
import org.apache.tomcat.util.json.ParseException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.vidividi.model.ChannelDAO;
import com.vidividi.model.MemberDAO;
import com.vidividi.model.WatchDAO;
import com.vidividi.service.EmailSendService;
import com.vidividi.service.FormatCnt;
import com.vidividi.service.LoginService;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.TestDTO;

@Controller
public class MemberController {
	
	@Inject
	private MemberDAO dao;
	
	@Inject
	private ChannelDAO channelDAO;
	
	@Inject
	private WatchDAO watchDAO;
	
	@Autowired
	private LoginService service;
	
	@Autowired
	private EmailSendService emailservice;
	
	
	@RequestMapping("login.do")
	public String login() {
		return "member/login";
	}
	
	@ResponseBody
	@RequestMapping("loginOk.do")
	public String loginOk(Model model, LoginDTO loginDTO, HttpSession session) throws IOException {
		
		String membercode = service.loginCheck(loginDTO, session);
		
		if (membercode != null) {
			model.addAttribute("MemberCode", membercode);
			return "success";
		}else {
			return "fail";
		}
	}
	
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {
		service.logout(session);
		return "main";
	}
	
	@RequestMapping("join.do")
	public String join() {
		return "member/join";
	}
	
	@ResponseBody
	@RequestMapping("joinIdCheck.do")
	public String idCheck(@RequestParam("id") String id) {
		System.out.println("paramid : "+id);
		int count = service.joinIdCheck(id);
		System.out.println("serviceCount : "+count);
		
		if (count == 0) {
			return "allow";
		}else {
			return "deny";
		}
	}
	
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping("testajax.do") public List<MemberDTO> test(){ List<MemberDTO>
	 * list = dao.getMemberList();
	 * 
	 * if(list.size() != 0) { System.out.println("리스트 잘 넘어옴"); }
	 * 
	 * return list; }
	 */
	
	@ResponseBody
	@RequestMapping("joinOk.do")
	public String joinMember(MemberDTO memberDTO) {
		
		String result = "";
		
		memberDTO.setMember_code(service.generateMembercode());
		memberDTO.setMember_rep_channel(service.generateChannelCode());
		
		int joinResult = dao.joinMember(memberDTO);
		System.out.println("회원 가입 결과 : " +joinResult);
		
		ChannelDTO channelDTO = service.newChannel(memberDTO.getMember_code(), memberDTO.getMember_rep_channel(), memberDTO.getMember_id());
		
		int channelResult = channelDAO.insertChannel(channelDTO);
				
		if (joinResult != 0) {
			result = memberDTO.getMember_code();
			System.out.println("반환되는 멤버코드 : "+result);
		}else if (joinResult == 0) {
			result = "fail";
		}
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("infoUpdate.do")
	public int infoUpdate(MemberDTO dto) {
		
		System.out.println("------#join-form-2------");
		System.out.println(dto.getMember_code());
		System.out.println(dto.getMember_name());
		System.out.println(dto.getMember_email());
		System.out.println(dto.getMember_birth());
		System.out.println(dto.getMember_phone());
		System.out.println(dto.getMember_addr());

		return dao.mebmerInfoUpdate(dto);
	}
	
	
	@RequestMapping("setting.do")
	public String memberInfo(Model model, HttpSession session, MemberDTO dto) throws IOException {
				
		if (session.getAttribute("MemberCode") != null) {
			String memberCode = (String)session.getAttribute("MemberCode");
			
			dto = dao.getMember(memberCode);
			
			int age= 0;
			if (dto.getMember_birth() != null) {
				age = service.getAge(dto.getMember_birth());
			}else {
				age = -1;
			}
			
			ChannelDTO channelDTO = channelDAO.getChannelOwner(dto);
			
			int videoCount = watchDAO.getVideoCount(channelDTO.getChannel_code());
			

			FormatCnt format = new FormatCnt();
			String channel_like = format.format(channelDTO.getChannel_like());
			String video_count = format.format(videoCount);
			
			model.addAttribute("MemberCode", memberCode);
			model.addAttribute("MemberName", dto.getMember_name());
			model.addAttribute("MemberDTO", dto);
			model.addAttribute("ChannelDTO", channelDTO);
			model.addAttribute("ChannelLike", channel_like);
			model.addAttribute("MemberAge", age);
			model.addAttribute("VideoCount", video_count);
			
			return "member/setting_main";
		}else {
			// 프론트에서 null 체크 해야 toast 창 제대로 보일 것 같음
			// 일단 이대로 둠
			model.addAttribute("msg", "로그인 하세요");
			model.addAttribute("url", "login.do");
			
			return "redirect";
		}
				
	}
	
	@RequestMapping("setting_profile.do")
	public String setProfile(HttpSession session, MemberDTO dto, Model model) {
		if (session.getAttribute("MemberCode") != null) {
			String memberCode = (String)session.getAttribute("MemberCode");
			dto = dao.getMember(memberCode);
			
			model.addAttribute("MemberCode", memberCode);
			model.addAttribute("MemberName", dto.getMember_name());
			model.addAttribute("MemberDTO", dto);
			
			return "member/setting_profile";
		}else {
			model.addAttribute("msg", "로그인 하세요");
			model.addAttribute("url", "login.do");
			
			return "redirect";
		}
		
	}
		
	@RequestMapping("setting_channel.do")
	public String setChannel(HttpSession session, MemberDTO dto, Model model) {
		if (session.getAttribute("MemberCode") != null) {
			String memberCode = (String)session.getAttribute("MemberCode");
			dto = dao.getMember(memberCode);
			
			model.addAttribute("MemberCode", memberCode);
			model.addAttribute("MemberName", dto.getMember_name());
			model.addAttribute("MemberDTO", dto);
			
			return "member/setting_channel";
			
		}else{
			model.addAttribute("msg", "로그인 하세요");
			model.addAttribute("url", "login.do");
				
			return "redirect";
		}
		
	}
	
	@RequestMapping("setting_protect.do")
	public String setProtect(HttpSession session, MemberDTO dto, Model model) {
		if (session.getAttribute("MemberCode") != null) {
			String memberCode = (String)session.getAttribute("MemberCode");
			dto = dao.getMember(memberCode);
			
			model.addAttribute("MemberCode", memberCode);
			model.addAttribute("MemberName", dto.getMember_name());
			model.addAttribute("MemberDTO", dto);
			
			return "member/setting_email_protect";
			
		}else{
			model.addAttribute("msg", "로그인 하세요");
			model.addAttribute("url", "login.do");
				
			return "redirect";
		}
		
	}
	
	@RequestMapping("vidividi_premium.do")
	public String premium() {
		return "member/vidividi_premium";
	}

	
	// 에이젝스 -> 제3페이지로 반환
	@RequestMapping("getChannelList.do")
	public String getChannelList(@RequestParam("member_code") String memberCode, Model model, HttpSession session){
		
		List<ChannelDTO> channelList = channelDAO.getChannelList(memberCode);
		MemberDTO dto = dao.getMember(memberCode);
		model.addAttribute("MemberDTO", dto);
		model.addAttribute("RepChannelCode", dto.getMember_rep_channel());
		model.addAttribute("ChannelList", channelList);
		return "member/channel_list";
	}
	
	@ResponseBody
	@RequestMapping("newChannel.do")
	public String newChannel(@RequestParam("member_code") String memberCode) {
		
		String channelCode = service.generateChannelCode();
		MemberDTO dto = dao.getMember(memberCode);
		System.out.println(memberCode);
		System.out.println(channelCode);
		System.out.println(dto.getMember_name());
		ChannelDTO channelDTO = service.newChannel(memberCode, channelCode, dto.getMember_name());
		int check = channelDAO.insertChannel(channelDTO);
		
		if (check > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	@ResponseBody
	@RequestMapping("delete_channel.do")
	public String deleteChannel(
			@RequestParam("member_code") String memberCode,
			@RequestParam("channel_code") String channelCode) {
		
		
		int count = channelDAO.countMemberChannel(memberCode);
		int check = 0;
		
		if (count > 1) {
			check = channelDAO.deleteChannel(channelCode);
			
			if (check > 0) {
				return "success";
			}else {
				return "fail";
			}
			
		}else {
			return "essential";
		}
		
	}
	
	@ResponseBody
	@RequestMapping("sendEmail.do")
	public String sendEmail(
			@RequestParam("member_code") String memberCode,
			@RequestParam("member_email") String email) {
		

		String db_email = dao.alreadyEmail(memberCode);
		
		if (email == db_email) {
			System.out.println("이미 인증된 이메일입니다 : " + email);
			return "already";
		}else {
			String authKey = emailservice.sendAuthEmail(email);
			
			if(authKey != null) {
				System.out.println("전송된 인증 코드 : "+authKey);
				return authKey;			
			}else {
				return "fail";
			}
		}
		
	}
	
	
	@ResponseBody
	@RequestMapping("changeAuthStatus.do")
	public String changeAuthStatus(
			@RequestParam("member_code") String memberCode,
			@RequestParam("member_email") String email) {
		MemberDTO dto = new MemberDTO();
		dto.setMember_code(memberCode);
		dto.setMember_email(email);
		
		int check = dao.changeAuthStatus(dto);
		
		if(check > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	
	@ResponseBody
	@RequestMapping("toggleEmailLogin.do")
	public String toggleEmailLogin(@RequestParam("member_code") String memberCode) {
		dao.toggleEmailLogin(memberCode);
		return "done";
	}
	
	
	@RequestMapping("setting_login_history.do")
	public String loginHistory(HttpSession session, MemberDTO dto, Model model) throws Exception {
		
		if (session.getAttribute("MemberCode") != null) {
			String memberCode = (String)session.getAttribute("MemberCode");
			dto = dao.getMember(memberCode);
			
			model.addAttribute("MemberCode", memberCode);
			model.addAttribute("MemberName", dto.getMember_name());
			model.addAttribute("MemberDTO", dto);
			
			Reader reader = new FileReader("http://ip-api.com/json");
			
			JSONParser parser = new JSONParser(reader);
			
			JSONObject obj = (JSONObject)parser.parse();
			
			String login_country = (String) obj.get("country");
			String login_region = (String) obj.getString("regionName");
			String login_city = (String) obj.getString("city");
			String login_query = (String) obj.getString("query");
			
			model.addAttribute("Country", login_country);
			model.addAttribute("Region", login_region);
			model.addAttribute("City", login_city);
			model.addAttribute("IP", login_query);
			
			return "member/setting_login_history";
			
		}else{
			model.addAttribute("msg", "로그인 하세요");
			model.addAttribute("url", "login.do");
				
			return "redirect";
		}
		
	}
	

}
