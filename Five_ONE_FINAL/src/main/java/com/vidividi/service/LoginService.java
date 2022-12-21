package com.vidividi.service;

import javax.servlet.http.HttpSession;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.MemberDTO;

public interface LoginService {
	
	String loginCheck(LoginDTO dto, HttpSession session);
	void logout(HttpSession session);
	int joinIdCheck(String id);
	String generateMembercode(); // 멤버 코드
	String generateChannelCode(); // 채널 코드
	String generateVideoCode(); // 비디오 코드
	String generateBundleCode(); // 재생목록 코드
	ChannelDTO newChannel(String memberCode, String channelCode, String memberName);
	int getAge(String date);

}
