package com.vidividi.service;

import javax.servlet.http.HttpSession;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.MemberDTO;

public interface LoginService {
	
	String loginCheck(LoginDTO dto, HttpSession session) throws Exception;
	void logout(HttpSession session);
	int joinIdCheck(String id);
	String generateMembercode();
	String generateChannelCode();
	String generateVideoCode();
	String generatePWD(int size);
	String insertMember(MemberDTO dto, String via);
	ChannelDTO newChannel(String memberCode, String channelCode, String memberName);
	int getAge(String date);
}
