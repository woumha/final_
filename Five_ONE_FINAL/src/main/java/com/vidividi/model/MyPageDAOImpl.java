package com.vidividi.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.PlaylistDTO;
import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
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
	public List<PlaylistDTO> getPlaylist_list(String code) {
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
	public int updateSequence(int num) {
		return this.sqlSession.update("updateSeq", num);
	}

	@Override
	public List<VideoPlayDTO> getPlaylist_no(Map<String, Object> map) {
		return this.sqlSession.selectList("playlist_no", map);
	}

	@Override
	public List<VideoPlayDTO> searchPlaylist(Map<String, Object> map) {
		return this.sqlSession.selectList("playlist_search", map);
	}

	@Override
	public int playlist_one_delete(Map<String, Object> map) {
		return this.sqlSession.delete("playlist_one_delete", map);
	}

	@Override
	public int getPlayList_num(Map<String, Object> map) {
		return this.sqlSession.selectOne("getPlaylist_num", map);
	}

	@Override
	public int updateSequence_p(int num) {
		return this.sqlSession.update("updateSeq_p", num);
	}

	@Override
	public int delete_playlist(Map<String, Object> map) {
		return this.sqlSession.delete("delete_playlist", map);
	}

	@Override
	public List<VideoPlayDTO> history_list(String code) {
		return this.sqlSession.selectList("history_list", code);
	}

	@Override
	public List<ChannelDTO> getSubscribe_list(String code) {
		return this.sqlSession.selectList("subscribe_list", code);
	}

	@Override
	public int getSubscribe_num(Map<String, Object> map) {
		return this.sqlSession.selectOne("getSubscribe_num", map);
	}

	@Override
	public int subscribe_one_delete(int num) {
		return this.sqlSession.delete("delete_one_subscribe", num);
	}

	@Override
	public int updateSequence_s(int num) {
		return this.sqlSession.update("updateSeq_s", num);
	}

	@Override
	public List<VideoPlayDTO> getHistoryListCount(String code, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("code >>> "+code);
		System.out.println("startNo >>> "+startNo);
		System.out.println("endNo >>> "+endNo);
		
		map.put("code", code);
		map.put("startNo", startNo);
		map.put("endNo", endNo);
		
		return this.sqlSession.selectList("getHistory_list", map);
	}

	@Override
	public List<VideoPlayDTO> getHistory_search(Map<String, Object> map) {
		return this.sqlSession.selectList("history_search", map);
	}
	
	@Override
	public int getHistory_num(Map<String, Object> map) {
		return this.sqlSession.selectOne("getHistory_num", map);
	}

	@Override
	public int history_search_one_delete(int num) {
		return this.sqlSession.delete("history_search_one_delete", num);
	}
	
}
