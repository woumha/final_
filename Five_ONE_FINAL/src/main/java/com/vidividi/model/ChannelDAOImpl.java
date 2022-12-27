package com.vidividi.model;


import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.PlaylistDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.VideoPlayDTO;

@Controller
public class ChannelDAOImpl implements ChannelDAO {
	
	@Inject
	private SqlSessionTemplate session;
	
	// 채널 정보
	@Override
	public ChannelDTO getChannelOwner(String channelCode) {
		return this.session.selectOne("owner", channelCode);
	}
	
	// 멤버 코드를 이용한 채널 정보
	@Override
	public ChannelDTO getChannelInformation(MemberDTO dto) {
		return this.session.selectOne("memOwner", dto);
	}
	
	// 재생목록 리스트
	@Override
	public List<PlaylistDTO> getPlayList(String code) {
		return this.session.selectList("member_playlist", code);
	}
	
	// 영상 업로드
	@Override
	public int setVideoUpload(VideoPlayDTO playDTO, PlaylistDTO playlistDTO) {
		int check = 0;
		if(this.session.insert("videoInsert", playDTO) > 0) {
			// PlaylistDTO Insert 해야함
			check = this.session.insert("playListInsert", playlistDTO);
		}
		return check;
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
	
	@Override
	public List<VideoPlayDTO> getPlayListDetail(String bundleCode) {
		return this.session.selectList("playlistDetail", bundleCode);
	}
	
	@Override
	public List<VideoPlayDTO> getPlayListDetails(String bundleCode) {
		return this.session.selectList("playlistDetails", bundleCode);
	}
	
	@Override
	public PlaylistDTO getBundleBundleList(String bundleCode) {
		return this.session.selectOne("bbundleCode", bundleCode);
	}
	
	@Override
	public int checkSubscribe(SubscribeDTO subdto) {
		int check = this.session.selectOne("checkSub", subdto);
		
		return check;
	}
	
	@Override
	public boolean inOutSubscribe(SubscribeDTO subdto) {
		int check = this.session.selectOne("checkSub", subdto);
		int result = 0;
		if(check > 0) {
			result = this.session.delete("subDelete", subdto);
			if(result > 0) {
				return false;
			}
		} else {
			result = this.session.insert("subinsert", subdto);
			if(result > 0) {
				return true;
			}
		}
		
		return false;
	}
}
