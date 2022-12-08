package com.vidividi.five.one;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.vidividi.model.*;
import com.vidividi.variable.*;


@Controller
public class myPageController {

	@Inject
	private MyPageDAO dao;

	@RequestMapping("myPage_go.do")
	public String myPage_go(
			@RequestParam("channel_code") String code,
			Model model) {
		
		
		
		// 동영상 리스트 불러오기
		List<VideoPlayDTO> history_list = this.dao.getHistory_list(code);
		List<VideoPlayDTO> playlist_list = this.dao.getPlaylist_list(code);
		List<VideoPlayDTO> good_list = this.dao.getGood_list(code);
		
		model.addAttribute("h_list", history_list);
		model.addAttribute("p_list", playlist_list);
		model.addAttribute("g_list", good_list);
		
		// 댓글 목록 불러오기
		List<ReplyDTO> reply_list = this.dao.getReply_list(code);
		model.addAttribute("reply_list", reply_list);
		
		// 해당 유저 채널정보 불러오기
		ChannelDTO m_channel = this.dao.getChannel_info(code);
		model.addAttribute("m_channel", m_channel);
		System.out.println("member_code >>> "+code);
		System.out.println("m_channel.getChannel_code() >>> "+m_channel.getChannel_code());
		
		// 해당 유저 채널에 업로드 되어 있는 동영상 불러오기
		String channel_code = m_channel.getChannel_code();
		List<VideoPlayDTO> channel_video = this.dao.getChannel_video(channel_code);
		model.addAttribute("channel_video", channel_video);
		
		// 해당 유저 채널을 구독자 수
		List<SubscribeDTO> channel_sub = this.dao.getChannel_sub(channel_code);
		model.addAttribute("channel_sub", channel_sub);

		return "myPage/myPage";
	}

	@RequestMapping("history_list.do")
	public String history_list(@RequestParam("channel_code") String code, Model model) {

		// 동영상 리스트 불러오기
		List<VideoPlayDTO> history_list = this.dao.getHistory_list(code);
		model.addAttribute("h_list", history_list);
		
		return "myPage/history";
	}

	@RequestMapping("playlist_list.do")
	public String playlist_list(@RequestParam("channel_code") String code,
								@RequestParam("playlist_no") int no,
								Model model) {
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("code", code);
		map.put("no", no);
		
		// 현재 세션의 채널, 선택한 재생목록no 에 해당하는 video_play 리스트 불러오기
		List<VideoPlayDTO> playlist_list = this.dao.getPlaylist_no(map);
		model.addAttribute("playlist_list", playlist_list);
		model.addAttribute("playlist_no", no);
		model.addAttribute("channel_code", code);
		
		
		return "myPage/playlist";
	}
	@RequestMapping("playlist_search.do")
	public String search(@RequestParam("channel_code") String code,
						@RequestParam("playlist_no") int no,
						@RequestParam("keyword") String keyword,
						HttpServletRequest request, Model model) {
		
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("code", code);
		map.put("no", no);
		
		List<VideoPlayDTO> search_playlist = this.dao.searchPlaylist(map);
		
		model.addAttribute("playlist_list", search_playlist);
		model.addAttribute("channel_code", code);
		model.addAttribute("playlist_no", no);
		
		return "myPage/playlist";
	}
	@RequestMapping("reply_list.do")
	public String reply_list() {

		return "myPage/reply";
	}

	@RequestMapping("good_list.do")
	public String good_list() {

		return "myPage/good";
	}
	
	@RequestMapping("delete_history.do")
	public void delete_history(@RequestParam("channel_code") String code, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int check = this.dao.delete_history(code);
		
		if(check > 0) {
			out.println("<script>");
			out.println("alert('전체 시청기록 삭제 완료')");
			out.println("location.href='history_list.do?channel_code=995'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('전체 시청기록 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	@RequestMapping("delete_playlist.do")
	public void delete_history(@RequestParam("channel_code") String code,
								@RequestParam("playlist_no") int no,
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
	
	
	@RequestMapping("history_search.do")
	public String search(@RequestParam("channel_code") String code,
						@RequestParam("keyword") String keyword,
						HttpServletRequest request, Model model) {
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("code", code);
		
		List<VideoPlayDTO> search_history = this.dao.searchHistory(map);
		
		model.addAttribute("h_list", search_history);
		
		return "myPage/history";
	}
	
	
	
	@RequestMapping("history_one_delete.do")
	public void delete_history(@RequestParam("video_code") int video,
								@RequestParam("channel_code") String member,
								HttpServletResponse response) throws IOException {
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("video_code", video);
		map.put("channel_code", member);
		
		// 선택된 history_num 가져오기
		int history_num = this.dao.getHistory_num(map);
		
		// 선택된 history 데이터 지우기
		int check = this.dao.history_one_delete(map);
		
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			
			this.dao.updateSequence(history_num);
			
			out.println("<script>");
			out.println("alert('시청기록 삭제 완료')");
			out.println("location.href='history_list.do?channel_code=995'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('시청기록 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	@RequestMapping("playlist_one_delete.do")
	public void delete_history(@RequestParam("video_code") String video,
								@RequestParam("channel_code") String channel,
								@RequestParam("playlist_no") int no,
								HttpServletResponse response) throws IOException {
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("video_code", video);
		map.put("channel_code", channel);
		map.put("playlist_no", no);
		
		System.out.println("video_code >>> " + video);
		System.out.println("channel_code >>> " + channel);
		System.out.println("playlist_no >>> " + no);
		
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
			out.println("location.href='playlist_list.do?channel_code="+channel+"&playlist_no="+no+"'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('재생목록 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	
	
	
	
	
	
	
}
