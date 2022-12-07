package com.vidividi.model;

import java.util.List;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.VideoPlayDTO;



@Repository
public class MyPageDAOImpl implements MyPageDAO {

	@Inject
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<VideoPlayDTO> getHistory_list(int code) {
		
		return this.sqlSession.selectList("history_list", code);
	}

	@Override
	public List<VideoPlayDTO> getPlaylist_list(int code) {
		
		return this.sqlSession.selectList("playlist_list", code);
	}

	@Override
	public List<VideoPlayDTO> getGood_list(int code) {
		
		return this.sqlSession.selectList("good_list", code);
	}

	@Override
	public ChannelDTO getChannel_info(int code) {
		
		return this.sqlSession.selectOne("member_channel", code);
	}

	@Override
	public List<VideoPlayDTO> getChannel_video(int code) {
		
		return this.sqlSession.selectList("channel_video", code);
	}

	@Override
	public List<SubscribeDTO> getChannel_sub(int code) {
		
		return this.sqlSession.selectList("channel_sub", code);
	}

	@Override
	public List<ReplyDTO> getReply_list(int code) {
		
		return this.sqlSession.selectList("reply_list", code);
	}

	
}
