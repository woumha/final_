package com.vidividi.model;

import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.MemberDTO;

public interface MemberDAO {

	String checkMember(LoginDTO dto);
	MemberDTO getMember(LoginDTO dto);
	MemberDTO getMember(String memberCode);
	void updateLastChannel(MemberDTO dto);
}
