package com.vidividi.service;

import javax.servlet.http.HttpSession;

import com.vidividi.variable.LoginDTO;

public interface LoginService {
	
	String loginCheck(LoginDTO dto, HttpSession session);
	void logout(HttpSession session);

}
