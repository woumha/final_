package com.vidividi.five.one;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.apache.catalina.connector.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.vidividi.model.ChannelDAO;
import com.vidividi.service.LoginService;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.VideoPlayDTO;


@Controller
public class ChannelController {
	private userUpload up;
	
	@Inject
	private ChannelDAO dao;
	
	
	@Autowired
	private LoginService service;
	
	
	@Autowired
	private UploadFile uploadFile;
	
	ChannelDTO channelWorlddto;
	
	
	
	@RequestMapping("channel.do")
	public String channel(
			/* @RequestParam("cha") String CurrentChannelCode, */ HttpServletRequest request, HttpSession session, Model model) throws Exception {
		//MultipartHttpServletRequest mRequest, 
		//String uploadPath = request.getSession().getServletContext().getRealPath("/").concat("resources"); // 이미지를 업로드할 폴더 경로 설정 = /uploadPath/imgUpload
		
		
		String memCode = (String)session.getAttribute("MemberCode"); // 유저 코드
		String lastChannelCode = (String)session.getAttribute("LastChannelCode"); // 마지막 채널 코드
		
		MemberDTO memberDTO = new MemberDTO();
		memberDTO.setMember_code(memCode);
		memberDTO.setMember_last_channel(lastChannelCode);
		channelWorlddto = this.dao.getChannelOwner(memberDTO); // 채널의 모든 값
		
		/* session.setAttribute("CurrentChannelCode", CurrentChannelCode); */
		
		model.addAttribute("currentOwner", channelWorlddto);
		System.out.println(channelWorlddto);
		return "channel/channel_main";
	}
	
	@RequestMapping("movie_upload.do")
	public String modalUploadPage(HttpServletRequest request, HttpSession session, Model model) {
		// 취약점 찾았다... 다른 사람이 채널코드만 바꿔서 영상 올릴수가 있다..?
		
		String lastChannelCode = (String)session.getAttribute("LastChannelCode");
		
		// 유효성 체크 한번 해야됨
		
		ChannelDTO channelDTO = new ChannelDTO();
		
		channelDTO.setChannel_code((lastChannelCode));
		model.addAttribute("uploadOwner", channelDTO);
		
		return "channel/movie_upload";
	}
	
	
	@RequestMapping("upload_success.do")
	public String upload(@RequestParam("1") String title, @RequestParam("2") String context, @RequestParam("3") String playList, @RequestParam("4") String age, @RequestParam("5") String[] hash,MultipartHttpServletRequest mRequest, Model model, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException {
		String lastChannelCode = (String)session.getAttribute("LastChannelCode");
		
		PrintWriter out = response.getWriter();
		String allHashTag = "";
		for(int i=0; i<hash.length; i++) {
			allHashTag = allHashTag + "," + hash[i];
		}
		if(uploadFile.fileUpload(mRequest, lastChannelCode.trim(), title.trim())) {
			
			
			
			VideoPlayDTO playdto = new VideoPlayDTO();
			String[] name = fileName(mRequest);
			playdto.setVideo_code(service.videoCodeMaking());
			playdto.setChannel_code(channelWorlddto.getChannel_code());//lastChannelCode
			playdto.setChannel_name(channelWorlddto.getChannel_name());
			playdto.setVideo_title(name[1]);
			playdto.setVideo_cont(context);
			playdto.setVideo_img(name[0]);
			
			playdto.setVideo_hash(allHashTag);
			playdto.setVideo_open(0); // 기본 공개 (만들어야됨)
			playdto.setCategory_code(0);
			playdto.setChannel_like(channelWorlddto.getChannel_like());
			
//			int check = this.dao.setVideoUpload(playdto);
//			if(check > 0 ) {
//				out.println("<script>"
//						+ "alert('업로드 완료');"
//						+ "location.href='" + request.getContextPath() +"/channel.do';");
//				out.println("</script>");
//			} else {
//				out.println("<script>"
//						+ "alert('업로드 실패');"
//						+ "history.bakc();");
//				out.println("</script>");
//			}
		} else {
			System.out.println("실패");
		}
		
		model.addAttribute("currentOwner", channelWorlddto);
		
		return "channel/channel_main";
		
	}
	
	// 영상 이름 받아오기
	public String[] fileName(MultipartHttpServletRequest mRequest) {
		Iterator<String> iterator = mRequest.getFileNames();
		String[] name = new String[2];
		int count = 0;
		while(iterator.hasNext()) {
			String uploadFileName = iterator.next();
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			String orginalFilename = mFile.getOriginalFilename();
			
			name[count] = orginalFilename;
			count++;
		}

		return name;
	}
	
	//해시태그
	public String[] hashTag(String context) {
		String[] hash = context.split("#");
		
		for(int i=0; i<hash.length; i++) {
			
		}
		return null;
	}
}
