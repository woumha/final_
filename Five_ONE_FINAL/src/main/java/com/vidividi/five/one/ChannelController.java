package com.vidividi.five.one;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class ChannelController {
	private userUpload up;
	
	@RequestMapping("channel.do")
	public String channel(HttpServletRequest request) throws Exception {
		//MultipartHttpServletRequest mRequest, 
		String uploadPath = request.getSession().getServletContext().getRealPath("/").concat("resources"); // 이미지를 업로드할 폴더 경로 설정 = /uploadPath/imgUpload
		
		return "channel/channel_main";
	}
	
	@RequestMapping("movie_upload.do")
	public String upload(HttpServletRequest request, Model model) {
		String a = request.getParameter("num");
		model.addAttribute("b", a);
	
		return "channel/movie_upload";
	}
	
}
