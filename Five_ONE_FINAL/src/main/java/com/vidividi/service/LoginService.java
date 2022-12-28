package com.vidividi.service;

import javax.servlet.http.HttpSession;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.GoogleLoginDTO;
import com.vidividi.variable.KakaoLoginDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.NaverLoginDTO;

public interface LoginService {
	
	String loginCheck(LoginDTO dto, HttpSession session) throws Exception;
	String socialLogin(GoogleLoginDTO gdto, HttpSession session) throws Exception;
	String socialLogin(KakaoLoginDTO kdto, HttpSession session) throws Exception;
	String socialLogin(NaverLoginDTO ndto, HttpSession session) throws Exception;
	void logout(HttpSession session);
	int joinIdCheck(String id);

	String generateMembercode();
	String generateChannelCode();
	String generateVideoCode();
	String generatePWD(int size);
	String insertMember(MemberDTO dto, String via, String socialPsa);
	String generateBundleCode(); // 재생목록 코드
	String generateSubscribe();
	
	ChannelDTO newChannel(String memberCode, String channelCode, String memberName, String socialPsa);
	int getAge(String date);
  
	String generateGoodCode();
	String generateSubscribeCode();
	String generateFeedbackCode();
	String generateReplyCode();
	String generateReplyGroupCode();
}
