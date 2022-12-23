package com.vidividi.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.MainListDTO;
import com.vidividi.variable.PlaylistDTO;
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
	public List<MainListDTO> mainVideo(int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
        map.put("startNo", startNo);
        map.put("endNo", endNo);
		
		return this.sqlSession.selectList("video_list", map);
	}
	
	//비디오 최신순(메인 페이지)
	@Override
	public List<MainListDTO> mainVideo_up(int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		 map.put("startNo", startNo);
	     map.put("endNo", endNo);
		
		return this.sqlSession.selectList("video_list_up", map);
	}
	
	//비디오 메인 소트 정렬
	@Override
	public List<MainListDTO> mainVideo_sort(int startNo, int endNo, String option) {
		
		Map<String, Object> map = new HashMap<String, Object>();

        map.put("startNo", startNo);
        map.put("endNo", endNo);
        map.put("option", option);
  
		return sqlSession.selectList("video_list_sort", map);
	}
	
	//인기순 검색
	@Override
	public List<MainListDTO> searchVideoList(String field, String keyword, String option, int startNo, int endNo) {
		
		Map<String, Object> map = new HashMap<String, Object>();

        map.put("field", field);
        map.put("keyword", keyword);
        map.put("option", option);
        map.put("startNo", startNo);
        map.put("endNo", endNo);
  
		return sqlSession.selectList("searchVideo", map);
	}
	
	//최신순 검색
	@Override
	public List<MainListDTO> searchVideoList_new(String field, String keyword, String option, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();

        map.put("field", field);
        map.put("keyword", keyword);
        map.put("startNo", startNo);
        map.put("endNo", endNo);
		
		return sqlSession.selectList("searchVideo_new", map);
	}
	
	//페이지네이션
	@Override
	public int getListCount() {
		return this.sqlSession.selectOne("count");
	}

	@Override
	public List<PlaylistDTO> getPlaylistList(String play_code) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("play_code", play_code);
		
		return this.sqlSession.selectList("p_list", map);
	}
}