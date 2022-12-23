package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.MainListDTO;
import com.vidividi.variable.TestDTO;

public interface VidividiDAO {
	
	List<TestDTO> test();
	
	//페이지네이션
	int getListCount();
	
	//리스트 인기순
	List<MainListDTO> mainVideo(int startNo, int endNo);
	
	//리스트 최신순
	List<MainListDTO> mainVideo_up(int startNo, int endNo);
	
	//리스트 소트 정렬
	List<MainListDTO> mainVideo_sort(int startNo, int endNo, String option);
	
	//검색 페이지 넘기기(인기순)
	List<MainListDTO> searchVideoList(String field, String keyword, String option, int startNo, int endNo);
	
	List<MainListDTO> searchVideoList_new(String field, String keyword, String option, int startNo, int endNo);
	
}
