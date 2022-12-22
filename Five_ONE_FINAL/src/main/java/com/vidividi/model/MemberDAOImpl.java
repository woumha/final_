package com.vidividi.model;

import java.util.List;


import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.GoogleLoginDTO;
import com.vidividi.variable.LoginDTO;
import com.vidividi.variable.LoginHistoryDTO;
import com.vidividi.variable.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSessionTemplate sqlSession;
	
	@Override
	public String checkMember(LoginDTO dto) {
		return this.sqlSession.selectOne("checkMember", dto);
	}
	@Override
	public MemberDTO getMember(LoginDTO dto) {
		return this.sqlSession.selectOne("getMember", dto);
	}
	
	@Override
	public MemberDTO getMember(String memberCode) {
		return this.sqlSession.selectOne("getMemberByCode", memberCode);
	}
	
	@Override
	public void updateLastChannel(MemberDTO dto) {
		this.sqlSession.update("updateLastChannel", dto);
	}
	
	@Override
	public int joinIdCheck(String id) {
		return this.sqlSession.selectOne("joinIdCheck", id);
	}
	@Override
	public List<MemberDTO> getMemberList() {
		return this.sqlSession.selectList("getMemberList");
	}
	
	@Override
	public int joinMember(MemberDTO dto) {
		return this.sqlSession.insert("joinMember", dto);
	}
	
	@Override
	public int mebmerInfoUpdate(MemberDTO dto) {
		return this.sqlSession.update("memberInfoUpdate", dto);
	}
	
	@Override
	public int changeAuthStatus(MemberDTO dto) {
		return this.sqlSession.update("emailAuth", dto);
	}
	
	@Override
	public String alreadyEmail(String memberCode) {
		return this.sqlSession.selectOne("alreadyEmail", memberCode);
	}
	
	@Override
	public void toggleEmailLogin(String memberCode) {
		this.sqlSession.update("emailLogin", memberCode);
	}
	
	@Override
	public int insertLoginHistory(LoginHistoryDTO dto) {
		return this.sqlSession.insert("insertLoginHistory", dto);
	}
	
	@Override
	public List<LoginHistoryDTO> getLoginHistroy(String memberCode) {
		return this.sqlSession.selectList("getLoginHistory", memberCode);
	}
	
	@Override
	public String isGoogleLinked(GoogleLoginDTO dto) {
		return this.sqlSession.selectOne("isGoogleLinked", dto);
	}
	
}
