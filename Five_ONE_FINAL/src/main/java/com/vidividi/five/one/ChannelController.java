package com.vidividi.five.one;

import java.io.IOException;



import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.apache.catalina.connector.Response;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.vidividi.model.BundleDAO;
import com.vidividi.model.ChannelDAO;
import com.vidividi.model.VideoPlayDAO;
import com.vidividi.model.VideoPlayDAOImpl;
import com.vidividi.service.LoginService;
import com.vidividi.variable.BundleDTO;
import com.vidividi.variable.CategoryDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.PlaylistDTO;
import com.vidividi.variable.VideoPlayDTO;

import lombok.NonNull;


@Controller
public class ChannelController {
	private userUpload up;
	
	@Inject
	private ChannelDAO dao;
	
	@Inject
	private VideoPlayDAO videodao;
	
	@Inject
	private BundleDAO bundledao;
	
	@Autowired
	private LoginService service;
	
	
	@Autowired
	private UploadFile uploadFile;

	private ChannelDTO channelWorlddto;
	
	private String sendPosition;
	
	public String dynamicPath() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		return request.getServletContext().getRealPath("resources");
	}
	
	
	@RequestMapping("channel.do")
	public String channel(@RequestParam("mc") String repCcode,HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		
		String memCode = (String)session.getAttribute("MemberCode"); // 유저 코드
		
		
		if(memCode != null) {
			MemberDTO memberDTO = new MemberDTO();
			
			memberDTO.setMember_code(memCode);
			
			memberDTO.setMember_rep_channel(repCcode);
			
			
			channelWorlddto = this.dao.getChannelOwner(memberDTO); // 채널의 모든 값
			
			List<VideoPlayDTO> channelVideoDto = this.dao.getVideoList(repCcode); // 비디오 영상
			
			VideoPlayDTO newVideo = this.dao.getNewVideo(repCcode); // 가장 최근에 올린 영상
			
			model.addAttribute("currentOwner", channelWorlddto);
			model.addAttribute("currentVideo", channelVideoDto);
			model.addAttribute("currentNewVideo", newVideo);
			
			return "channel/channel_main";
		} else {
			return "main";
		}
		
	}
	
	@RequestMapping("movie_upload.do")
	public String modalUploadPage(HttpServletRequest request, HttpSession session, Model model, @RequestParam("code") String ownerCode) {
		// 업로드 모달창
		
		String repChannelCode = (String)session.getAttribute("RepChannelCode");
		// 유효성 체크 한번 해야됨
		
		
		//if(repChannelCode.equals(ownerCode)) { } else { } 식별이 필요
		ChannelDTO channelDTO = new ChannelDTO();
		channelDTO.setChannel_code(repChannelCode);
		
		List<BundleDTO> bundleList = this.bundledao.getBundleList(ownerCode); // 재생목록 리스트
		
		List<CategoryDTO> categoryList = this.videodao.getCategoryList(); // 카테고리 리스트
		
		model.addAttribute("uploadOwner", channelDTO);
		model.addAttribute("list", bundleList);
		model.addAttribute("cateList", categoryList);
		
		return "channel/movie_upload";
	}
	
	
	@RequestMapping("upload_success.do")
	public void upload(
			@RequestParam("channelCode") String channelCode,
			@RequestParam("title_field") String title, 
			@RequestParam("cont_area") String context,
			@RequestParam("category_List") String categoryList,
			@RequestParam("video_playList") String bundleCode, 
			@RequestParam("select_Age") String age, 
			@RequestParam("select_openClose") String open,
			@RequestParam("bundleText") String bundleText,
			MultipartHttpServletRequest mRequest, 
			Model model, 
			HttpServletRequest request, HttpSession session, 
			HttpServletResponse response) throws IOException {
		
		
		// categoryList: 메인 상단 카테코리
		// bundleCode: 재생 목록 코드
		// bundleText: 재생 목록 이름
		
		response.setContentType("text/html charset=UTF-8");
		
		// 현재 들어온 세션 코드와 채널 코드와 비교해서 맞아야 출력
		String lastChannelCode = (String)session.getAttribute("RepChannelCode");
		
		PrintWriter out = response.getWriter();
		
		String[] name = fileName(mRequest); // 파일명 가져오기
		
//		if(uploadFile.fileUpload(mRequest, lastChannelCode.trim(), title.trim())) {
//			System.out.println("성공");
//		} else {
//			System.out.println("실패");
//		}
		
		String cookingVideoCode = service.generateVideoCode(); // 비디오코드
		int category = Integer.parseInt(categoryList);
		
		// video_play 테이블
		VideoPlayDTO playdto = new VideoPlayDTO();
		playdto.setVideo_code(cookingVideoCode);
		playdto.setChannel_code(channelCode); // 채널 코드
		playdto.setChannel_name(channelWorlddto.getChannel_name());
		playdto.setVideo_title(title + ".mp4");
		playdto.setVideo_cont(context);
		playdto.setVideo_img(name[0]);
		playdto.setVideo_hash(null);
		playdto.setCategory_code(category); // value값 가져온다
		
		// playlist 테이블
		PlaylistDTO playbundledto = new PlaylistDTO();
		playbundledto.setChannel_code(channelCode.trim());
		playbundledto.setPlaylist_code(bundleCode.trim()); // 재생목록 코드
		playbundledto.setPlaylist_title(bundleText.trim()); // 재생목록 이름
		playbundledto.setVideo_code(cookingVideoCode.trim());
		
		
		
		if(age.trim().equals("예 아동용 입니다")) {
			playdto.setVideo_age("true");
		} else if(age.trim().equals("아니요 성인용 입니다")) {
			playdto.setVideo_age("false");
		} else {
			out.println("<script>"
					+ "alert('스크립트 오류');");
			out.println("history.back();"
					+ "</script>");
		}
		
		if(open.trim().equals("시청자들과 같이 보기")) {
			//bundledto.setPlaylist_open(1); // 재생목록 공개
			playdto.setVideo_open(0); // 비디오 공개
		} else if(open.trim().equals("나만 보기")) {
			//bundledto.setPlaylist_open(0); // 재생목록 비공개
			playdto.setVideo_open(1); // 비디오 비공개
		} else {
			out.println("<script>"
					+ "alert('스크립트 오류');");
			out.println("history.back();"
					+ "</script>");
		}
		
		System.out.println("playdto: " + playdto);
		int check = this.dao.setVideoUpload(playdto);
		
		
		System.out.println("check: " + check);
		if(check > 0 ) {
			out.println("<script>"
					+ "alert('업로드 완료');"
					+ "location.href='" + request.getContextPath() +"/channel.do?mc="+ channelWorlddto.getChannel_code() +"';");
			out.println("</script>");
		} else {
			out.println("<script>"
					+ "alert('업로드 실패');"
					+ "history.bakc();");
			out.println("</script>");
		}
		
		
	}
	
	// 영상 관리 페이지
	@RequestMapping("channel_manager.do")
	public String manager(Model model, @RequestParam("code") String code, HttpServletResponse response) {
		response.setContentType("text/html charset=UTF-8");
		
		List<VideoPlayDTO> videoList = this.dao.getVideoList(code);
		
		model.addAttribute("currentOwner", channelWorlddto);
		model.addAttribute("mvList", videoList);
	
		return "channel/channel_manager";
	}
	
	// 체널 프로필 이미지 업로드
	@RequestMapping("channel_profil.do")
	public void profilImg(Model model, HttpServletResponse response) throws IOException {
		//System.out.println("mrequest: " + mRequest);
		
		
		sendPosition = "profilChange";
		//uploadFile.fileChangeUpload(mRequest, sendPosition, chCode, dynamicPath());
		
		//int check = this.dao.setChangeChannelProfil(chCode);
		//PrintWriter out =  response.getWriter();
	}
	
	
	// 영상 수정 모달창
	@RequestMapping("video_update_modal.do")
	public String setVideoUpdate(Model model, @RequestParam("video_code") String code, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		
		VideoPlayDTO playdto = new VideoPlayDTO();
		
		playdto = this.videodao.getVideoOne(code); // 비디오 코드
		
		// 영상 코드의 주인
		List<PlaylistDTO> playListTitle = this.dao.getPlayList(playdto.getChannel_code()); // 재생목록 리스트
		
		
		model.addAttribute("list", playdto);
		model.addAttribute("playBundle", playListTitle);
		
		
		return "channel/channel_update_modal";
	}
	
	
	// 영상 수정 완료
	@RequestMapping("video_update_success.do")
	public void setVideoUpdateSuccess(MultipartHttpServletRequest mRequest,
			@RequestParam("video_code") String code, 
			@RequestParam("video_title") String title, 
			@RequestParam(value="video_cont", required = false) String cont,
			@RequestParam("video_playList") String list,
			@RequestParam("flexRadioDefault_age") String age,
			@RequestParam("flexRadioDefault_openClose") String open,
			@RequestParam("channel_code") String channelCode) {
		
		
		String position = "uploadMVChange";
		
		VideoPlayDTO playdto = new VideoPlayDTO();
		playdto.setVideo_code(code);
		playdto.setVideo_title(title);
		playdto.setVideo_cont(cont);
		// list는 재생목록에
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
