package com.vidividi.model;


import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.VideoPlayDTO;

@Controller
public class ChannelDAOImpl implements ChannelDAO {
	
	@Inject
	private SqlSessionTemplate session;

	@Override
	public ChannelDTO getChannelOwner(MemberDTO memberDTO) {
		return this.session.selectOne("owner", memberDTO);
	}
	
//	@Override
//	public int setVideoUpload(VideoPlayDTO playDTO) {
//		return this.session.insert("video_update", playDTO);
//	}
}
