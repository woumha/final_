package com.vidividi.five.one;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class myPageController {

	@RequestMapping("myPage_go.do")
	public String myPage_go() {
				
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
