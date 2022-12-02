package com.vidividi.model;

import java.security.PublicKey;
import java.util.List;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface WatchDAO {

	public VideoPlayDTO getVideo(int video_code);
	
	public List<VideoPlayDTO> getVideoList();
	
	public ReplyDTO getReply();
	
	
	
}
