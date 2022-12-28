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
		return this.sqlSession.selectList("m_history_list", code);}
	@Override
	public List<PlaylistDTO> getPlaylist_list(String code) {
		return this.sqlSession.selectList("m_playlist_list", code);}
	@Override
	public List<VideoPlayDTO> getGood_list(String code) {
		return this.sqlSession.selectList("m_good_list", code);}
	@Override
	public List<ReplyDTO> getReply_list(String code) {
		return this.sqlSession.selectList("m_reply_list", code);}
	@Override
	public ChannelDTO getChannel_info(String code) {
		return this.sqlSession.selectOne("member_channel", code);}

	@Override
	public List<VideoPlayDTO> getChannel_video(String code) {
		return this.sqlSession.selectList("channel_video", code);
	}
	@Override
	public List<SubscribeDTO> getChannel_sub(String code) {
		return this.sqlSession.selectList("channel_sub", code);}
	
	/* history 페이지 */
	@Override
	public List<VideoPlayDTO> getHistoryList(String code, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code); map.put("startNo", startNo); map.put("endNo", endNo);
		return this.sqlSession.selectList("getHistory_list", map); }
	@Override
	public List<VideoPlayDTO> getHistory_search(Map<String, Object> map) {
		return this.sqlSession.selectList("history_search", map); }
	@Override
	public int history_search_one_delete(Map<String, Object> map) {
		return this.sqlSession.delete("history_search_one_delete", map); }

	@Override
	public int delete_history(String code) {
		return this.sqlSession.delete("delete_history", code); }

	/* good 페이지 */
	@Override
	public List<VideoPlayDTO> getGoodList_date(String code, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code); map.put("startNo", startNo); map.put("endNo", endNo);
		return this.sqlSession.selectList("getGood_list_date", map); }
	@Override
	public List<VideoPlayDTO> getGoodList_most(String code, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code); map.put("startNo", startNo); map.put("endNo", endNo);
		return this.sqlSession.selectList("getGood_list_most", map); }
	@Override
	public List<VideoPlayDTO> getGoodList_bad(String code, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code); map.put("startNo", startNo); map.put("endNo", endNo);
		return this.sqlSession.selectList("getGood_list_bad", map); }
	@Override
	public List<VideoPlayDTO> getGood_search_date(Map<String, Object> map) {
		return this.sqlSession.selectList("good_search_date", map); }
	@Override
	public List<VideoPlayDTO> getGood_search_most(Map<String, Object> map) {
		return this.sqlSession.selectList("good_search_most", map); }
	@Override
	public List<VideoPlayDTO> getGood_search_bad(Map<String, Object> map) {
		return this.sqlSession.selectList("good_search_bad", map); }
	@Override
	public String getGood_num(Map<String, Object> map) {
		return this.sqlSession.selectOne("getGood_num", map); }
	@Override
	public int getGood_bad(String num) {
		return this.sqlSession.selectOne("getGood_bad", num); }
	@Override
	public int good_search_one_delete(String num) {
		return this.sqlSession.delete("good_search_one_delete", num); }
	
	@Override
	public int removeGood(String video) {
		return this.sqlSession.update("removeGood", video); }
	@Override
	public int removeBad(String video) {
		return this.sqlSession.update("removeBad", video); }

	/* mainPage playlist 더보기 ajax */
	@Override
	public List<PlaylistDTO> getPlayList_list(String code, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code); map.put("startNo", startNo); map.put("endNo", endNo);
		return this.sqlSession.selectList("getPlaylist_list", map); }

	
	/* playlist */
	@Override
	public List<VideoPlayDTO> getPlaylist_new(String code, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code); map.put("startNo", startNo); map.put("endNo", endNo);
		return this.sqlSession.selectList("getPlaylist_new", map); }
	@Override
	public List<VideoPlayDTO> getPlaylist_search(Map<String, Object> map) {
		return this.sqlSession.selectList("getPlaylist_search", map); }

	@Override
	public int playlist_search_one_delete(Map<String, Object> map) {
		return this.sqlSession.delete("playlist_search_one_delete", map); }

	@Override
	public int delete_playlist(String p_code) {
		return this.sqlSession.delete("delete_playlist", p_code);}

	@Override
	public int delete_bundlelist(String p_code) {
		return this.sqlSession.delete("delete_bundlelist", p_code);}

	/* subscribe */
	@Override
	public List<ChannelDTO> getSubscribe_list(String code, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code); map.put("startNo", startNo); map.put("endNo", endNo);
		return this.sqlSession.selectList("getSubscribe_list", map); }
	@Override
	public int delete_one_subscribe(Map<String, Object> map) {
		return this.sqlSession.delete("delete_one_subscribe", map); }
	
	/* my_reply */
	public List<ReplyDTO> getMy_reply_list(String code, int startNo, int endNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code); map.put("startNo", startNo); map.put("endNo", endNo);
		return this.sqlSession.selectList("getMy_reply_list", map); }
	@Override
	public int delete_group_reply(String group) {
		return this.sqlSession.delete("delete_group_reply", group); }
	@Override
	public int delete_one_reply(String code) {
		return this.sqlSession.delete("delete_one_reply", code); }
	@Override
	public String getMy_reply_group(String code) {
		return this.sqlSession.selectOne("getMy_reply_group", code);
	}
	@Override
	public int getMy_reply_comment(String code) {
		return this.sqlSession.selectOne("getMy_reply_comment", code);
	}
	
	
	
	
	
	
	
	
}
