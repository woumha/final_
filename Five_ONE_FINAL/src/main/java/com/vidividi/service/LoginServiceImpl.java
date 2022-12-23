package com.vidividi.service;

import java.security.SecureRandom;

import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.springframework.stereotype.Service;

import com.vidividi.model.ChannelDAO;
import com.vidividi.model.MemberDAO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.MemberDTO;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Inject
	private MemberDAO dao;
	
	@Inject
	private ChannelDAO channelDAO;
	
	@Inject
	private LoginHistoryService lhservice;
	
	@Override
	public String loginCheck(LoginDTO dto, HttpSession session) throws Exception {
		String memberCode = dao.checkMember(dto);
		MemberDTO memberDTO = dao.getMember(dto);
		
		if (memberCode != null) {
			session.setAttribute("MemberCode", memberCode);

			System.out.println("로그인 중인 멤버 코드 : "+memberCode);
			session.setAttribute("RepChannelCode", memberDTO.getMember_rep_channel());
			System.out.println("대표 채널 코드 : "+memberDTO.getMember_rep_channel());
			
			lhservice.setLoginData(memberCode);
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
	public String generatePWD(int size) {
		char[] charSet = new char[] {
                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
                'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
                '!', '@', '#', '$', '%', '^', '&' };

        StringBuffer sb = new StringBuffer();
        SecureRandom sr = new SecureRandom();
        sr.setSeed(new Date().getTime());

        int idx = 0;
        int len = charSet.length;
        for (int i=0; i<size; i++) {
            idx = sr.nextInt(len); 
            sb.append(charSet[idx]);
        }

        return sb.toString();
	}
	
	@Override
	public String insertMember(MemberDTO dto, String via) {
		
		String result = "";
		
		dto.setMember_code(generateMembercode());
		dto.setMember_rep_channel(generateChannelCode());
		
		if (via == "google") {
			dto.setMember_google_link("1");
			dto.setMember_pwd(generatePWD(10));
		}else if (via == "joinForm"){
			dto.setMember_name(dto.getMember_id());
			dto.setMember_email("");
			dto.setMember_google_link("0");
		}
		
		int joinResult = dao.joinMember(dto);
		System.out.println("회원 가입 결과 : " +joinResult);
		
		ChannelDTO channelDTO = newChannel(dto.getMember_code(), dto.getMember_rep_channel(), dto.getMember_name());
		channelDAO.insertChannel(channelDTO);
		
		if (joinResult != 0) {
			result = dto.getMember_code();
			System.out.println("반환되는 멤버코드 : "+result);
		}else if (joinResult == 0) {
			result = "fail";
		}
		
		return result;
	}	

	//재생목록 코드
	@Override
	public String generateBundleCode() {
		String result = "";
		UUID uuid = UUID.randomUUID();
		result = "BC-" + uuid.toString(); // Bundle Code
		
		System.out.println("새로 생성된 재생목록 코드: " + result);
		
		return result;
	}
	
	// 비디오 좋아요 코드
	@Override
	public String generateGoodCode() {
		String result = "";
		UUID uuid = UUID.randomUUID();
		result = "GO-"+uuid.toString();
		
		System.out.println("새로 생성된 좋아요 코드 : "+result);
		
		return result;

	}

	@Override
	public ChannelDTO newChannel(String memberCode, String channelCode, String memberName) {
		
		ChannelDTO channelDTO = new ChannelDTO();
		
		channelDTO.setMember_code(memberCode);
		channelDTO.setChannel_code(channelCode);
		
		int countChannel = channelDAO.countMemberChannel(memberCode);
		
		String channelName = memberName + "님의 "+(countChannel+1)+"번째 채널입니다.";
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
