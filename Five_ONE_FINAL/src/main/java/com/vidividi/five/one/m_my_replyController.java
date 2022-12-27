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
public class m_my_replyController {
	
	@Inject
    private MyPageDAO dao;
	
	@RequestMapping("my_reply.do")
	public String subscribe_page(@RequestParam(value="channel_code",  required=false, defaultValue= "none") String channel_code,
							Model model) {
		model.addAttribute("channel_code", channel_code);
		return "myPage/my_reply";
	}
	
	@ResponseBody
	@RequestMapping(value = "getMy_reply_list.do" , produces = "application/text; charset=UTF-8")
	public String getSubscribe_list(@RequestParam("channel_code") String code,
									int page, HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");
		
		int rowsize = 10;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		
		List<ReplyDTO> list = null;
		
		list = this.dao.getMy_reply_list(code, startNo, endNo);

		for(ReplyDTO dto : list) {
			JSONObject json = new JSONObject();
			json.put("video_code", dto.getVideo_code());
			json.put("reply_code", dto.getChannel_code());
			json.put("reply_comment", dto.getReply_comment());	
			json.put("reply_cont", dto.getReply_cont());	
			json.put("member_code", dto.getMember_code());	
			json.put("member_name", dto.getMember_name());	
			json.put("reply_regdate", dto.getReply_regdate());	
			json.put("reply_update", dto.getReply_update());	
			json.put("channel_code", dto.getChannel_code());	
			json.put("channel_name", dto.getChannel_name());	
			json.put("channel_profil", dto.getChannel_profil());	
			json.put("reply_good", dto.getReply_good());	
			json.put("reply_bad", dto.getReply_bad());	
			json.put("reply_group", dto.getReply_group());
			json.put("video_title", dto.getVideo_title());
			json.put("video_img", dto.getVideo_img());
			
			jArray.add(json);
		}
		
		return jArray.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "delete_one_my_reply.do" , produces = "application/text; charset=UTF-8")
	public String delete_one_subscribe(@RequestParam("channel_code") String channel,
									@RequestParam("reply_code") String reply,
									@RequestParam("reply_group") String group,
									@RequestParam("reply_comment") int comment,
									int page, HttpServletResponse response) throws IOException {
		
		response.setContentType("text/html; charset=UTF-8");
		
		int rowsize = 10;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		System.out.println("channel_code >>> " + channel);
		System.out.println("reply_code >>> " + reply);
		System.out.println("reply_group >>> " + group);
		
		Map<String,Object>map = new HashMap<String,Object>();
		
		// 접속중인 채널 코드
		map.put("channel", channel);
		
		// reply_code (댓글 고유코드)
		map.put("reply", reply);
		
		// reply_group (댓글 그룹이름)
		map.put("group", group);
		
		// 만약 대댓글이 있는 댓글이라면
		if(comment == 1) {
			// 댓글 그룹 삭제
			this.dao.delete_group_reply(map);
		}else {
			// 아니라면 댓글만 삭제
			this.dao.delete_one_reply(map);
		}

		JSONArray jArray = new JSONArray();
		
		List<ReplyDTO> list = null;
		
		list = this.dao.getMy_reply_list(channel, startNo, endNo);

		for(ReplyDTO dto : list) {
			JSONObject json = new JSONObject();
			json.put("video_code", dto.getVideo_code());
			json.put("reply_code", dto.getChannel_code());
			json.put("reply_comment", dto.getReply_comment());	
			json.put("reply_cont", dto.getReply_cont());	
			json.put("member_code", dto.getMember_code());	
			json.put("member_name", dto.getMember_name());	
			json.put("reply_regdate", dto.getReply_regdate());	
			json.put("reply_update", dto.getReply_update());	
			json.put("channel_code", dto.getChannel_code());	
			json.put("channel_name", dto.getChannel_name());	
			json.put("channel_profil", dto.getChannel_profil());	
			json.put("reply_good", dto.getReply_good());	
			json.put("reply_bad", dto.getReply_bad());	
			json.put("reply_group", dto.getReply_group());
			json.put("video_title", dto.getVideo_title());
			json.put("video_img", dto.getVideo_img());
			jArray.add(json);
		}
		
		return jArray.toString();
}
	  

}
