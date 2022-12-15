package com.vidividi.service;

import javax.servlet.http.HttpSession;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.MemberDTO;

public interface LoginService {
	
	String loginCheck(LoginDTO dto, HttpSession session);
	void logout(HttpSession session);
	int joinIdCheck(String id);
	String generateMembercode();
	String videoCodeMaking();
	ChannelDTO newChannel(String memberCode, String channelCode, String memberName);
}
