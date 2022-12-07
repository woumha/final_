package com.vidividi.five.one;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vidividi.model.MyPageDAO;
import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.User_channelDTO;
import com.vidividi.variable.VideoPlayDTO;

@Controller
public class myPageController {

	@Inject
	private MyPageDAO dao;

	@RequestMapping("myPage_go.do")
	public String myPage_go(@RequestParam("member_code") int code, Model model) {
		
		int check = code;
		
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
		User_channelDTO m_channel = this.dao.getChannel_info(code);
		model.addAttribute("m_channel", m_channel);
		
		if(check > 0) {
			// 해당 유저 채널에 업로드 되어 있는 동영상 불러오기
			int channel_code = m_channel.getChannel_code();
			List<VideoPlayDTO> channel_video = this.dao.getChannel_video(channel_code);
			model.addAttribute("channel_video", channel_video);
			
			// 해당 유저 채널을 구독자 수
			List<SubscribeDTO> channel_sub = this.dao.getChannel_sub(channel_code);
			model.addAttribute("channel_sub", channel_sub);
		} else {
			
		}

		return "myPage/myPage";
	}

	@RequestMapping("history_list.do")
	public String history_list() {

		return "myPage/history";
	}

	@RequestMapping("playlist_list.do")
	public String playlist_list() {

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
}
