package com.vidividi.five.one;

import java.io.IOException;


import java.io.PrintWriter;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
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
			int age = service.getAge(dto.getMember_birth());
			
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
	public String setProtect() {
		return "member/setting_email_protect";
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
		model.addAttribute("RepChannelCode", dto.getMember_rep_channel());
		model.addAttribute("ChannelList", channelList);
		return "member/channel_list";
	}
	
	
	

}
