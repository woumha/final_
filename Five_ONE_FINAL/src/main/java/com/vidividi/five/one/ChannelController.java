package com.vidividi.five.one;

import java.io.File;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.json.simple.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.vidividi.model.BundleDAO;
import com.vidividi.model.ChannelDAO;
import com.vidividi.model.VideoPlayDAO;
import com.vidividi.service.LoginService;
import com.vidividi.variable.BundleDTO;
import com.vidividi.variable.CategoryDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.PlaylistDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.VideoPlayDTO;


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
	
	private String sendPosition;
	
	public String dynamicPath() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		return request.getServletContext().getRealPath("resources");
	}
	
	
	@RequestMapping("channel.do")
	public String channel(@RequestParam("mc") String channelCode,HttpServletRequest request, HttpSession session, Model model) throws Exception {
		
		String memCode = (String)session.getAttribute("MemberCode"); // 유저 코드
		String repCode = (String)session.getAttribute("RepChannelCode"); // 세션 코드
		
		// @RequestParam("mc") String channelCode 주인의 채널코드
		
		if(memCode != null) {
			ChannelDTO channeldto = this.dao.getChannelOwner(channelCode); // 1. 채널의 모든 값
			
			List<VideoPlayDTO> channelVideoDto = this.dao.getVideoList(channelCode); // 2. 비디오 영상
			int allOpen = 0;
			for(VideoPlayDTO list: channelVideoDto) {
				allOpen = allOpen + Integer.parseInt(list.getVideo_view_cnt());
			}
			channeldto.setChannel_view_cnt(allOpen);
			
			List<BundleDTO> bundle = this.bundledao.getBundleList(channelCode); // 3. 재생목록 리스트
			
			VideoPlayDTO newVideo = this.dao.getNewVideo(channelCode); // 4. 가장 최근에 올린 영상
			
			SubscribeDTO subdto = new SubscribeDTO();
			subdto.setChannel_code(channelCode);
			subdto.setMember_code(repCode);
			
			int subCheck = this.dao.checkSubscribe(subdto); // 5. 구독 여부
			
			model.addAttribute("currentOwner", channeldto);
			model.addAttribute("currentVideo", channelVideoDto);
			model.addAttribute("bundleList", bundle);
			model.addAttribute("currentNewVideo", newVideo);
			model.addAttribute("subCheck", subCheck);
			
			return "channel/channel_main";
		} else {
			return "main";
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "bundleSetList.do", produces = "application/text; charset=UTF-8")
	public String bundleVideoList(@RequestParam("bundle_Code") String bundleCode, HttpServletResponse response, HttpServletRequest request) {
		response.setContentType("text/html; charset=UTF-8");
		
		List<VideoPlayDTO> playdto = this.dao.getPlayListDetails(bundleCode);
		JSONArray jsonArray = new JSONArray();
		
		int rowsize = 4;
		int page = 0;
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page").trim());
		}
		
		if(playdto.toString() == "[]") {
			return "[]";
		} else {
			for(VideoPlayDTO dto : playdto) {
				JSONObject json = new JSONObject();
				json.put("bundle_code", dto.getBundle_code());
				json.put("bundle_title", dto.getBundle_title());
				json.put("video_code", dto.getVideo_code());
				json.put("video_title", dto.getVideo_title());
				json.put("video_regdate", dto.getVideo_regdate());
				json.put("video_view_cnt", dto.getVideo_view_cnt());
				json.put("channel_code", dto.getChannel_code());
				
				jsonArray.add(json);
			}			
		}
		return jsonArray.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "bundle_bundle_list.do", produces = "application/text; charset=UTF-8")
	public String bundleBundleList(@RequestParam("bundleCode") String code, HttpServletResponse response) {
		
		String video_code = "";
		try {
			PlaylistDTO playdto = this.dao.getBundleBundleList(code);
			
			video_code = playdto.getVideo_code();
		} catch (NullPointerException e) {
			return "null";
		}
		return video_code;
	}
	
	// 영상 업로드
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
			@RequestParam(value = "cont_area") String context,
			@RequestParam("category_List") String categoryList,
			@RequestParam(value = "video_playList", required = false) String bundleCode,
			@RequestParam("select_Age") String age, 
			@RequestParam("select_openClose") String open,
			@RequestParam(value = "bundleText") String bundleText,
			MultipartHttpServletRequest mRequest, 
			Model model, 
			HttpServletRequest request, HttpSession session, 
			HttpServletResponse response) throws IOException {
		
		
		// categoryList: 메인 상단 카테코리
		// bundleCode: 재생 목록 코드
		// bundleText: 재생 목록 이름
		
		response.setContentType("text/html charset=UTF-8");
		
		String repCode = (String)session.getAttribute("RepChannelCode");
		
		PrintWriter out = response.getWriter();
		
		String[] name = fileName(mRequest); // 파일명 가져오기
		if(!(repCode.equals(channelCode.trim()))) {
			out.println("<script>"
					+ "alert('잘못된 접근입나다.(code false)');"
					+ "location.href='" + request.getContextPath() +"/';");
			out.println("</script>");
		} else {
			if(uploadFile.fileUpload(mRequest, channelCode.trim(), title.trim())) {
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
			
			
			String age_select = age.trim().substring(0, 1); // 수정
			String open_select = open.trim().substring(0, 1); // 수정
			
			if(age.trim().equals("예 아동용 입니다")) {
				playdto.setVideo_age("t");
			} else if(age.trim().equals("아니요 성인용 입니다")) {
				playdto.setVideo_age("f");
			} else if(age_select.equals("예")) { // 수정필요
				playdto.setVideo_age("t");
			} else if(age_select.equals("아")) {
				playdto.setVideo_age("f");
			} else {
				out.println("<script>"
						+ "alert('나이 스크립트 오류');");
				out.println("history.back();"
						+ "</script>");
			}
			
			if(open.trim().equals("시청자들과 같이 보기")) {
				//bundledto.setPlaylist_open(1); // 재생목록 공개
				playdto.setVideo_open(1); // 비디오 공개
			} else if(open.trim().equals("나만 보기")) {
				//bundledto.setPlaylist_open(0); // 재생목록 비공개
				playdto.setVideo_open(0); // 비디오 비공개
			} else if(open_select.equals("시")) {
				playdto.setVideo_open(1); // 비디오 공개
			} else if(open_select.equals("나")) {
				playdto.setVideo_open(0); // 비디오 공개
			} else {
				out.println("<script>"
						+ "alert('공개 스크립트 오류');");
				out.println("history.back();"
						+ "</script>");
			}
			
			
			int check = this.dao.setVideoUpload(playdto, playbundledto);
			
			
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
		} // repCode == channel_code
	}
	
	
	// 채널 관리 페이지
	@RequestMapping("channel_manager.do")
	public String manager(Model model, @RequestParam("code") String code, HttpServletResponse response, HttpServletRequest request,
			HttpSession session) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		String memCode = (String)session.getAttribute("MemberCode"); // 유저 코드
		String repCode = (String)session.getAttribute("RepChannelCode"); // 세션 코드
		
		String path = "";
		
		PrintWriter out = response.getWriter();
		if(memCode.equals("") || repCode.equals("")) {
			path = request.getContextPath() + "/";
		} else {
			if(!(code.trim().equals(""))) {
				if(repCode.trim().equals(code.trim())) {
					MemberDTO memdto = new MemberDTO();
					memdto.setMember_rep_channel(code);
					memdto.setMember_code(memCode);
					
					ChannelDTO channelDTO =  this.dao.getChannelOwner(code); // 채널의 모든값
					List<VideoPlayDTO> videoList = this.dao.getVideoList(code); // 모든 비디오 리스트
					List<BundleDTO> bundle = this.bundledao.getBundleList(code); // 재생목록 리스트
					
					model.addAttribute("currentOwner", channelDTO);
					model.addAttribute("mvList", videoList);
					model.addAttribute("bundleList", bundle);
					path = "channel/channel_manager";
				} else {
					out.println("<script>");
					out.println("alert('접근 오류입니다.(code)');");
					out.println("location.href='"+ request.getContextPath() + "/main.do';");
					out.println("</script>");
				}
			} else if(code.trim().equals("")) {
				out.println("<script>");
				out.println("alert('세션이 만료되었습니다.');");
				out.println("location.href='"+ request.getContextPath() + "/main.do';");
				out.println("</script>");
			} else {
				path = "main";
			}
		}
		
		return path;
	}
	
	// 체널 프로필 이미지 업로드
	@RequestMapping("channel_profil.do")
	public void profilImg(Model model, HttpServletResponse response) throws IOException {
		
	}
	
	
	// 영상 수정 모달창
	@RequestMapping("video_update_modal.do")
	public String setVideoUpdate(Model model, @RequestParam("video_code") String videoCode, @RequestParam("channl_code") String channelCode, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		
		VideoPlayDTO playdto = new VideoPlayDTO();
		
		playdto = this.videodao.getVideoOne(videoCode); // 비디오 코드
		
		List<CategoryDTO> categoryList = this.videodao.getCategoryList(); // 카테고리 리스트
		List<BundleDTO> bundleList = this.bundledao.getBundleList(channelCode); // 재생목록 리스트
		
		model.addAttribute("list", playdto); // videoplay
		model.addAttribute("cateList", categoryList); // category
		model.addAttribute("playBundle", bundleList); // bundle
		
		
		return "channel/channel_update_modal";
	}
	
	// 영상(비디오) 삭제
	@ResponseBody
	@RequestMapping(value = "videoDelete.do", produces = "application/text; charset=UTF-8")
	public String videoDelete(@RequestParam("video_code") String videoCode, @RequestParam("channelCode") String channelCode, @RequestParam("title") String title, HttpServletRequest request) {
		int delCheck = this.dao.videoDelete(videoCode);
		System.out.println("영상 삭제 유무(1=t, 0=f): " + delCheck);
		if(delCheck > 0) {
			String path = request.getServletContext().getRealPath("");
			
			File dir = new File(path + "resources/AllChannel/" + channelCode + "/" + title + ".mp4");
			if(dir.exists()) {
				if(dir.delete()) {
					System.out.println("영상 삭제 완료: " + title + ".mp4");
					File imgdir = new File(path + "resources/AllChannel/" + channelCode + "/thumbnail/" + title + ".png");
					if(imgdir.exists()) {
						if(imgdir.delete()) {
							System.out.println("썸네일 삭제 완료");
						}
					} else {
						System.out.println("삭제할 썸네일 이미지는 없습니다.");
					}
				} else {
					System.out.println("영상 삭제 실패(오류)");
				}
			}
			
			List<VideoPlayDTO> videoList = this.dao.getVideoList(channelCode);
			JSONArray arr = new JSONArray();
			for(VideoPlayDTO dto : videoList) {
				JSONObject json = new JSONObject();
				json.put("video_code", dto.getVideo_code());
				json.put("channel_code", dto.getChannel_code());
				json.put("channel_name", dto.getChannel_name());
				json.put("video_title", dto.getVideo_title());
				json.put("video_cont", dto.getVideo_cont());
				json.put("video_img", dto.getVideo_img());
				json.put("video_good", dto.getVideo_good());
				json.put("video_bad", dto.getVideo_bad());
				json.put("video_view_cnt", dto.getVideo_view_cnt());
				json.put("video_hash", dto.getVideo_hash());
				json.put("video_regdate", dto.getVideo_regdate());
				json.put("video_open", dto.getVideo_open());
				json.put("category_code", dto.getCategory_code());
				json.put("video_age", dto.getVideo_age());
				
				arr.add(json);				
			}
			return arr.toString();
		}
		
		return request.getContextPath() + "/channel_manager.do?code=" + channelCode;
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
	
	
	// 재생목록 불러오기
	@ResponseBody
	@RequestMapping(value="bundleList.do", produces = "application/text; charset=UTF-8")
	public String bundleList(@RequestParam("ownerCode") String code, HttpServletResponse response) throws IOException {	
		response.setContentType("text/html; charset=UTF-8");
		
		JSONArray jsonArray = new JSONArray();
		List<BundleDTO> bundleList = this.bundledao.getBundleList(code);
		for(BundleDTO dto: bundleList) {
			JSONObject json = new JSONObject();
			json.put("bundle_code", dto.getBundle_code());
			json.put("bundle_title", dto.getBundle_title());
			json.put("bundle_regdate", dto.getBundle_regedate());
			json.put("bundle_open", dto.getPlaylist_open());
			json.put("channel_code", dto.getChannel_code());
			
			jsonArray.add(json);
		}
		return jsonArray.toString();
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "bundleMaking.do", produces = "application/text; charset=UTF-8")
	public String bundleMaking(@RequestParam("code") String code, @RequestParam("bundleN") String bundleName, HttpServletResponse response, HttpServletRequest request) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		
		String bundleCode = service.generateBundleCode();
		
		BundleDTO bundledto = new BundleDTO();
		bundledto.setBundle_code(bundleCode);
		bundledto.setBundle_title(bundleName);
		bundledto.setChannel_code(code);
		
		int check = this.bundledao.bundleAdd(bundledto);
		String arr = "";
		
		if(check > 0) {
			arr = bundleList(code, response);
		}
		
		return arr;
	}
	
	// 재생목록 삭제
	@ResponseBody
	@RequestMapping(value = "BundleDelete.do", produces = "application/text; charset=UTF-8")
	public String bundleDelete(@RequestParam("bundleCode") String code, @RequestParam("ownerCode") String ownerCode, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		int check = this.bundledao.bundleDel(code);
		String arr = "";

		if(check > 0) {
			arr = bundleList(ownerCode, response);
		} else {
			arr = "[]";
		}
		
		return arr;
	}
	
	// 재생목록에 있는 비디오 가져오기
	@ResponseBody
	@RequestMapping(value = "videoListBundle.do", produces = "application/text; charset=UTF-8")
	public String videoListBundle(@RequestParam("bundleCode") String bundleCode, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		
		
		List<VideoPlayDTO> list = this.dao.getPlayListDetail(bundleCode);
		JSONArray arr = new JSONArray();
		for(VideoPlayDTO dto : list) {
			JSONObject json = new JSONObject();
			json.put("video_code", dto.getVideo_code());
			json.put("channel_code", dto.getChannel_code());
			json.put("channel_name", dto.getChannel_name());
			json.put("video_title", dto.getVideo_title());
			json.put("video_cont", dto.getVideo_cont());
			json.put("video_img", dto.getVideo_img());
			json.put("video_good", dto.getVideo_good());
			json.put("video_bad", dto.getVideo_bad());
			json.put("video_view_cnt", dto.getVideo_view_cnt());
			json.put("video_hash", dto.getVideo_hash());
			json.put("video_regdate", dto.getVideo_regdate());
			json.put("video_open", dto.getVideo_open());
			json.put("category_code", dto.getCategory_code());
			json.put("video_age", dto.getVideo_age());
			
			arr.add(json);
		}
		
		return arr.toString();
	}
	
	// 구독 관리
	@ResponseBody
	@RequestMapping(value = "subscribe.do", produces = "application/text; charset=UTF-8")
	public String subScribe(@RequestParam Map<String, Object> map) {
		String owner = (String)map.get("ownerCode");
		String mem = (String)map.get("memCode");
		
		String subCode = service.generateSubscribeCode();
		
		SubscribeDTO subdto = new SubscribeDTO();
		
		subdto.setSubscribe_code(subCode);
		subdto.setChannel_code(owner);
		subdto.setMember_code(mem);
		
		if(this.dao.inOutSubscribe(subdto)) {
			return "insert";
		} else {
			return "delete";
		}
	}
	
	// 하나 채널 정보 수정하기(modify: json)
	@ResponseBody
	@RequestMapping(value="channelModify.do", produces = "application/text; charset=UTF-8")
	public String channelModify(@RequestParam Map<String, Object> map, Model model) {
		String channelCode = (String)map.get("channelCode");
		
		ChannelDTO dto = this.dao.getChannelOwner(channelCode);
		
		JSONObject obj = new JSONObject();
		
		obj.put("channel_code", dto.getChannel_code());
		obj.put("channel_name", dto.getChannel_name());
		obj.put("channel_banner", dto.getChannel_banner());
		obj.put("channel_profil", dto.getChannel_profil());
		obj.put("channel_cont", dto.getChannel_cont());
		obj.put("channel_like", dto.getChannel_like());
		obj.put("channel_live", dto.getChannel_live());
		obj.put("channel_date", dto.getChannel_date());
		obj.put("channel_lastupload", dto.getChannel_lastupload());
		obj.put("member_code", dto.getMember_code());
		
		model.addAttribute("jsonObj", obj);
		
		return "channel/channel_modify";
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
