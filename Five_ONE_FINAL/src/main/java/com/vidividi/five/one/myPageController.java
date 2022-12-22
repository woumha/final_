package com.vidividi.five.one;

import java.io.*;

import java.util.*;
import javax.inject.Inject;
import javax.servlet.http.*;

import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.vidividi.model.*;
import com.vidividi.variable.*;


@Controller
public class myPageController {

	@Inject
	private MyPageDAO dao;

	/* 테스트 경로 */
	@RequestMapping("myPage_test.do")
	public String go_test() {

		return "myPage/test";
	}
	
	
	@RequestMapping("myPage_go.do")
	public String myPage_go(@RequestParam(value="channel_code", required=false, defaultValue="none") String code,
							Model model) {
		
		if(code.equals("none")) {
			System.out.println("channel_code 없음!!!");
			System.out.println("channel_code >>> " + code);
		} else {
			
		// 동영상 리스트 불러오기
		List<VideoPlayDTO> history_list = this.dao.getHistory_list(code);
		List<PlaylistDTO> playlist_list = this.dao.getPlaylist_list(code);
		List<VideoPlayDTO> good_list = this.dao.getGood_list(code);
		
		// 댓글 목록 불러오기
		List<ReplyDTO> reply_list = this.dao.getReply_list(code);

		// 해당 유저 채널정보 불러오기
		ChannelDTO m_channel = this.dao.getChannel_info(code);

		System.out.println("member_code >>> "+code);
		System.out.println("m_channel.getChannel_code() >>> "+m_channel.getChannel_code());
		
		// 해당 유저 채널에 업로드 되어 있는 동영상 불러오기
		String channel_code = m_channel.getChannel_code();
		List<VideoPlayDTO> channel_video = this.dao.getChannel_video(channel_code);
		
		// 해당 유저 채널을 구독자 수
		List<SubscribeDTO> channel_sub = this.dao.getChannel_sub(channel_code);
		
		model.addAttribute("h_list", history_list);
		model.addAttribute("p_list", playlist_list);
		model.addAttribute("g_list", good_list);
		model.addAttribute("reply_list", reply_list);
		model.addAttribute("m_channel", m_channel);
		model.addAttribute("channel_video", channel_video);
		model.addAttribute("channel_sub", channel_sub);
		
		// ---- 삭제 할 예정
		model.addAttribute("channel_code", code);
		// ----
		}
		
		return "myPage/myPage";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "getPlaylist_list.do" , produces = "application/text; charset=UTF-8")
	public String getReplyList(@RequestParam(value="channel_code",  required=false, defaultValue="none") String code,
							   int page, HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");

		int rowsize = 10;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<VideoPlayDTO> list = null;
		
		JSONArray jArray = new JSONArray();
		
		list = this.dao.getPlayList_list(code, startNo, endNo);

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
			json.put("playlist_title", dto.getPlayList_title());
			json.put("playlist_code", dto.getPlayList_code());
			jArray.add(json);
		}
		return jArray.toString();
	}
	

	@RequestMapping("playlist_list.do")
	public String playlist_list(@RequestParam("channel_code") String code,
								@RequestParam("playlist_code") String no,
								Model model) {
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("code", code);
		map.put("no", no);
		
		// 현재 세션의 채널, 선택한 재생목록no 에 해당하는 video_play 리스트 불러오기
		List<VideoPlayDTO> playlist_list = this.dao.getPlaylist_no(map);
		model.addAttribute("playlist_list", playlist_list);
		model.addAttribute("playlist_code", no);
		model.addAttribute("channel_code", code);
		
		
		return "myPage/playlist";
	}
	@RequestMapping("playlist_search.do")
	public String search(@RequestParam("channel_code") String code,
						@RequestParam("playlist_code") int no,
						@RequestParam("keyword") String keyword,
						HttpServletRequest request, Model model) {
		
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("code", code);
		map.put("no", no);
		
		List<VideoPlayDTO> search_playlist = this.dao.searchPlaylist(map);
		
		model.addAttribute("playlist_list", search_playlist);
		model.addAttribute("channel_code", code);
		model.addAttribute("playlist_code", no);
		
		return "myPage/playlist";
	}

	@RequestMapping("delete_playlist.do")
	public void delete_history(@RequestParam("channel_code") String code,
								@RequestParam("playlist_code") String no,
								HttpServletResponse response) throws IOException {
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("code", code);
		map.put("no", no);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int check = this.dao.delete_playlist(map);
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('재생목록 삭제 완료')");
			out.println("location.href='myPage_go.do?channel_code="+code+"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('재생목록 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	@RequestMapping("playlist_one_delete.do")
	public void delete_history(@RequestParam("video_code") String video,
								@RequestParam("channel_code") String channel,
								@RequestParam("playlist_code") String no,
								HttpServletResponse response) throws IOException {
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("video_code", video);
		map.put("channel_code", channel);
		map.put("playlist_code", no);
		
		System.out.println("video_code >>> " + video);
		System.out.println("channel_code >>> " + channel);
		System.out.println("playlist_code >>> " + no);
		
		// 선택된 playlist_num 가져오기
		int playlist_num = this.dao.getPlayList_num(map);
		
		// 선택된 playlist_num 데이터 지우기
		int check = this.dao.playlist_one_delete(map);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			this.dao.updateSequence_p(playlist_num);
			
			out.println("<script>");
			out.println("alert('재생목록 삭제 완료')");
			out.println("location.href='playlist_list.do?channel_code="+channel+"&playlist_code="+no+"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('재생목록 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	
	@RequestMapping("subscribe_list.do")
	public String subscribe_list(@RequestParam(value="member_code", required=false, defaultValue="none") String code, Model model) {
		
		if(code.equals("none")) {
			System.out.println("member_code 없음!!!");
		}else {
			System.out.println("member_code 있음!!!");
			// 구독 리스트 불러오기
			List<ChannelDTO> subscribe_list = this.dao.getSubscribe_list(code);
			
			model.addAttribute("subscribe_list", subscribe_list);
			model.addAttribute("member_code", code);
		}
		return "myPage/subscribe";
	}
		
	@RequestMapping("subscribe_one_delete.do")
	public void subscribe_one_delete(@RequestParam("member_code") String member,
									@RequestParam("channel_code") String channel, HttpServletResponse response) throws IOException {
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("member_code", member);
		map.put("channel_code", channel);

		// 선택한 구독 번호 불러오기
		int num = this.dao.getSubscribe_num(map);
		
		System.out.println("================================================");
		System.out.println("테스트 subscribe_num >>> " + num);
		System.out.println("================================================");
		
		// 선택한 구독 삭제
		int check = this.dao.subscribe_one_delete(num);
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			this.dao.updateSequence_s(num);
			out.println("<script>");
			out.println("location.href='subscribe_list.do?member_code="+member+"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('구독 해제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}	

}
