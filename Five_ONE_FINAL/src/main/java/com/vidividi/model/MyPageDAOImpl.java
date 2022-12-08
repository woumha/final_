package com.vidividi.model;

import java.util.List;
import java.util.Map;

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
	public List<VideoPlayDTO> getHistory_list(String code) {
		return this.sqlSession.selectList("history_list", code);
	}

	@Override
	public List<VideoPlayDTO> getPlaylist_list(String code) {
		return this.sqlSession.selectList("playlist_list", code);
	}

	@Override
	public List<VideoPlayDTO> getGood_list(String code) {
		return this.sqlSession.selectList("good_list", code);
	}

	@Override
	public ChannelDTO getChannel_info(String code) {
		return this.sqlSession.selectOne("member_channel", code);
	}

	@Override
	public List<VideoPlayDTO> getChannel_video(String code) {
		return this.sqlSession.selectList("channel_video", code);
	}

	@Override
	public List<SubscribeDTO> getChannel_sub(String code) {
		return this.sqlSession.selectList("channel_sub", code);
	}

	@Override
	public List<ReplyDTO> getReply_list(String code) {
		return this.sqlSession.selectList("reply_list", code);
	}

	@Override
	public int delete_history(String code) {
		return this.sqlSession.delete("delete_history", code);
	}

	@Override
	public List<VideoPlayDTO> searchHistory(Map<String, Object> map) {
		return this.sqlSession.selectList("history_search", map);
	}

	@Override
	public int history_one_delete(Map<String, Object> map) {
		return this.sqlSession.delete("history_one_delete", map);
	}

	@Override
	public int getHistory_num(Map<String, Object> map) {
		return this.sqlSession.selectOne("getHistory_num", map);
	}

	@Override
	public int updateSequence(int num) {
		return this.sqlSession.update("updateSeq", num);
	}

	
}
