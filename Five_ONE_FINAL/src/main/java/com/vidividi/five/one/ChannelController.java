package com.vidividi.five.one;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.vidividi.model.ChannelDAO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;

@Controller
public class ChannelController {
	private userUpload up;
	
	@Inject
	private ChannelDAO dao;
	
	ChannelDTO dto;
	
	@RequestMapping("channel.do")
	public String channel(
			/* @RequestParam("cha") String CurrentChannelCode, */ HttpServletRequest request, HttpSession session, Model model) throws Exception {
		//MultipartHttpServletRequest mRequest, 
		//String uploadPath = request.getSession().getServletContext().getRealPath("/").concat("resources"); // 이미지를 업로드할 폴더 경로 설정 = /uploadPath/imgUpload
		
		
		String memCode = (String)session.getAttribute("MemberCode");
		String lastChannelCode = (String)session.getAttribute("LastChannelCode");
		
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMember_code(memCode);
		memberDTO.setMember_last_channel(lastChannelCode);
		dto = this.dao.getChannelOwner(memberDTO); // 유저의 모든 값
		
		/* session.setAttribute("CurrentChannelCode", CurrentChannelCode); */
		
		model.addAttribute("currentOwner", dto);
		
		return "channel/channel_main";
	}
	
	@RequestMapping("movie_upload.do")
	public String upload(HttpServletRequest request, Model model) {
		
		
	
		return "channel/movie_upload";
	}
	
	
	
}
