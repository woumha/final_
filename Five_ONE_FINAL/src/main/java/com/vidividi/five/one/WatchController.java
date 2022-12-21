package com.vidividi.five.one;

import java.io.IOException;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.view.AbstractView;

import com.fasterxml.jackson.core.JsonParser;
import com.vidividi.model.WatchDAO;
import com.vidividi.service.FormatCnt;
import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.GoodDTO;
import com.vidividi.variable.VideoPlayDTO;

import lombok.RequiredArgsConstructor;

//@RequiredArgsConstructor
@Controller
public class WatchController{

	@Inject
	private WatchDAO dao;
	
	
    Logger logger = LoggerFactory.getLogger(this.getClass());

    private String url = "보여줄 비디오 url 경로";
    

//    @RequestMapping(value = "/video/{name}")
//    public ResponseEntity<ResourceRegion> getVideo(@RequestHeader HttpHeaders headers, @PathVariable String name) throws IOException {
//        logger.info("VideoController.getVideo");
//        
//
//        UrlResource video = new UrlResource("file:(기본 경로 입력)"+name+".mp4");
//        ResourceRegion resourceRegion;
//
//        final long chunkSize = 1000000L;
//        long contentLength = video.contentLength();
//
//        Optional<HttpRange> optional = headers.getRange().stream().findFirst();
//        HttpRange httpRange;
//        if (optional.isPresent()) {
//            httpRange = optional.get();
//            long start = httpRange.getRangeStart(contentLength);
//            long end = httpRange.getRangeEnd(contentLength);
//            long rangeLength = Long.min(chunkSize, end - start + 1);
//            resourceRegion = new ResourceRegion(video, start, rangeLength);
//        } else {
//            long rangeLength = Long.min(chunkSize, contentLength);
//            resourceRegion = new ResourceRegion(video, 0, rangeLength);
//        }
//
//        return ResponseEntity.status(HttpStatus.PARTIAL_CONTENT)
//                .contentType(MediaTypeFactory.getMediaType(video).orElse(MediaType.APPLICATION_OCTET_STREAM))
//                .body(resourceRegion);
//    }

	
	
	
	
	
	@RequestMapping("watch.do")
	public String watch(@RequestParam("video_code") String video_code,@RequestParam(value="playlist_code", required = false) String playList_code,
			Model model, @SessionAttribute(name = "RepChannelCode", required = false) String repChannelCode) {
		
		
		// 재생목록 체크
		if(playList_code == null) {
		}else {
			List<VideoPlayDTO> playList = this.dao.getPlayList(playList_code);
			model.addAttribute("playList_dto", playList);
		}
		
		VideoPlayDTO video_dto = this.dao.getVideo(video_code);
		
		// 로그인 체크
		if(repChannelCode == null) {
			System.out.println("로그인 null");
		}else {
			SubscribeDTO subscribe_dto = this.dao.getSubscribe(video_dto.getChannel_code() , repChannelCode);
			GoodDTO good_dto = this.dao.getGood(video_code, repChannelCode);
			model.addAttribute("subscribe_dto", subscribe_dto);
			model.addAttribute("good_dto", good_dto);
		}
		
		
		
		int reply_count = this.dao.getReplyCount(video_code);
		
		
		model.addAttribute("video_dto", video_dto);
		model.addAttribute("reply_count", reply_count);
		
		return "/watch/watch";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "reply.do" , produces = "application/text; charset=UTF-8")
	public String getReplyList(@RequestParam("video_code") String video_code, @RequestParam("reply_option") String reply_option, @RequestParam(value="channel_code", required = false) String channel_code, int page, HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");
		
		
		int rowsize = 5;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		
		
		List<ReplyDTO> list = this.dao.getReply(video_code, reply_option, channel_code, startNo, endNo);
		
		for(ReplyDTO dto : list) {
			
			JSONObject json = new JSONObject();
			
			int comment_count = this.dao.getCommentCount(video_code, dto.getReply_group());
			
			json.put("channel_code", dto.getChannel_code());
			json.put("channel_name", dto.getChannel_name());
			json.put("channel_profil", dto.getChannel_profil());
			json.put("reply_no", dto.getReply_no());
			json.put("reply_cont", dto.getReply_cont());
			json.put("reply_comment", dto.getReply_comment());
			json.put("reply_regdate", dto.getReply_regdate());
			json.put("reply_update", dto.getReply_update());
			json.put("reply_good", dto.getReply_good());
			json.put("reply_bad", dto.getReply_bad());
			json.put("reply_group", dto.getReply_group());
			json.put("comment_count", comment_count);
			
			
			jArray.add(json);
		}
			
		
		
			
//			for(int i=0; i<jArray.size(); i++) {
//				result += jArray.toJSONString();
//			}
		
			
		return jArray.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "comment.do" , produces = "application/text; charset=UTF-8")
	public String getComment(String video_code, String reply_group, int page, HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");
		
		int rowsize = 10;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		
		List<ReplyDTO> list = this.dao.getComment(video_code, reply_group, startNo, endNo);
		
		for(ReplyDTO dto : list) {
			
			JSONObject json = new JSONObject();
			
			json.put("channel_code", dto.getChannel_code());
			json.put("channel_name", dto.getChannel_name());
			json.put("channel_profil", dto.getChannel_profil());
			json.put("reply_code", dto.getReply_no());
			json.put("reply_cont", dto.getReply_cont());
			json.put("reply_comment", dto.getReply_comment());
			json.put("reply_regdate", dto.getReply_regdate());
			json.put("reply_update", dto.getReply_update());
			json.put("reply_good", dto.getReply_good());
			json.put("reply_bad", dto.getReply_bad());

			jArray.add(json);
		}
		
		
		return jArray.toJSONString();
	}
	
	@ResponseBody
	@RequestMapping("nav_list.do")
	public List<VideoPlayDTO> getNavListAll(@RequestParam(value="navOption", required = false) String navOption, @RequestParam(value="channel_code", required = false) String channel_code, @RequestParam(value="category_code", required = false) String category_code) {
		
		List<VideoPlayDTO> list = this.dao.getNavList(navOption, channel_code, category_code);
		
		return list;
	}
	
	
	
	@RequestMapping("test.do")
	public String test() {
		return "/watch/test";
	}
	
	@RequestMapping("test2.do")
	public String test(HttpServletRequest request, Model model) {
		
		String field = request.getParameter("field");
		String keyword = request.getParameter("keyword");
		
		model.addAttribute("field", field);
		model.addAttribute("keyword", keyword);
		
		
		return "/watch/test2";
	}
	
	
	

	

	
}
