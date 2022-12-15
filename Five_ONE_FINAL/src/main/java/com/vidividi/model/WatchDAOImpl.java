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
	public List<VideoPlayDTO> getVideoList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ReplyDTO> getReply(String video_code, String reply_option, int startNo, int endNo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("video_code", video_code);
		map.put("reply_option", reply_option);
		map.put("startNo", startNo);
		map.put("endNo", endNo);
		
		List<ReplyDTO> list = this.sqlSession.selectList("getReply", map);
		
		return list;
	}

	@Override
	public List<ReplyDTO> getComment(String video_code, String reply_group, int startNo, int endNo) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("video_code", video_code);
		map.put("reply_group", reply_group);
		map.put("startNo", startNo);
		map.put("endNo", endNo);
		
		List<ReplyDTO> list = this.sqlSession.selectList("getComment", map);
		
		return list;
	}

	@Override
	public int getCommentCount(String video_code, String reply_group) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("video_code", video_code);
		map.put("reply_group", reply_group);
		
		return this.sqlSession.selectOne("getCommentCount", map);
		
	}

	@Override
	public int getReplyCount(String video_code) {
		return this.sqlSession.selectOne("getReplyCount",video_code);
	}


	@Override
	public List<VideoPlayDTO> getPlayList(String playList_code) {
		return this.sqlSession.selectList("getPlayList", playList_code);
	}


	
}
