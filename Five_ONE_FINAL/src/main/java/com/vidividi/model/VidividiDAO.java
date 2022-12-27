package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.MainListDTO;
import com.vidividi.variable.PlaylistDTO;
import com.vidividi.variable.SearchPlayListDTO;
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
	
	//검색 페이지 넘기기(최신순)
	List<MainListDTO> searchVideoList_new(String field, String keyword, String option, int startNo, int endNo);
	
	//재생목록 리스트 띄우기
	List<SearchPlayListDTO> getPlaylistList(String play_code);
	
	//재생목록 추가하기
	List<SearchPlayListDTO> insertPlaylistList(String play_code, String play_video_code, String play_video_title, String play_bundle_title);
	
}
