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
	public String subscribe_page(@SessionAttribute(name = "RepChannelCode", required = false) String channel_code,
							Model model) {
		return "myPage/my_reply";
	}
	
	@ResponseBody
	@RequestMapping(value = "getMy_reply_list.do" , produces = "application/text; charset=UTF-8")
	public String getSubscribe_list(@SessionAttribute(name = "RepChannelCode", required = false) String code,
									int page, HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");
		
		int rowsize = 5;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		
		List<ReplyDTO> list = null;
		
		list = this.dao.getMy_reply_list(code, startNo, endNo);

		for(ReplyDTO dto : list) {
			JSONObject json = new JSONObject();
			json.put("video_code", dto.getVideo_code());
			json.put("reply_code", dto.getReply_code());
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
			json.put("video_owner", dto.getVideo_owner());			
			
			jArray.add(json);
		}
		
		return jArray.toString();
	}
	
	@RequestMapping("my_reply_delete.do")
	public void delete_my_reply(@RequestParam("reply_code") String code,
								@SessionAttribute(name = "RepChannelCode", required = false) String channel,
								Model model, HttpServletResponse response) throws IOException {
		
		// reply_code로 reply_group, reply_comment 구하기
		String group = this.dao.getMy_reply_group(code);
		int comment = this.dao.getMy_reply_comment(code);
		
		int check = 0;
		
		if(comment == 1) {
			check = this.dao.delete_group_reply(group);
		}else {
			check = this.dao.delete_one_reply(code);
		}
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		
		if(check > 0) {
			out.println("<script>");
			out.println("location.href='my_reply.do'");
			out.println("</script>");
		}else {
			out.println("<script>");
			out.println("alert('댓글 삭제 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
	}
	
	
	  

}
