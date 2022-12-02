package com.vidividi.five.one;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class myPageController {

		@RequestMapping("myPage_go.do")
		public String myPage_go() {
			return "myPage/myPage";
		}
	
}
