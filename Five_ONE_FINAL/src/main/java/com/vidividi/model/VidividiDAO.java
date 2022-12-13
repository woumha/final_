package com.vidividi.model;

import java.util.List;
import com.vidividi.variable.TestDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface VidividiDAO {
	
	List<TestDTO> test();
	
	//페이지네이션
	int getListCount();
	
	//리스트 인기순
	List<VideoPlayDTO> mainVideo();
	
	//리스트 최신순
	List<VideoPlayDTO> mainVideo_up();
	
	//검색 페이지 넘기기
	List<VideoPlayDTO> searchVideoList(String field, String keyword);
	
}
