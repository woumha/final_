package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface ChannelDAO {
	// 채널 정보
	public ChannelDTO getChannelOwner(MemberDTO memberDTO);
  
	// 비디오 업로
	public int setVideoUpload(VideoPlayDTO playDTO);
	
	// 채널 , 비디오 관리 페이지
	public List<VideoPlayDTO> getVideoList(String code);
	
	// 최근에 올린 영상
	public VideoPlayDTO getNewVideo(String code);

  // 제이님 시작
	public String getChannelPsa(String channelCode);
	
	public int countMemberChannel(String memberCode);
	
	public int insertChannel(ChannelDTO dto);
	
	public List<ChannelDTO> getChannelList(String memberCode);
	
	public int deleteChannel(String channelCode);
	
	// 제이님 끝
  
	//public int setVideoUpload(VideoPlayDTO playDTO);
	
	// 채널 프로필 수정
	public int setChangeChannelProfil(String channelCode);
}
