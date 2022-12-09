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
import org.springframework.web.servlet.view.AbstractView;


import com.fasterxml.jackson.core.JsonParser;
import com.vidividi.model.WatchDAO;
import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.ChannelDTO;
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
	public String watch(@RequestParam("video_code") String video_code, Model model) {
		
		VideoPlayDTO video_dto = this.dao.getVideo(video_code);
		
		ChannelDTO channel_dto = this.dao.getChannel(video_dto.getChannel_code());
		
		String channel_good = format(channel_dto.getChannel_like()); 
		
		
		model.addAttribute("video_dto", video_dto);
		model.addAttribute("channel_dto", channel_dto);
		model.addAttribute("channel_good", channel_good);
		
		return "/watch/watch";
	}
	
	
	@ResponseBody
	@RequestMapping("reply.do")
	public String getReplyList(@RequestParam("video_code") String video_code, @RequestParam("video_option") String video_option) {
		
		System.out.println("매핑완료");
		
		System.out.println("code >>> " +video_code);
		System.out.println("option >>> " +video_option);

		JSONObject result = new JSONObject();
		
		JSONArray jArray = new JSONArray();
		
		
		List<ReplyDTO> list = this.dao.getReply(video_code, video_option);
		
		for(ReplyDTO dto : list) {
			
			JSONObject json = new JSONObject();
			
			json.put("channel_code", dto.getChannel_code());
			json.put("channel_name", dto.getChannel_name());
			json.put("channel_profil", dto.getChannel_profil());
			json.put("reply_no", dto.getReply_no());
			json.put("reply_cont", dto.getReply_cont());
			json.put("reply_regdate", dto.getReply_regdate());
			json.put("reply_update", dto.getReply_update());
			json.put("reply_good", dto.getReply_good());
			json.put("reply_bad", dto.getReply_bad());
		
			
			jArray.add(json);
		}
			
		
		
			
			
//			for(int i=0; i<jArray.size(); i++) {
//				result += jArray.toJSONString();
//			}
		
			result.put("datas", jArray);
		
			System.out.println("===================");
			System.out.println(result);
			
			
			
			
		return result.toString();
	}
	
//	@ResponseBody
//	@RequestMapping("reply.do")
//	public List<ReplyDTO> getReplyList(@RequestParam("video_code") String video_code, @RequestParam("video_option") String video_option) {
//		
//		System.out.println("매핑완료");
//		
//		System.out.println("code >>> " +video_code);
//		System.out.println("option >>> " +video_option);
//		
//		JSONArray jArray = new JSONArray();
//		
//		List<ReplyDTO> list = this.dao.getReply(video_code, video_option);
//		
//		return list;
//	}
//	
//	@RequestMapping("test.do")
//	public String test() {
//		
//		return "watch/test";
//	}
	
	  @RequestMapping("test.do")
	  public String test() {
		 
		  return "search/test"; 
	  }
	

	
	public String format(int no) {
		
		String result = "";
		
		DecimalFormat df = new DecimalFormat("#.#");
		
		if(no >= 10000000) {
			
			result = df.format(no/10000000.0) +"천 만";
			
		}else if(no >= 10000) {
			result = df.format(no/10000.0) +"만";
		}else if(no >= 1000) {
			result = df.format(no/1000.0) +"천";
		}else {
			result = String.valueOf(no);
		}
		return result;
	}
	
}
