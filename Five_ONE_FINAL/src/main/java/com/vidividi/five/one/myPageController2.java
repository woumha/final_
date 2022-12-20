package com.vidividi.five.one;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.inject.*;
import javax.servlet.http.*;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.vidividi.model.*;
import com.vidividi.variable.*;

@Controller
public class myPageController2 {
	
	@Inject
    private MyPageDAO dao;
	
	@RequestMapping("history_list.do")
	public String history_list(@RequestParam("channel_code") String code,
			@RequestParam(value="option",  required=false, defaultValue= "1") int option,
			@RequestParam(value="keyword",  required=false, defaultValue= "none") String keyword,
			Model model) {


		model.addAttribute("channel_code", code);
		model.addAttribute("keyword", keyword);
		model.addAttribute("option", option);
		
		
		
		return "myPage/history";
	}
	@RequestMapping("history_searchs.do")
	public String history_searchs(@RequestParam("channel_code") String code,
								@RequestParam("keyword") String keyword,
								Model model) {

		int option = 2;
		
		model.addAttribute("channel_code", code);
		model.addAttribute("keyword", keyword);
		model.addAttribute("option", option);
		 
		return "myPage/history";
	}
	
	@ResponseBody
	@RequestMapping(value = "history_new.do" , produces = "application/text; charset=UTF-8")
	public String getReplyList(@RequestParam(value="channel_code",  required=false, defaultValue="none") String code,
								int page, HttpServletResponse response) {
		
		System.out.println("history_new.do >>> 컨트롤러 진입 성공!!!");
		
		response.setContentType("text/html; charset=UTF-8");
		
		
		int rowsize = 5;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		
		if(code == "none") {
			System.out.println("history_new.do >>> channel_code 없음!!!");
		} else {

		List<VideoPlayDTO> list = this.dao.getHistoryListCount(code, startNo, endNo);
		
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

			System.out.println("controller 에서 json 정상작동!");
			
			jArray.add(json);
		}
	}
	return jArray.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "history_search.do" , produces = "application/text; charset=UTF-8")
	public String history_search(@RequestParam(value="channel_code",  required=false, defaultValue="none") String code,
								@RequestParam(value="keyword",  required=false, defaultValue="none") String keyword,
								int page, HttpServletResponse response) {
		System.out.println("history_search.do >>> 컨트롤러 진입 성공!!!");
		System.out.println("channel_code >>> " + code);
		System.out.println("keyword >>> " + keyword);
		System.out.println("page >>> " + page);
		System.out.println("==========================================================================");
		
		response.setContentType("text/html; charset=UTF-8");
		
		int rowsize = 5;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		

		Map<String,Object>map = new HashMap<String,Object>();
		map.put("code", code);
		map.put("keyword", keyword);
		map.put("startNo", startNo);
		map.put("endNo", endNo);
			
		List<VideoPlayDTO> list = this.dao.getHistory_search(map);
		System.out.println("history_seach 리스트 불러오기 성공!!!!!");
		for(VideoPlayDTO dto : list) {
			
			JSONObject json = new JSONObject();
			
			/* 갯수 새는 코드
			 * int comment_count = this.dao.getCommentCount(code, dto.getReply_group());
			 */
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
			/* json.put("comment_count", comment_count); */
			System.out.println("controller 에서 json 정상작동!");
			
			jArray.add(json);
		}

	return jArray.toString();
	}
	
	
}
