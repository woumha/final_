package com.vidividi.five.one;

import java.io.IOException;
import java.io.PrintWriter;
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
	public String joinMember(LoginDTO loginDTO) {
		
		String result = "";
		
		loginDTO.setCode(service.generateMembercode());
		
		System.out.println(loginDTO.getId());
		System.out.println(loginDTO.getPwd());
		System.out.println(loginDTO.getCode());
		
		int insertResult = dao.joinMember(loginDTO);
		System.out.println(insertResult);
		
		if (insertResult != 0) {
			result = loginDTO.getCode();
		}else if (insertResult == 0) {
			result = "fail";
		}
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("infoUpdate.do")
	public int infoUpdate(MemberDTO dto) {
		
		System.out.println(dto.getMember_name());
		System.out.println(dto.getMember_birth());
		
		return dao.mebmerInfoUpdate(dto);
	}
	
	

}
