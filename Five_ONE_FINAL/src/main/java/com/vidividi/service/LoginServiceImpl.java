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
		String membercode = dao.checkMember(dto);
		MemberDTO memberDTO = dao.getMember(dto);
		
		
		if (membercode != null) {
			session.setAttribute("MemberCode", membercode);
			session.setAttribute("LastChannelCode", memberDTO.getMember_last_channel());
		}
		return membercode;
	}

	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

}
