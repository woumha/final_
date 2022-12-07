package com.vidividi.model;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.LoginDTO;
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
		return this.sqlSession.selectOne("getMemberByCode");
	}
}
