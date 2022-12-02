package com.vidividi.model;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MyPageDAOImpl implements MyPageDAO {

	@Inject
	private SqlSessionTemplate sqlSession;	
	
}
