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
		
		String check_member_code = dao.checkMember(loginDTO);
		if (check_member_code != null) {
			int checkExpire = dao.checkExpire(check_member_code);
			if (checkExpire == 1) {
				return "expired";
			}else {
				int checkProtect = dao.isProtected(check_member_code);
				if (checkProtect == 1) {
					MemberDTO mdto = dao.getMember(check_member_code);
					String authKey = emailservice.sendAuthEmail(mdto.getMember_email());
					return authKey;
				}else {
					String membercode = service.loginCheck(loginDTO, session);
					if (membercode != null) {
						if (membercode.equals("expired")) {
							return "expired";
						}else {
							model.addAttribute("MemberCode", membercode);
							return "success";
						}	
					}else {
						return "fail";
					}
				}
			}
		}else {
			return "fail";
		}
	}
	
	
	@ResponseBody
	@RequestMapping("protect_login_ok.do")
	public String protectLogin (Model model, LoginDTO loginDTO, HttpSession session) throws Exception {
		String membercode = service.loginCheck(loginDTO, session);
		if (membercode != null) {
			if (membercode.equals("expired")) {
				return "expired";
			}else {
				model.addAttribute("MemberCode", membercode);
				return "success";
			}	
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
		return service.insertMember(memberDTO, "joinForm", "");
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
				if (age < 0) {
					age = 0;
				}
			}else {
				age = -1;
			}
			
			ChannelDTO channelDTO = channelDAO.getChannelInformation(dto);
			
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
		ChannelDTO channelDTO = service.newChannel(memberCode, channelCode, dto.getMember_name(), "");
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
	@RequestMapping("google_login.do")
	public String googleLogin(@RequestParam("jwt") String jwt_token, HttpSession session) throws Exception {
		
		GoogleLoginDTO gdto = socialservice.decodeGoogleJWT(jwt_token);
		String check = dao.isSocialLinked(gdto.getGoogle_email());
		System.out.println("check : "+check);
		MemberDTO mdto = new MemberDTO();
		
		if(check == null){ // 아예 회원이 아닌 경우
			
			mdto.setMember_name(gdto.getGoogle_name());
			mdto.setMember_email(gdto.getGoogle_email());
			mdto.setMember_id("g-"+gdto.getGoogle_id());
			 
			service.insertMember(mdto, "google", gdto.getGoole_pictureURL()); 
			service.socialLogin(gdto, session);
						
			return "joined";
		}else if (check.equals("google")) { // 회원인데 구글 링크 된 경우
			service.socialLogin(gdto, session);
			return "linked";
		}else if (check.equals("0")){ // 회원인데 구글 링크 안된 경우
			String memberCode = service.socialLogin(gdto, session);
			mdto.setMember_code(memberCode);
			mdto.setMember_social_link("google");
			dao.socialLink(mdto);
			return "notlinked";
		}
		
		return "main";
		
	}
	
	
	@RequestMapping("kakao_login.do")
	public String kakao_login (@RequestParam("code") String code, HttpSession session) throws Exception{
		
		System.out.println("카카오 로그인 코드 : " +code);
		String access_token = socialservice.getKakaoAccessToken(code);
		System.out.println("카카오 엑세스 토큰 : " + access_token);
		
		KakaoLoginDTO kdto = socialservice.getKakaoData(access_token);
		String check = dao.isSocialLinked(kdto.getKakao_email());
		System.out.println("check : "+check);
		MemberDTO mdto = new MemberDTO();
		
		if(check == null){ // 아예 회원이 아닌 경우
			
			mdto.setMember_name(kdto.getKakao_name());
			mdto.setMember_email(kdto.getKakao_email());
			mdto.setMember_id("k-"+kdto.getKakao_id());
			
			service.insertMember(mdto, "kakao", kdto.getKakao_profile());
			service.socialLogin(kdto, session);
			
		}else if (check.equals("kakao")) { // 회원인데 카카오 링크 된 경우
			service.socialLogin(kdto, session);
		}else if (check.equals("0")){ // 회원인데 카카오 링크 안된 경우
			String memberCode = service.socialLogin(kdto, session);
			mdto.setMember_code(memberCode);
			mdto.setMember_social_link("kakao");
			dao.socialLink(mdto);
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
		System.out.println("check : "+check);
		MemberDTO mdto = new MemberDTO();
		
		if(check == null){ // 아예 회원이 아닌 경우
			mdto.setMember_name(ndto.getNaver_name());
			mdto.setMember_email(ndto.getNaver_email());
			mdto.setMember_id("n-"+ndto.getNaver_id());
			mdto.setMember_phone(ndto.getNaver_phone());
			mdto.setMember_birth(ndto.getNaver_birth());
			
			service.insertMember(mdto, "naver", ndto.getNaver_profile());
			service.socialLogin(ndto, session);
		}else if (check.equals("naver")) { // 회원인데 네이버 링크 된 경우
			service.socialLogin(ndto, session);
		}else if (check.equals("0")){ // 회원인데 네이버 링크 안된 경우
			String memberCode = service.socialLogin(ndto, session);
			mdto.setMember_code(memberCode);
			mdto.setMember_social_link("naver");
			dao.socialLink(mdto);
		}
		
		return "main";
	}
	
	
	
	@RequestMapping("find_id.do")
	public String findId(Model model, HttpSession session) throws UnsupportedEncodingException {
		String url = socialservice.getNaverAuthUrl(session);
		model.addAttribute("NaverLoginUrl", url);
		return "member/find_id";
	}
	
	@RequestMapping("find_pwd.do")
	public String findPwd(Model model, HttpSession session) throws UnsupportedEncodingException {
		String url = socialservice.getNaverAuthUrl(session);
		model.addAttribute("NaverLoginUrl", url);
		return "member/find_pwd";
	}
	
	@ResponseBody
	@RequestMapping("find_id_ok.do")
	public String findIdOk(@RequestParam("email") String email) {
		String check = dao.isSocialLinked(email);
		String member_id = dao.findId(email);
		
		if (member_id != null) {
			if (member_id.contains("-")) {
				return check;
			}else {
				return member_id;
			}
		}else {
			return "undefined";
		}
	}
	
	@ResponseBody
	@RequestMapping("find_pwd_ok.do")
	public String findPwdOk(@RequestParam("id") String id, @RequestParam("email") String email) {
		
		String member_id = dao.findId(email);
		
		if (member_id != null) {
			if (member_id.contains("-")) {
				return "social";
			}else {
				String tempPwd = emailservice.sendTempPwdEmail(email);
				LoginDTO ldto = new LoginDTO();
				ldto.setId(member_id);
				ldto.setPwd(tempPwd);
				dao.changePwd(ldto);
				return "mail";
			}
		}else {
			return "undefined";
		}
	}
	
	
	@ResponseBody
	@RequestMapping("change_pwd.do")
	public String changePwd(@RequestParam("id") String id, @RequestParam("current_pwd") String current_pwd, @RequestParam("change_pwd") String change_pwd, HttpSession session) {
		
		System.out.println("넘어온 id : " + id);
		System.out.println("넘어온 current_pwd : " + current_pwd);
		System.out.println("넘어온 change_pwd : " + change_pwd);
		
		
		LoginDTO ldto = new LoginDTO();
		ldto.setId(id);
		ldto.setPwd(current_pwd);
		String member_code = dao.checkMember(ldto);
		System.out.println("member_code : "+member_code);
		System.out.println("세션 MemberCode: "+session.getAttribute("MemberCode"));
		if (member_code != null) { // 아이디 현재 비밀번호가 맞는 경우
			if (session.getAttribute("MemberCode") != null) { // 로그인 세션이 존재하는 경우
				if (session.getAttribute("MemberCode").equals(member_code)) { // 세션과 조회된 멤버가 같은 경우
					ldto.setPwd(change_pwd);
					dao.changePwd(ldto);
					return "success";
				}else { // 세션과 조회된 멤버가 같지 않은 경우
					return "fail";
				}
			}else { // 로그인 세션이 존재하지 않는 경우
				return "session";
			}
		}else { // 현재 비밀번호가 틀린 경우
			return "fail";
		}
	}
	
	
	@ResponseBody
	@RequestMapping("change_profile.do")
	public String changeProfile(MemberDTO mdto, HttpSession session) {
		if (session.getAttribute("MemberCode") != null) {
			mdto.setMember_code((String)session.getAttribute("MemberCode"));
			int check = dao.mebmerInfoUpdate(mdto);
			if (check > 0) {
				return "success";
			}else {
				return "fail";
			}
		}else {
			return "session";
		}		
	}
	
	
	@ResponseBody
	@RequestMapping("member_expire.do")
	public String expire(@RequestParam("member_code")String memberCode, HttpSession session) {
		if (memberCode.equals("sessionExpired")) {
			return "session";
		}else {
			int check = dao.memberExpire(memberCode);
			if (check > 0) {
				service.logout(session);
				return "success";
			}else {
				return "fail";
			}
		}
	}
	
	
	@ResponseBody
	@RequestMapping("change_rep_channel.do")
	public String changeRep(@RequestParam("channel_code") String channelCode, @RequestParam("member_code")String memberCode, HttpSession session) {
		MemberDTO mdto = new MemberDTO();
		mdto.setMember_code(memberCode);
		mdto.setMember_rep_channel(channelCode);
		int check = dao.changeRep(mdto);
		if (check > 0) {
			System.out.println("RepChannelCode-삭제 전 : "+(String)session.getAttribute("RepChannelCode"));
			session.removeAttribute("RepChannelCode");
			session.setAttribute("RepChannelCode", channelCode);
			System.out.println("RepChannelCode-삭제 후 재설정 : "+(String)session.getAttribute("RepChannelCode"));
			return "success";
		}else {
			return "fail";
		}
	}

}
