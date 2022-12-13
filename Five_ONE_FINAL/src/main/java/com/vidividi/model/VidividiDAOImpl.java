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

	//비디오 인기순(메인 페이지)
	@Override
	public List<VideoPlayDTO> mainVideo() {
		return this.sqlSession.selectList("video_list");
	}
	
	//비디오 최신순(메인 페이지)
	@Override
	public List<VideoPlayDTO> mainVideo_up() {
		return this.sqlSession.selectList("video_list_up");
	}
	
	//검색
	@Override
	public List<VideoPlayDTO> searchVideoList(String field, String keyword) {
		return sqlSession.selectList(field, keyword);
	}

	//페이지네이션
	@Override
	public int getListCount() {
		return this.sqlSession.selectOne("count");
	}
}