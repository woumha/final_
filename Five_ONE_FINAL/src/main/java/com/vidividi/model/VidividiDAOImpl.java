package com.vidividi.model;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.TestDTO;

@Repository
public class VidividiDAOImpl implements VidividiDAO {
	
	@Inject
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<TestDTO> test() {
		return this.sqlSession.selectList("test");
	}
}
