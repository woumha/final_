package com.vidividi.five.one;

import java.io.IOException;

import java.io.PrintWriter;
import java.net.http.HttpResponse;
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
import com.vidividi.service.LoginService;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.MemberDTO;

@Controller
public class MemberController {
	
	@Inject
	private MemberDAO dao;
	
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
		/* memberDTO.setMember_last_channel(service.channelcodemaking()); */
		
		int insertResult = dao.joinMember(memberDTO);
		System.out.println(insertResult);
		
		if (insertResult != 0) {
			result = memberDTO.getMember_code();
		}else if (insertResult == 0) {
			result = "fail";
		}
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("infoUpdate.do")
	public int infoUpdate(MemberDTO dto) {
		return dao.mebmerInfoUpdate(dto);
	}
	
	
	@RequestMapping("info.do")
	public String memberInfo(Model model, HttpSession session, MemberDTO dto) throws IOException {
				
		if (session.getAttribute("MemberCode") != null) {
			String memberCode = (String)session.getAttribute("MemberCode");
			dto = dao.getMember(memberCode);
			model.addAttribute("MemberCode", memberCode);
			model.addAttribute("MemberName", dto.getMember_name());
			model.addAttribute("MemberDTO", dto);
			return "member/member_info";
		}else {
			// 프론트에서 null 체크 해야 toast 창 제대로 보일 것 같음
			// 일단 이대로 둠
			model.addAttribute("msg", "로그인 하세요");
			model.addAttribute("url", "login.do");
			
			return "redirect";
		}
				
	}
	
	

}
