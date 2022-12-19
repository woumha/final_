package com.vidividi.five.one;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;
import javax.inject.*;
import javax.servlet.http.*;
import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.vidividi.model.*;
import com.vidividi.variable.*;

@Controller
public class m_GoodController {
	
	@Inject
    private MyPageDAO dao;
	
	@RequestMapping("good_list.do")
	public String history_list(@RequestParam("channel_code") String code,
							@RequestParam(value="search",  required=false, defaultValue= "1") int search,
							@RequestParam(value="keyword",  required=false, defaultValue= "none") String keyword,
							@RequestParam(value="option",  required=false, defaultValue= "date") String option, Model model) {
		model.addAttribute("channel_code", code);
		model.addAttribute("keyword", keyword);
		model.addAttribute("search", search);
		model.addAttribute("option", option);
		return "myPage/good";
	}
	
	@RequestMapping("good_search.do")
	public String history_search(@RequestParam("channel_code") String code,
								@RequestParam("keyword") String keyword,
								@RequestParam("option") String option,
								Model model) {
		int search = 2;
		model.addAttribute("channel_code", code);
		model.addAttribute("keyword", keyword);
		model.addAttribute("search", search);
		model.addAttribute("option", option);
		return "myPage/good";
	}
	
	@ResponseBody
	@RequestMapping(value = "good_new.do" , produces = "application/text; charset=UTF-8")
	public String getReplyList(@RequestParam(value="channel_code",  required=false, defaultValue="none") String code,
							   @RequestParam(value="option",  required=false, defaultValue="date") String option,
							   int page, HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");

		int rowsize = 5;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<VideoPlayDTO> list = null;
		
		JSONArray jArray = new JSONArray();
		
		if(option.equals("date")) {
			list = this.dao.getGoodList_date(code, startNo, endNo);
		}else if(option.equals("most")) {
			list = this.dao.getGoodList_most(code, startNo, endNo);
		}
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
			jArray.add(json);
		}
		return jArray.toString(); }
	
	@ResponseBody
	@RequestMapping(value = "good_search.do" , produces = "application/text; charset=UTF-8")
	public String history_search(@RequestParam(value="channel_code",  required=false, defaultValue="none") String code,
								@RequestParam(value="keyword",  required=false, defaultValue="none") String keyword,
								@RequestParam(value="option",  required=false, defaultValue="date") String option,
								int page, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		
		int rowsize = 5;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		
		List<VideoPlayDTO> list = null;
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("code", code);map.put("keyword", keyword);map.put("startNo", startNo);map.put("endNo", endNo);
		
		if(option.equals("date")) {
			list = this.dao.getGood_search_date(map);
		}else if(option.equals("most")) {
			list = this.dao.getGood_search_most(map);
		}
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
			jArray.add(json);
		} return jArray.toString(); }

	@RequestMapping("good_one_delete.do")
	public void delete_history(@RequestParam("video_code") int video,
								@RequestParam("channel_code") String channel,
								@RequestParam("search") int search,
								@RequestParam(value="keyword",  required=false, defaultValue="none") String keyword,
								HttpServletResponse response) throws IOException {
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("video", video); map.put("channel", channel);
		
		// 선택된 history_num 가져오기
		int history_num = this.dao.getHistory_num(map);
		
		// 선택된 history 데이터 지우기
		int check = this.dao.history_search_one_delete(history_num);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			this.dao.updateSequence(history_num);
			// search라면
			if(search == 2) {
				out.println("<script>");
				out.println("location.href='history_list.do?channel_code="+channel+"&search=2&keyword="+keyword+"'");
				out.println("</script>");
			} else if(search == 1) {
				out.println("<script>");
				out.println("location.href='history_list.do?channel_code="+channel+"&search=1&keyword="+keyword+"'");
				out.println("</script>");
			}
		}else {
			out.println("<script>");
			out.println("alert('시청기록 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	@RequestMapping("good_history.do")
	public void delete_history(@RequestParam("channel_code") String code, HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		int check = this.dao.delete_history(code);
		if(check > 0) {
			out.println("<script>");
			out.println("location.href='history_list.do?channel_code="+code+"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('전체 시청기록 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
}
