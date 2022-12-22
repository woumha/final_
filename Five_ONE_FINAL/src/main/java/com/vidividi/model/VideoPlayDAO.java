package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.CategoryDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface VideoPlayDAO {
	// 한 개의 비디오 정보
	public VideoPlayDTO getVideoOne(String code);
	
	// 메인 카테고리 정보 ( 메인 상단 출력 )
	public List<CategoryDTO> getCategoryList();
}
