package com.vidividi.model;

import com.vidividi.variable.VideoPlayDTO;

public interface VideoPlayDAO {
	// 한 개의 비디오 정보
	public VideoPlayDTO getVideoOne(String code);
}
