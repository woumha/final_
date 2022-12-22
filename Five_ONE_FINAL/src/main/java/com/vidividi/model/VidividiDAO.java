package com.vidividi.model;

import java.util.List;
import com.vidividi.variable.TestDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface VidividiDAO {
	
	List<TestDTO> test();
	
	//페이지네이션
	int getListCount();
	
	//리스트 인기순
	List<VideoPlayDTO> mainVideo(int startNo, int endNo);
	
	//리스트 최신순
	List<VideoPlayDTO> mainVideo_up(int startNo, int endNo);
	
	//리스트 소트 정렬
	List<VideoPlayDTO> mainVideo_sort_music(int startNo, int endNo);
	
	//검색 페이지 넘기기(인기순)
	List<VideoPlayDTO> searchVideoList(String field, String keyword, String option, int startNo, int endNo);
	
	List<VideoPlayDTO> searchVideoList_new(String field, String keyword, String option, int startNo, int endNo);
	
	
	
}
