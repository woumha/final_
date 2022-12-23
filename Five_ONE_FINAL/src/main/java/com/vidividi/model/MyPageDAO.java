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
	
	List<VideoPlayDTO> getPlaylist_no(Map<String, Object> map);
	List<VideoPlayDTO> searchPlaylist(Map<String, Object> map);
	int getPlayList_num(Map<String, Object> map);
	int playlist_one_delete(Map<String, Object> map);
	int updateSequence_p(int num);
	int delete_playlist(Map<String, Object> map);
	
	List<ChannelDTO> getSubscribe_list(String code);

	String getSubscribe_code(Map<String, Object> map);
	int subscribe_one_delete(String code);
	/* int updateSequence_s(int num); */
	
	/* history */
	List<VideoPlayDTO> getHistoryList(String code, int startNo, int endNo);
	List<VideoPlayDTO> getHistory_search(Map<String, Object> map);
	int getHistory_num(Map<String, Object> map);
	int history_search_one_delete(int num);
	int updateSequence(int num);
	int delete_history(String code);
	
	/* good */
	List<VideoPlayDTO> getGoodList_date(String code, int startNo, int endNo);
	List<VideoPlayDTO> getGoodList_most(String code, int startNo, int endNo);
	List<VideoPlayDTO> getGoodList_bad(String code, int startNo, int endNo);
	List<VideoPlayDTO> getGood_search_date(Map<String, Object> map);
	List<VideoPlayDTO> getGood_search_most(Map<String, Object> map);
	List<VideoPlayDTO> getGood_search_bad(Map<String, Object> map);
	String getGood_num(Map<String, Object> map);
	int getGood_bad(String num);
	int good_search_one_delete(String num);
	/* int updateSequence_g(int num); */
	int removeGood(String video);
	int removeBad(String video);
	
	/* mainPage playlist 더보기 ajax */
	List<PlaylistDTO> getPlayList_list(String code, int startNo, int endNo);
	
	/* playlist */
	List<VideoPlayDTO> getPlaylist_new(String code, int startNo, int endNo);
	List<VideoPlayDTO> getPlaylist_search(Map<String, Object> map);
	int playlist_search_one_delete(Map<String, Object> map);
	int delete_playlist(String p_code);
	int delete_bundlelist(String p_code);
	
	
	
	
	
}
