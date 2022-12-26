package com.vidividi.five.one;

import java.io.BufferedReader;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
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
import com.vidividi.variable.NaverLoginDTO;
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
	private SocialLoginService socialservice;
	
	@RequestMapping("login.do")
	public String login(Model model, HttpSession session) throws UnsupportedEncodingException {
		String url = socialservice.getNaverAuthUrl(session);
		model.addAttribute("NaverLoginUrl", url);
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
	

	@ResponseBody
	@RequestMapping("joinOk.do")
	public String joinMember(MemberDTO memberDTO) {
		return service.insertMember(memberDTO, "joinForm");
	}
	
	
	@ResponseBody
	@RequestMapping("infoUpdate.do")
	public int infoUpdate(MemberDTO dto) {
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
		
		GoogleLoginDTO gdto = socialservice.decodeGoogleJWT(jwt_token);
		String check = dao.isSocialLinked(gdto.getGoogle_email());
		MemberDTO mdto = new MemberDTO();
		
		if (check.equals("google")) { // 회원인데 구글 링크 된 경우
			service.socialLogin(gdto, session);
			return "linked";
		}else if (check.equals("0")){ // 회원인데 구글 링크 안된 경우
			String memberCode = service.socialLogin(gdto, session);
			mdto.setMember_code(memberCode);
			mdto.setMember_social_link("google");
			dao.socialLink(mdto);
			return "notlinked";
		}else { // 아예 회원이 아닌 경우
			
			mdto.setMember_name(gdto.getGoogle_name());
			mdto.setMember_email(gdto.getGoogle_email());
			mdto.setMember_id(gdto.getGoogle_id());
			 
			service.insertMember(mdto, "google"); service.socialLogin(gdto, session);
			
			
			return "joined";
		}
		
		
	}
	
	
	@RequestMapping("kakao_login.do")
	public String kakao_login (@RequestParam("code") String code, HttpSession session) throws Exception{
		
		System.out.println("카카오 로그인 코드 : " +code);
		String access_token = socialservice.getKakaoAccessToken(code);
		System.out.println("카카오 엑세스 토큰 : " + access_token);
		
		KakaoLoginDTO kdto = socialservice.getKakaoData(access_token);
		String check = dao.isSocialLinked(kdto.getKakao_email());
		MemberDTO mdto = new MemberDTO();
		
		if (check.equals("kakao")) { // 회원인데 카카오 링크 된 경우
			service.socialLogin(kdto, session);
		}else if (check.equals("0")){ // 회원인데 카카오 링크 안된 경우
			String memberCode = service.socialLogin(kdto, session);
			mdto.setMember_code(memberCode);
			mdto.setMember_social_link("kakao");
			dao.socialLink(mdto);
		}else { // 아예 회원이 아닌 경우
			
			mdto.setMember_name(kdto.getKakao_name());
			mdto.setMember_email(kdto.getKakao_email());
			mdto.setMember_id(kdto.getKakao_id());
			
			service.insertMember(mdto, "kakao");
			service.socialLogin(kdto, session);
			
		}
		
		return "main";
	}
	
	
	@RequestMapping("naver_login.do")
	public String naver_login (@RequestParam("code") String code, HttpSession session) throws Exception{
		System.out.println("네이버 로그인 코드 : " +code);
		String access_token = socialservice.getNaverAccessToken(code, session);
		System.out.println("네이버 액세스 토큰 : "+access_token);
		NaverLoginDTO ndto = socialservice.getNaverData(access_token);
		
		String check = dao.isSocialLinked(ndto.getNaver_email());
		MemberDTO mdto = new MemberDTO();
		
		if (check.equals("naver")) { // 회원인데 네이버 링크 된 경우
			service.socialLogin(ndto, session);
		}else if (check.equals("0")){ // 회원인데 네이버 링크 안된 경우
			String memberCode = service.socialLogin(ndto, session);
			mdto.setMember_code(memberCode);
			mdto.setMember_social_link("naver");
			dao.socialLink(mdto);
		}else { // 아예 회원이 아닌 경우
			mdto.setMember_name(ndto.getNaver_name());
			mdto.setMember_email(ndto.getNaver_email());
			mdto.setMember_id(ndto.getNaver_id());
			mdto.setMember_phone(ndto.getNaver_phone());
			mdto.setMember_birth(ndto.getNaver_birth());
			
			service.insertMember(mdto, "naver");
			service.socialLogin(ndto, session);
		}
		
		return "main";
	}
	

}
