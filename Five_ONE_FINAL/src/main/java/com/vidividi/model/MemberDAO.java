package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.GoogleLoginDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.LoginHistoryDTO;
import com.vidividi.variable.MemberDTO;

public interface MemberDAO {

	String checkMember(LoginDTO dto);
	MemberDTO getMember(LoginDTO dto);
	MemberDTO getMember(String memberCode);
	List<MemberDTO> getMemberList();
	void updateLastChannel(MemberDTO dto);
	int joinIdCheck(String id);
	int joinMember(MemberDTO dto);
	int mebmerInfoUpdate(MemberDTO dto);
	int changeAuthStatus(MemberDTO dto);
	String alreadyEmail(String memberCode);
	void toggleEmailLogin(String memberCode);
	int insertLoginHistory(LoginHistoryDTO dto);
	List<LoginHistoryDTO> getLoginHistroy(String memberCode);
	String isSocialLinked(String email);
	String isExistEmail(String email);
	void socialLink(MemberDTO dto);
	String findId(String email);
	void changePwd(LoginDTO dto);
	int isProtected(String memberCode);
	int memberExpire(String memberCode);
	int checkExpire(String memberCode);
	int changeRep(MemberDTO dto);
}
