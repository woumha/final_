package com.vidividi.model;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.TestDTO;
import com.vidividi.variable.VideoPlayDTO;

@Repository
public class VidividiDAOImpl implements VidividiDAO {
	
	@Inject
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<TestDTO> test() {
		return this.sqlSession.selectList("test");
	}

	@Override
	public List<VideoPlayDTO> video() {
		return this.sqlSession.selectList("video_list");
	}

	@Override
	public List<VideoPlayDTO> searchVideoList(String field, String keyword) {
		return sqlSession.selectList(field, keyword);
	}
}
