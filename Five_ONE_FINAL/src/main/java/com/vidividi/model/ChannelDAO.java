package com.vidividi.model;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface ChannelDAO {
	public ChannelDTO getChannelOwner(MemberDTO memberDTO);
	
	public String getChannelPsa(String channelCode);
	
	public int insertChannel(ChannelDTO dto);
	
	//public int setVideoUpload(VideoPlayDTO playDTO);
}
