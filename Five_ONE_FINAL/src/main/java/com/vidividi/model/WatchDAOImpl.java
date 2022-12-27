package com.vidividi.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.io.output.ThresholdingOutputStream;
import org.apache.ibatis.io.ResolverUtil.Test;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.fasterxml.jackson.databind.deser.impl.CreatorCandidate.Param;
import com.vidividi.service.FormatCnt;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.FeedbackDTO;
import com.vidividi.variable.GoodDTO;
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
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("video_code", video_code);
		map.put("reply_option", reply_option);
		map.put("startNo", startNo);
		map.put("endNo", endNo);
		
		List<ReplyDTO> list = this.sqlSession.selectList("getReply", map);
		
		return list;
	}

	@Override
	public List<ReplyDTO> getReply(String video_code, String reply_option, String channel_code, int startNo, int endNo) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("video_code", video_code);
		map.put("reply_option", reply_option);
		map.put("channel_code", channel_code);
		map.put("startNo", startNo);
		map.put("endNo", endNo);
		
		List<ReplyDTO> list = this.sqlSession.selectList("getReplyLogin", map);
		
		return list;
	}

	@Override
	public List<ReplyDTO> getComment(String video_code, String reply_group, int startNo, int endNo) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("video_code", video_code);
		map.put("reply_group", reply_group);
		map.put("startNo", startNo);
		map.put("endNo", endNo);
		
		List<ReplyDTO> list = this.sqlSession.selectList("getComment", map);
		
		return list;
	}

	@Override
	public int getCommentCount(String video_code, String reply_group) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
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
	
	@Override
	public int getVideoCount(String channel_code) {
		return this.sqlSession.selectOne("getVideoCount", channel_code);
	}

	@Override
	public List<VideoPlayDTO> getNavList(String navOption, String channel_code, String category_code) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("channel_code", channel_code);
		map.put("category_code", category_code);
		
		return this.sqlSession.selectList(navOption, map);
	}


	@Override
	public SubscribeDTO getSubscribe(String channel_code, String repChannelCode) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("channel_code", channel_code);
		map.put("repChannelCode", repChannelCode);
		
		return this.sqlSession.selectOne("getSubscribe", map);
	}


	@Override
	public GoodDTO getGood(String video_code, String repChannelCode) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("video_code", video_code);
		map.put("repChannelCode", repChannelCode);
		
		return this.sqlSession.selectOne("getGood", map);
	}


	@Override
	public List<FeedbackDTO> getFeedback(String video_code, String repChannelCode) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("video_code", video_code);
		map.put("repChannelCode", repChannelCode);
		
		return this.sqlSession.selectList("getFeedback", map);
	}


	@Override
	public int insertGood(String video_code, String good_code, int good_bad, String repChannelCode) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("video_code", video_code);
		map.put("repChannelCode", repChannelCode);
		map.put("good_code", good_code);
		map.put("good_bad", good_bad);
		
		return this.sqlSession.insert("insertGood", map);
	}


	@Override
	public int deleteGood(String good_code) {
		
		return this.sqlSession.delete("deleteGood", good_code);
	}


	@Override
	public int updateGood(String good_code, int good_bad) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("good_code", good_code);
		map.put("good_bad", good_bad);
		
		return this.sqlSession.update("updateGood", map);
	}


	@Override
	public void insertSubscribe(String subscribe_code, String channel_code, String repChannelCode) {

		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("subscribe_code", subscribe_code);
		map.put("channel_code", channel_code);
		map.put("repChannelCode", repChannelCode);
		
		this.sqlSession.insert("insertSubscribe", map);
	}


	@Override
	public void deleteSubscribe(String subscribe_code) {
		this.sqlSession.delete("deleteSubscribe", subscribe_code);
	}


	@Override
	public int getVideoGoodCount(String video_code) {
		return this.sqlSession.selectOne("getVideoGoodCount", video_code);
	}


	@Override
	public void insertFeedback(String feedback_code, String video_code, String reply_code, String repChannelCode,
			int feedback_good) {
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("feedback_code", feedback_code);
		map.put("video_code", video_code);
		map.put("reply_code", reply_code);
		map.put("repChannelCode", repChannelCode);
		map.put("feedback_good", feedback_good);
		
		this.sqlSession.insert("insertFeedback", map);
	}


	@Override
	public void deleteFeedback(String feedback_code) {
		this.sqlSession.delete("deleteFeedback", feedback_code);
	}


	@Override
	public void updateFeedback(String feedback_code, int feedback_good) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("feedback_code", feedback_code);
		map.put("feedback_good", feedback_good);		
		this.sqlSession.update("updateFeedback", map);
	}


	@Override
	public int plusVideoGood(String video_code, String option) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("option", option);
		map.put("video_code", video_code);
		
		this.sqlSession.update("plusVideoGood", map);
		
		return (int) map.get("cnt");
	}


	@Override
	public int minusVideoGood(String video_code, String option) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		
		map.put("option", option);
		map.put("video_code", video_code);
		
		this.sqlSession.update("miusVideoGood", map);
		
		return (int) map.get("cnt");
	}


	@Override
	public int changeGood(String video_code, String option) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("video_code", video_code);
		map.put("option", "video_good");
		
		this.sqlSession.update(option, map);
		
		return (int) map.get("cnt"); 
	}


	@Override
	public void inputReply(String video_code, String reply_code, String reply_cont, int reply_comment, String reply_group,
			String repChannelCode) {
		System.out.println("넘어옴");
		
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("video_code", video_code);
		map.put("reply_code", reply_code);
		map.put("reply_cont", reply_cont);
		map.put("reply_comment", reply_comment);
		map.put("reply_group", reply_group);
		map.put("repChannelCode", repChannelCode);
		
		this.sqlSession.selectOne("inputReply", map);
	}


	@Override
	public ReplyDTO getNewReply(String reply_code) {
		return this.sqlSession.selectOne("getNewReply", reply_code);
	}


	@Override
	public List<ReplyDTO> getMyReply(String video_code, String reply_option, String repChannelCode) {
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("video_code", video_code);
		map.put("reply_option", reply_option);
		map.put("repChannelCode", repChannelCode);
		
		return this.sqlSession.selectList("getMyReply", map);
	}


	@Override
	public ChannelDTO getChannel(String repChannelCode) {
		return this.sqlSession.selectOne("getChannel", repChannelCode);
	}


	@Override
	public void updateReplyComment(String reply_code) {
		
		this.sqlSession.update("updateComment", reply_code);
	}



}
