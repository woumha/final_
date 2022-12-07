package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface MyPageDAO {
	
	List<VideoPlayDTO> getHistory_list(int code);
	List<VideoPlayDTO> getPlaylist_list(int code);
	List<VideoPlayDTO> getGood_list(int code);
	ChannelDTO getChannel_info(int code);
	List<VideoPlayDTO> getChannel_video(int code);
	List<SubscribeDTO> getChannel_sub(int code); 
	List<ReplyDTO> getReply_list(int code);
}
