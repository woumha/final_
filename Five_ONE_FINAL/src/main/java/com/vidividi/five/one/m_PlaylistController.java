package com.vidividi.five.one;

import java.io.*;
import java.util.*;
import javax.inject.*;
import javax.servlet.http.*;
import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;
import com.vidividi.model.*;
import com.vidividi.variable.*;

@Controller
public class m_PlaylistController {
	
	@Inject
    private MyPageDAO dao;
	
	@RequestMapping("playlist_list.do")
	public String history_list(@SessionAttribute(name = "RepChannelCode", required = false) String code,
							@RequestParam(value="search",  required=false, defaultValue= "1") int search,
							@RequestParam(value="playlist_code",  required=false, defaultValue= "none") String playlist_code,
							@RequestParam(value="keyword",  required=false, defaultValue= "none") String keyword, Model model) {
		model.addAttribute("channel_code", code);
		/* model.addAttribute("keyword", keyword); */
		model.addAttribute("search", search);
		model.addAttribute("playlist_code", playlist_code);
		return "myPage/playlist";
	}
	
	@ResponseBody
	@RequestMapping(value = "playlist_new.do" , produces = "application/text; charset=UTF-8")
	public String getReplyList(@RequestParam("playlist_code") String code,
								int page, HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");

		int rowsize = 5;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		
		if(code == "none") {
			System.out.println("playlist_new.do >>> channel_code 없음!!!");
		} else {
			List<VideoPlayDTO> list = this.dao.getPlaylist_new(code, startNo, endNo);
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
				
				json.put("playlist_code", dto.getPlayList_code());
				json.put("playlist_title", dto.getPlayList_title());
				
				
				jArray.add(json);
			}
		} return jArray.toString(); }
	
	@ResponseBody
	@RequestMapping(value = "playlist_search.do" , produces = "application/text; charset=UTF-8")
	public String history_search(@RequestParam(value="playlist_code",  required=false, defaultValue="none") String code,
								@RequestParam(value="keyword",  required=false, defaultValue="none") String keyword,
								int page, HttpServletResponse response) {
		response.setContentType("text/html; charset=UTF-8");
		
		int rowsize = 5;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("code", code);map.put("keyword", keyword);map.put("startNo", startNo);map.put("endNo", endNo);
		
		List<VideoPlayDTO> list = null;
		
		if(keyword.equals("none")) {
			list = this.dao.getPlaylist_new(code, startNo, endNo);
		}else {
			list = this.dao.getPlaylist_search(map);
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
			
			json.put("playlist_code", dto.getPlayList_code());
			json.put("playlist_title", dto.getPlayList_title());
			
			jArray.add(json);
		}
		return jArray.toString();
	}

	@RequestMapping("playlist_one_delete.do")
	public void delete_history(@RequestParam("video_code") String video,
								@RequestParam("playlist_code") String playlist,
								@RequestParam("search") int search,
								@RequestParam(value="keyword",  required=false, defaultValue="none") String keyword,
								HttpServletResponse response) throws IOException {
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("video", video); map.put("playlist", playlist);
		

		// 선택된 playlist 동영상 데이터 지우기
		int check = this.dao.playlist_search_one_delete(map);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			System.out.println("일단 하나 삭제 성공");
			// search라면
			if(search == 2) {
				out.println("<script>");
				out.println("location.href='playlist_list.do?search=2&keyword="+keyword+"&playlist_code="+playlist+"'");
				out.println("</script>");
			} else if(search == 1) {
				out.println("<script>");
				out.println("location.href='playlist_list.do?search=1&keyword="+keyword+"&playlist_code="+playlist+"'");
				out.println("</script>");
			}
		}else {
			out.println("<script>");
			out.println("alert('재생목록 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	@RequestMapping("delete_playlist.do")
	public void delete_history(@RequestParam("channel_code") String code,
								@RequestParam("playlist_code") String p_code,
								HttpServletResponse response) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		int check = this.dao.delete_playlist(p_code);
		if(check > 0) {
			this.dao.delete_bundlelist(p_code);
			out.println("<script>");
			out.println("location.href='myPage_go.do'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('전체 재생목록 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
}
