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

		System.out.println("channel_code >>> "+code);

		// 해당 유저 채널에 업로드 되어 있는 동영상 불러오기
		List<VideoPlayDTO> channel_video = this.dao.getChannel_video(code);
		
		// 해당 유저 채널을 구독자 수
		List<SubscribeDTO> channel_sub = this.dao.getChannel_sub(code);
		
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
		
		List<PlaylistDTO> list = null;
		
		JSONArray jArray = new JSONArray();
		
		list = this.dao.getPlayList_list(code, startNo, endNo);

		for(PlaylistDTO dto : list) {
			JSONObject json = new JSONObject();
			json.put("channel_code", dto.getChannel_code());
			json.put("playlist_title", dto.getPlaylist_title());
			json.put("playlist_code", dto.getPlaylist_code());
			json.put("video_code", dto.getVideo_code());
			json.put("playlist_regdate", dto.getPlaylist_regdate());

			jArray.add(json);
		}
		return jArray.toString();
	}
	
	
/*	
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
		String code = this.dao.getSubscribe_code(map);
		 
		
	
		System.out.println("================================================");
		System.out.println("테스트 subscribe_code >>> " + code);
		System.out.println("================================================");
		
		// 선택한 구독 삭제
		int check = this.dao.subscribe_one_delete(code);
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		
		if(check > 0) {
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
*/
}
