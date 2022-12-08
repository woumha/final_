package com.vidividi.model;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;

public interface ChannelDAO {
	public ChannelDTO getChannelOwner(MemberDTO memberDTO);
}
