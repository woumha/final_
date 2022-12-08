package com.vidividi.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.VideoPlayDTO;

@Repository
public class WatchDAOImpl implements WatchDAO {

	@Inject
	private SqlSessionTemplate sqlSession;

	@Override
	public VideoPlayDTO getVideo(String video_code) {
		
		return this.sqlSession.selectOne("getVideo", video_code);
	}
	
	@Override
	public ChannelDTO getChannel(String channel_code) {
		return this.sqlSession.selectOne("getChannel", channel_code);
	}


	@Override
	public List<VideoPlayDTO> getVideoList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ReplyDTO> getReply(String video_code, String video_option) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("video_code", video_code);
		map.put("video_option", video_option);
		
		List<ReplyDTO> list = this.sqlSession.selectList("getReply", map);
		
		return list;
	}

	@Override
	public List<ReplyDTO> getComment(String video_code, String reply_group) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("video_code", video_code);
		map.put("video_option", reply_group);
		
		List<ReplyDTO> list = this.sqlSession.selectList("getComment", map);
		
		return list;
	}


	
}
