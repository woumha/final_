package com.vidividi.model;

import java.util.List;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.PlaylistDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface ChannelDAO {
	// 채널 정보
	public ChannelDTO getChannelOwner(String channelCode);
  
	// 멤버 코드를 이용한 채널 정보
	public ChannelDTO getChannelInformation(MemberDTO dto);
		
	// 재생목록 리스트
	public List<PlaylistDTO> getPlayList(String code);
	
	// 비디오 업로드
	public int setVideoUpload(VideoPlayDTO playDTO, PlaylistDTO playlistDTO);
	
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
	
	// 재생목록 영상 불러오기
	public List<VideoPlayDTO> getPlayListDetail(String bundleCode);
	
	// 다수의 재생목록의 영상들
	public List<VideoPlayDTO> getPlayListDetails(String bundleCode);
	
	// 재생목록 링크
	public PlaylistDTO getBundleBundleList(String bundleCode);
	
	// 구독 유무 체크
	public int checkSubscribe(SubscribeDTO subdto);
	
	// 구독 인, 아웃
	public boolean inOutSubscribe(SubscribeDTO subdto);
	
	// 영상 삭제
	public int videoDelete(String video_code);
	
	// 채널 배너, 프로필 이미지 수정
	public int setChangeChannelProfil(ChannelDTO channeldto);
	
	
	// 채널 프로필 이름, 설명 수정
	public int setChannelMyPage(ChannelDTO channeldto);
	

}
