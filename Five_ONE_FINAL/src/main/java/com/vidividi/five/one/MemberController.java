package com.vidividi.five.one;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vidividi.model.ChannelDAO;
import com.vidividi.model.MemberDAO;
import com.vidividi.model.WatchDAO;
import com.vidividi.service.EmailSendService;
import com.vidividi.service.FormatCnt;
import com.vidividi.service.LoginHistoryService;
import com.vidividi.service.LoginService;
import com.vidividi.service.SocialLoginService;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.GoogleLoginDTO;
import com.vidividi.variable.KakaoLoginDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.LoginHistoryDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.TestDTO;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;

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
	
	@Autowired
	private LoginHistoryService loginHistoryService;
	
	@Autowired
	private SocialLoginService socialservice;
	
	
	@RequestMapping("login.do")
	public String login() {
		return "member/login";
	}
	
	@ResponseBody
	@RequestMapping("loginOk.do")
	public String loginOk(Model model, LoginDTO loginDTO, HttpSession session) throws Exception {
		
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
		return service.insertMember(memberDTO, "joinForm");
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
			
			List<LoginHistoryDTO> loginHistoryList = dao.getLoginHistroy(memberCode);
			
			model.addAttribute("MemberCode", memberCode);
			model.addAttribute("MemberName", dto.getMember_name());
			model.addAttribute("MemberDTO", dto);
			
			model.addAttribute("LoginHistoryList", loginHistoryList);
			
			return "member/setting_login_history";
			
		}else{
			model.addAttribute("msg", "로그인 하세요");
			model.addAttribute("url", "login.do");
				
			return "redirect";
		}
		
	}
	
	
	@ResponseBody
	@RequestMapping("googleLogin.do")
	public String googleLogin(@RequestParam("jwt") String jwt_token, HttpSession session) throws Exception {
		
		GoogleLoginDTO dto = socialservice.decodeGoogleJWT(jwt_token);
		String check = dao.isGoogleLinked(dto);
		if (check == "1") { // 회원인데 구글 링크 된 경우
			
			return "linked";
		}else if (check == "0"){ // 회원인데 구글 링크 안된 경우
			return "notlinked";
		}else { // 아예 회원이 아닌 경우
			
			MemberDTO mdto = new MemberDTO();
			
			mdto.setMember_name(dto.getGoogle_name());
			mdto.setMember_email(dto.getGoogle_email());
			mdto.setMember_id(dto.getGoogle_id());
			
			service.insertMember(mdto, "google");
			
			LoginDTO ldto = new LoginDTO();
			ldto.setId(mdto.getMember_id());
			ldto.setPwd(mdto.getMember_pwd());
			ldto.setCode(mdto.getMember_code());
			String memberCode = service.loginCheck(ldto, session);
			
			return "joined";
		}
		
		
	}
	
	
	@RequestMapping("kakao_login.do")
	public String kakao_login (@RequestParam("code") String code){
		
		System.out.println(code);
		String access_token = socialservice.getKakaoAccessToken(code);
		System.out.println("토큰 : " + access_token);
		
		KakaoLoginDTO dto = socialservice.getKakaoData(access_token);
		MemberDTO mdto = new MemberDTO();
		mdto.setMember_name(dto.getKakao_name());
		mdto.setMember_email(dto.getKakao_email());
		mdto.setMember_id(dto.getKakao_id());
		
		service.insertMember(mdto, "kakao");
		
		return "main";
	}
	
	
	@RequestMapping("naver_login.do")
	public String naver_login (@RequestParam("code") String code){
		
		
		return "main";
	}
	

}
