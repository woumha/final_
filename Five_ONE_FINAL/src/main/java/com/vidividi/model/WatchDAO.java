package com.vidividi.model;

import java.security.PublicKey;
import java.util.List;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface WatchDAO {

	public VideoPlayDTO getVideo(int video_code);
	
	
	public ChannelDTO getChannel(int channel_code); 
	
	
	public List<VideoPlayDTO> getVideoList();
	
	public List<ReplyDTO> getReply(int video_code, String video_option);

	public List<ReplyDTO> getComment(int video_code, String reply_group);
	
	
}
