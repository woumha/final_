package com.vidividi.model;

import java.util.List;
import java.util.Map;

import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.PlaylistDTO;
import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface MyPageDAO {
	
	List<VideoPlayDTO> getHistory_list(String code);
	List<PlaylistDTO> getPlaylist_list(String code);
	List<VideoPlayDTO> getGood_list(String code);
	ChannelDTO getChannel_info(String code);
	List<VideoPlayDTO> getChannel_video(String code);
	List<SubscribeDTO> getChannel_sub(String code); 
	List<ReplyDTO> getReply_list(String code);
	
	/* history (시청한 동영상) */
	List<VideoPlayDTO> getHistoryList(String code, int startNo, int endNo);
	List<VideoPlayDTO> getHistory_search(Map<String, Object> map);
	int getHistory_num(Map<String, Object> map);
	int history_search_one_delete(int num);
	int updateSequence(int num);
	int delete_history(String code);
	
	/* good (좋아요, 싫어요 누른 동영상) */
	List<VideoPlayDTO> getGoodList_date(String code, int startNo, int endNo);
	List<VideoPlayDTO> getGoodList_most(String code, int startNo, int endNo);
	List<VideoPlayDTO> getGoodList_bad(String code, int startNo, int endNo);
	List<VideoPlayDTO> getGood_search_date(Map<String, Object> map);
	List<VideoPlayDTO> getGood_search_most(Map<String, Object> map);
	List<VideoPlayDTO> getGood_search_bad(Map<String, Object> map);
	String getGood_num(Map<String, Object> map);
	int getGood_bad(String num);
	int good_search_one_delete(String num);
	int removeGood(String video);
	int removeBad(String video);
	
	/* mainPage playlist 더보기 ajax */
	List<PlaylistDTO> getPlayList_list(String code, int startNo, int endNo);
	
	/* playlist (재생목록) */
	List<VideoPlayDTO> getPlaylist_new(String code, int startNo, int endNo);
	List<VideoPlayDTO> getPlaylist_search(Map<String, Object> map);
	int playlist_search_one_delete(Map<String, Object> map);
	int delete_playlist(String p_code);
	int delete_bundlelist(String p_code);
	
	/* subscribe (구독 채널) */
	List<ChannelDTO> getSubscribe_list(String code, int startNo, int endNo);
	int delete_one_subscribe(Map<String, Object> map);
	
	/* my_reply (내가 작성한 댓글) */
	List<ReplyDTO> getMy_reply_list(String code, int startNo, int endNo);
	int delete_group_reply(Map<String, Object> map);
	int delete_one_reply(Map<String, Object> map);
	
	
}
