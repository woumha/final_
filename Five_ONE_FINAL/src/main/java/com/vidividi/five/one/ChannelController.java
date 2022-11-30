package com.vidividi.five.one;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChannelController {
	
	@RequestMapping("chennel.do")
	public String channel() {
		return "channel/channel_main";
	}
}
