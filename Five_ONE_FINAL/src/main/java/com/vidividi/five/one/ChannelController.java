package com.vidividi.five.one;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
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
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.VideoPlayDTO;


@Controller
public class ChannelController {
	private userUpload up;
	
	@Inject
	private ChannelDAO dao;
	
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
	public String upload(@RequestParam("1") String title, @RequestParam("2") String context, @RequestParam("3") String playList, @RequestParam("4") String age, MultipartHttpServletRequest mRequest, Model model, HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException {
		
		System.out.println(title.trim());
		
		String lastChannelCode = (String)session.getAttribute("LastChannelCode");
		
		
		
		PrintWriter out = response.getWriter();
		System.out.println(mRequest);
		if(uploadFile.fileUpload(mRequest, lastChannelCode.trim(), title.trim())) {
			System.out.println("성공");
			
			ArrayList<String> name = new ArrayList<String>();
			String video = "";
			String img = "";
		
			
			
			// 시간이 나면 파일의 이름을 구해서 마지막을 짤라서 하나씩 다 구분해야 될듯...
			//String video_path = "pageContext.request.contextPath/resources/AllChannel/" + lastChannelCode.trim() + "/" + title.trim() + ".mp4"; // 영상 저장 경로(.jsp 기준)
			//String img_path = "pageContext.request.contextPath/resources/AllChannel/" + lastChannelCode.trim() + "/thumbnail" + title.trim() + ".png"; 
			for(int i=0; i<name.size(); i++) {
				
			}
			
			VideoPlayDTO playdto = new VideoPlayDTO();
			playdto.setVideo_code(videoCodeMaking());
			playdto.setChannel_code(lastChannelCode.trim());
			//playdto.setChannel_name();
			playdto.setVideo_title(title.trim());
			playdto.setVideo_cont(context.trim());
		
			
			
		} else {
			System.out.println("실패");
		}
		
		model.addAttribute("currentOwner", channelWorlddto);
		
		return "channel/channel_main";
		
	}
	
	public String videoCodeMaking() {
		String result = "";
		UUID uuid = UUID.randomUUID();
		result = "VD-"+uuid.toString();
		
		return result;
	}
	
	public ArrayList<String> fileName(MultipartHttpServletRequest mRequest) {
		Iterator<String> iterator = mRequest.getFileNames();
		ArrayList<String> name = new ArrayList<String>();
		while(iterator.hasNext()) {
			String uploadFileName = iterator.next();
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			String orginalFilename = mFile.getOriginalFilename();
			
			name.add(orginalFilename);
		}
		return name;
	}
}
