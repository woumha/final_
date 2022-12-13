package com.vidividi.service;

import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.vidividi.model.MemberDAO;
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
			session.setAttribute("LastChannelCode", memberDTO.getMember_last_channel());
		}
		
		return memberCode;
	}

	@Override
	public void logout(HttpSession session) {
		
		if (session.getAttribute("MemberCode") != null) {
			String memberCode = (String)session.getAttribute("MemberCode");
			String currentChannelCode = (String)session.getAttribute("CurrentChannelCode");
			MemberDTO memberDTO = dao.getMember(memberCode);
			
			if (memberCode != null) {
				if (currentChannelCode != null) {
					memberDTO.setMember_last_channel(currentChannelCode);
				}
				dao.updateLastChannel(memberDTO);
			}
		}
		
		session.invalidate();
	}
	
	@Override
	public int joinIdCheck(String id) {
		int idCheck = dao.joinIdCheck(id);
		System.out.println("count(*) :"+idCheck);
		return idCheck;
	}
	
	@Override
	public String generateMembercode() {
		String result = "";
		UUID uuid = UUID.randomUUID();
		result = "VD-"+uuid.toString();
		
		System.out.println("새로 가입하는 멤버 코드"+result);
		
		return result;
	}

	// 비디오 코드
	@Override
	public String videoCodeMaking() {
		String result = "";
		UUID uuid = UUID.randomUUID();
		result = "CH-"+uuid.toString();
		
		return result;
	}
}
