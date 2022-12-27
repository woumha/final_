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
public class m_subscribeController {
	
	@Inject
    private MyPageDAO dao;
	
	@RequestMapping("subscribe.do")
	public String subscribe_page(@RequestParam(value="member_code",  required=false, defaultValue= "none") String member_code,
							Model model) {
		model.addAttribute("member_code", member_code);
		return "myPage/subscribe";
	}
	
	@ResponseBody
	@RequestMapping(value = "getSubscribe_list.do" , produces = "application/text; charset=UTF-8")
	public String getSubscribe_list(@RequestParam("member_code") String code,
									int page, HttpServletResponse response) {
		
		response.setContentType("text/html; charset=UTF-8");
		
		int rowsize = 10;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		JSONArray jArray = new JSONArray();
		
		List<ChannelDTO> list = null;
		
		list = this.dao.getSubscribe_list(code, startNo, endNo);

		for(ChannelDTO dto : list) {
			JSONObject json = new JSONObject();
			json.put("channel_code", dto.getChannel_code());
			json.put("channel_name", dto.getChannel_name());	
			json.put("channel_banner", dto.getChannel_banner());	
			json.put("channel_profil", dto.getChannel_profil());	
			json.put("channel_cont", dto.getChannel_cont());	
			json.put("channel_like", dto.getChannel_like());	
			json.put("channel_live", dto.getChannel_live());	
			json.put("channel_date", dto.getChannel_date());	
			json.put("channel_lastupload", dto.getChannel_lastupload());	
			json.put("member_code", dto.getChannel_code());	
			
			jArray.add(json);
		}
		
		return jArray.toString();
	}
	
	
	@RequestMapping(value = "delete_one_subscribe.do" , produces = "application/text; charset=UTF-8")
	public void delete_one_subscribe(@RequestParam("channel_code") String channel,
									@RequestParam("member_code") String member,
									HttpServletResponse response) throws IOException {
		
		System.out.println("channel_code >>> " + channel);
		System.out.println("member_code >>> " + member);
		
		
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("channel", channel); map.put("member", member);


		// 선택된 playlist 동영상 데이터 지우기
		int check = this.dao.delete_one_subscribe(map);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
	
		if(check > 0) {
			System.out.println("일단 하나 삭제 성공");
			// search라면
			out.println("<script>");
			out.println("location.href='subscribe.do?member_code="+member+"'");
			out.println("</script>");

		}else {
			out.println("<script>");
			out.println("alert('구독 채널 취소 중 오류 발생')");
			out.println("history.back()");
			out.println("</script>");
		}
}
	  

}
