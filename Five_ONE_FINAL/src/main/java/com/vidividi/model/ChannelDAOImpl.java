package com.vidividi.model;


import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.PlaylistDTO;
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
	
	// 재생목록 리스트
	@Override
	public List<PlaylistDTO> getPlayList(String code) {
		return this.session.selectList("member_playlist", code);
	}
	
	// 영상 업로드
	@Override
	public int setVideoUpload(VideoPlayDTO playDTO) {
		if(this.session.insert("videoInsert", playDTO) > 0) {
			// PlaylistDTO Insert 해야함
		}
		return this.session.insert("videoInsert", playDTO);
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
	public int countMemberChannel(String memberCode) {
		return this.session.selectOne("countMemberChannel", memberCode);
	}
	
	@Override
	public int insertChannel(ChannelDTO dto) {
		return this.session.insert("insertChannel", dto);
	}
	
	@Override
	public int deleteChannel(String channelCode) {
		return this.session.delete("deleteChannel", channelCode);
	}
	
	@Override
	public List<ChannelDTO> getChannelList(String memberCode) {
		return this.session.selectList("getChannelList", memberCode);
	}
	
	@Override
	public int setChangeChannelProfil(String channelCode) {
		return this.session.update("profil_update", channelCode);
	}
	
	
}
