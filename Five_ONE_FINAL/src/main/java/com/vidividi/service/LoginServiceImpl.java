package com.vidividi.service;

import java.util.Calendar;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.stereotype.Service;

import com.vidividi.model.MemberDAO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.MemberDTO;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Inject
	private MemberDAO dao;
	
	@Override
	public String loginCheck(LoginDTO dto, HttpSession session) {
		String memberCode = dao.checkMember(dto);
		MemberDTO memberDTO = dao.getMember(dto);
		
		if (memberCode != null) {
			session.setAttribute("MemberCode", memberCode);

			System.out.println("로그인 중인 멤버 코드 : "+memberCode);
			session.setAttribute("RepChannelCode", memberDTO.getMember_rep_channel());
			System.out.println("대표 채널 코드 : "+memberDTO.getMember_rep_channel());
		}
		
		return memberCode;
	}

	@Override
	public void logout(HttpSession session) {
		if (session.getAttribute("MemberCode") != null) {
						
			/*
			 * if (memberCode != null) { if (lastChannelCode != null) {
			 * memberDTO.setMember_last_channel(lastChannelCode);
			 * dao.updateLastChannel(memberDTO); } }
			 */
			session.invalidate();
			System.out.println("로그인 세션 만료됨");
		}
	}
	
	@Override
	public int joinIdCheck(String id) {
		int idCheck = dao.joinIdCheck(id);
		System.out.println("count(*) :"+idCheck);
		return idCheck;
	}
	
	// 멤버 코드
	@Override
	public String generateMembercode() {
		String result = "";
		UUID uuid = UUID.randomUUID();
		result = "VD-"+uuid.toString();
		
		System.out.println("새로 가입하는 멤버 코드 : "+result);
		
		return result;
	}

	// 채널 코드
	@Override
	public String generateChannelCode() {
		String result = "";
		UUID uuid = UUID.randomUUID();
		result = "CH-"+uuid.toString();
		
		System.out.println("새로 생성된 채널 코드 : "+result);
		
		return result;
	}
	
	// 비디오 코드
	@Override
	public String generateVideoCode() {
		String result = "";
		UUID uuid = UUID.randomUUID();
		result = "MV-"+uuid.toString();
		
		System.out.println("새로 생성된 비디오 코드 : "+result);
		
		return result;
	}

	@Override
	public ChannelDTO newChannel(String memberCode, String channelCode, String memberName) {
		
		ChannelDTO channelDTO = new ChannelDTO();
		
		channelDTO.setMember_code(memberCode);
		channelDTO.setChannel_code(channelCode);
		String channelName = memberName + "님의 채널입니다.";
		channelDTO.setChannel_name(channelName);
		
		return channelDTO;
	}
	
	
	@Override
	public int getAge(String date) {
		
		String temp = date.substring(0, 10);
		String birth[] = temp.split("-");
		
		int birthYear = Integer.parseInt(birth[0]);
		int birthMonth = Integer.parseInt(birth[1]);
		int birthDay = Integer.parseInt(birth[2]);
		
		Calendar today = Calendar.getInstance();
		
		int todayYear = today.get(Calendar.YEAR);
		int todayMonth = today.get(Calendar.MONTH);
		int todayDay = today.get(Calendar.DAY_OF_MONTH);
		
		int age = todayYear - birthYear;
		if (birthMonth * 100 + birthDay > todayMonth * 100 + todayDay) {
			age = age - 1;
		}
		
		return age;
	}
	
}
