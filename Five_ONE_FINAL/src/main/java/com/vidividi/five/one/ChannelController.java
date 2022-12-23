package com.vidividi.five.one;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;



import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
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
import org.springframework.web.context.request.ServletWebRequest;
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
		
		model.addAttribute("uploadOwner", ownerCode);
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
		
		if(uploadFile.fileUpload(mRequest, lastChannelCode.trim(), title.trim())) {
			System.out.println("성공");
		} else {
			System.out.println("실패");
		}
		
		String cookingVideoCode = service.generateVideoCode(); // 비디오코드
		int category = Integer.parseInt(categoryList);
		String img = name[1];
		// video_play 테이블
		VideoPlayDTO playdto = new VideoPlayDTO();
		playdto.setVideo_code(cookingVideoCode.trim());
		playdto.setChannel_code(channelCode.trim()); // 채널 코드
		playdto.setVideo_title(title.trim());
		playdto.setVideo_cont(context.trim());
		if(!(img.equals(""))) {
			playdto.setVideo_img(title + ".png");			
		} else {
			playdto.setVideo_img("");
		}
		playdto.setVideo_hash(null);
		playdto.setCategory_code(category); // value값 가져온다
		
		// playlist 테이블
		PlaylistDTO playbundledto = new PlaylistDTO();
		playbundledto.setChannel_code(channelCode.trim());
		playbundledto.setPlaylist_title(bundleText.trim()); // 재생목록 이름
		playbundledto.setPlaylist_code(bundleCode.trim()); // 재생목록 코드
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
			playdto.setVideo_open(1); // 비디오 공개
		} else if(open.trim().equals("나만 보기")) {
			//bundledto.setPlaylist_open(0); // 재생목록 비공개
			playdto.setVideo_open(0); // 비디오 비공개
		} else {
			out.println("<script>"
					+ "alert('스크립트 오류');");
			out.println("history.back();"
					+ "</script>");
		}
		
		int check = this.dao.setVideoUpload(playdto, playbundledto);
		
		
		System.out.println("check: " + check);
		if(check > 0 ) {
			out.println("<script>"
					+ "alert('업로드 완료');"
					+ "location.href='" + request.getContextPath() +"/channel.do?mc="+ channelCode +"';");
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
		List<BundleDTO> bundle = this.bundledao.getBundleList(code);
		
		model.addAttribute("currentOwner", channelWorlddto);
		model.addAttribute("mvList", videoList);
		model.addAttribute("bundleList", bundle);
	
		return "channel/channel_manager";
	}
	
	// 체널 프로필 이미지 업로드
	@RequestMapping("channel_profil.do")
	public void profilImg(Model model, HttpServletResponse response) throws IOException {
		
	}
	
	
	// 영상 수정 모달창
	@RequestMapping("video_update_modal.do")
	public String setVideoUpdate(Model model, @RequestParam("video_code") String code, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		
		VideoPlayDTO playdto = new VideoPlayDTO();
		
		playdto = this.videodao.getVideoOne(code); // 비디오 코드
		
		List<CategoryDTO> categoryList = this.videodao.getCategoryList(); // 카테고리 리스트
		List<BundleDTO> bundleList = this.bundledao.getBundleList(playdto.getChannel_code()); // 재생목록 리스트
		
		model.addAttribute("list", playdto); // videoplay
		model.addAttribute("cateList", categoryList); // category
		model.addAttribute("playBundle", bundleList); // bundle
		
		
		return "channel/channel_update_modal";
	}
	
	
	// 영상, 이미지 수정시
	@RequestMapping("video_update_success.do")
	public void setVideoUpdateSuccess(MultipartHttpServletRequest mRequest,
			HttpServletResponse response,
			HttpServletRequest request,
			@RequestParam("subVideoCode") String videoCode, 
			@RequestParam("video_title") String title, 
			@RequestParam(value="video_cont", required = false) String cont,
			@RequestParam("category_List") String categoryCode,
			@RequestParam("bundleValue") String bundleValue,
			@RequestParam("bundleText") String bundleText,
			@RequestParam("select_Age") String age,
			@RequestParam("select_openClose") String open,
			@RequestParam("video_name") String video_name,
			@RequestParam("img_name") String img_name,
			@RequestParam("channelCode") String channelCode) throws IOException {
		
		
		response.setContentType("text/html charset=utf-8");
		
		String[] name = fileName(mRequest); // 파일명 가져오기
		for(int i=0; i<name.length; i++) {
			System.out.println("name: "+ name[i]);
		}
		// 파일 값 수정
		//videoCode
		VideoPlayDTO playdtoSearch = this.videodao.getVideoOne(videoCode);
		
		
		if(fileDelete(video_name.trim(), channelCode.trim(), playdtoSearch)) {
			System.out.println("삭제 성공: " + playdtoSearch.getVideo_title());
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}
		
		if(ImgDelete(img_name.trim(), channelCode.trim(), playdtoSearch)) {
			if(!(playdtoSearch.getVideo_img().trim() == null)) {
				System.out.println("삭제 성공: " + playdtoSearch.getVideo_img().trim());				
			} else {
				System.out.println("이미지가 존재하지 않습니다.");
			}
			
		} else {
			System.out.println("이미지가 존재하지 않습니다.");
		}
		
		
		if(uploadFile.fileUpload(mRequest, channelCode.trim(), title.trim())) {
			System.out.println("성공");
		} else {
			System.out.println("실패");
		}
		
		// 삭제 및 수정 끝
		
		// DB값 수정
		PrintWriter out = response.getWriter();
		
		VideoPlayDTO videodto = new VideoPlayDTO();
		videodto.setVideo_code(videoCode);
		videodto.setVideo_title(title);
		videodto.setVideo_cont(cont);
		videodto.setCategory_code(Integer.parseInt(categoryCode));
		if(!(img_name.trim().equals("파일을 선택해주세요"))) {
			videodto.setVideo_img(title.trim() + ".png");				
		} 
		
		if(age.trim().equals("예 아동용 입니다")) {
			videodto.setVideo_age("true");
		} else if(age.trim().equals("아니요 성인용 입니다")) {
			videodto.setVideo_age("false");
		} else {
			out.println("<script>"
					+ "alert('스크립트 오류');");
			out.println("history.back();"
					+ "</script>");
		}
		
		if(open.trim().equals("시청자들과 같이 보기")) {
			//bundledto.setPlaylist_open(1); // 재생목록 공개
			videodto.setVideo_open(1); // 비디오 공개
		} else if(open.trim().equals("나만 보기")) {
			//bundledto.setPlaylist_open(0); // 재생목록 비공개
			videodto.setVideo_open(0); // 비디오 비공개
		} else {
			out.println("<script>"
					+ "alert('스크립트 오류');");
			out.println("history.back();"
					+ "</script>");
		}
		
		
		PlaylistDTO playdto = new PlaylistDTO();
		playdto.setPlaylist_code(bundleValue);
		playdto.setPlaylist_title(bundleText);
		playdto.setVideo_code(videoCode);
		
		
		int check = this.videodao.updateUploadVideo(videodto, playdto);
		//int check = -1;
		System.out.println("check: " +check);
		if(check > 0) {
			out.println("<script>"
					+ "location.href ='"+ request.getContextPath() +"/channel_manager.do?code=" + channelCode +"';");
			out.println("</script>");
		} else {
			out.println("<script>"
					+ "history.back();"
					+ "</script>");
		}
		// DB값 수정 끝
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
	
	// 영상 파일 삭제
	public boolean fileDelete(String video, String channelCode, VideoPlayDTO playdtoSearch) throws IOException {
		boolean check = false;
		
		String video_dir = "/Users/maclee/Public/Spring/Github/Five_ONE_Final/Five_ONE_FINAL/src/main/webapp/resources/AllChannel/" + channelCode + "/" + playdtoSearch.getVideo_title().trim();
		File dir = new File(video_dir);
	
		if(!(video.trim().equals(playdtoSearch.getPlayList_title()))) { // 수정했을 때
			if(dir.exists()) {
				if(dir.delete()) {
					return true;
				}
			}
		}
		
		return check;
	}
	
	public boolean ImgDelete(String img, String channelCode, VideoPlayDTO playdtoSearch) {
		boolean check = false;
		if(!(playdtoSearch.getVideo_img() == null)) {
			String img_dir = "/Users/maclee/Public/Spring/Github/Five_ONE_Final/Five_ONE_FINAL/src/main/webapp/resources/AllChannel/" + channelCode + "/thumbnail/" + playdtoSearch.getVideo_img().trim();
			File dir = new File(img_dir);
			
			if(!(img.trim().equals(playdtoSearch.getVideo_img()))) {
				if(dir.exists()) {
					if(dir.delete()) {
						return true;
					}
				}
			}
		} else {
			return false;
		}
			
		return check;
	}
	
	public void res() throws IOException {
		ServletWebRequest servletContainer = (ServletWebRequest)RequestContextHolder.getRequestAttributes();
		HttpServletResponse response = servletContainer.getResponse();
		PrintWriter out = response.getWriter();
		
		out.println("<script>");
		out.println("alert('경로 오류');");
		out.println("history.back();");
		out.println("</script>");
	}
}
