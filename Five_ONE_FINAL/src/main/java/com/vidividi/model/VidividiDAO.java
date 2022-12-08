package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.TestDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface VidividiDAO {
	
	List<TestDTO> test();
	
	List<VideoPlayDTO> video();
	
	List<VideoPlayDTO> searchVideoList(String field, String keyword);
	
}
