package com.vidividi.model;


import java.util.List;

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
	
	// 채널 정보
	@Override
	public ChannelDTO getChannelOwner(MemberDTO memberDTO) {
		return this.session.selectOne("owner", memberDTO);
	}
	
	// 영상 업로드
	@Override
	public int setVideoUpload(VideoPlayDTO playDTO) {
		return this.session.insert("video_update", playDTO);
	}
	
	// 영상 전체 목록
	@Override
	public List<VideoPlayDTO> getVideoList(String code) {
		return this.session.selectList("channel_video_list", code);
	}
	
	@Override
	public VideoPlayDTO getNewVideo(String new_code) {
		return this.session.selectOne("channel_new_video", new_code);
	}

	@Override
	public String getChannelPsa(String channelCode) {
		return this.session.selectOne("channelPsa", channelCode);
	}
	
	@Override
	public int insertChannel(ChannelDTO dto) {
		return this.session.insert("insertChannel", dto);
	}
	
//	@Override
//	public int setVideoUpload(VideoPlayDTO playDTO) {
//		return this.session.insert("video_update", playDTO);
//	}
	
	@Override
	public int setChangeChannelProfil(String channelCode) {
		return this.session.update("profil_update", channelCode);
	}
}
