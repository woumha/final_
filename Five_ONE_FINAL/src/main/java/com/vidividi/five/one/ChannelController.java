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
	
	@Inject
	private UploadFile uploadFile;
	
	ChannelDTO dto;
	
	@RequestMapping("channel.do")
	public String channel(HttpServletRequest request, HttpSession session, Model model) throws Exception {
		//MultipartHttpServletRequest mRequest, 
		//String uploadPath = request.getSession().getServletContext().getRealPath("/").concat("resources"); // 이미지를 업로드할 폴더 경로 설정 = /uploadPath/imgUpload
		
		
		String memCode = (String)session.getAttribute("MemberCode"); // 유저 코드
		String lastChannelCode = (String)session.getAttribute("LastChannelCode"); // 마지막 채널 코드
		
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMember_code(memCode);
		memberDTO.setMember_last_channel(lastChannelCode);
		dto = this.dao.getChannelOwner(memberDTO); // 채널의 모든 값
		
		
		//session.setAttribute("CurrentChannel", currentCode);
		
		model.addAttribute("currentOwner", dto);
		
		return "channel/channel_main";
	}
	
	@RequestMapping("movie_upload.do")
	public String modalUploadPage(HttpServletRequest request, Model model) {
		return "channel/movie_upload";
	}
	
	
	@RequestMapping("upload_success.do")
	public String upload(MultipartHttpServletRequest mRequest, Model model) {
		//System.out.println(uploadFile.fileUpload(mRequest));
		System.out.println("mRequest =" + mRequest);
		
		System.out.println(uploadFile.fileUpload(mRequest));
		
		return null;
	}
	
}
