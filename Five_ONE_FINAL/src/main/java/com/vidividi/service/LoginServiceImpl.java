package com.vidividi.service;

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

}
