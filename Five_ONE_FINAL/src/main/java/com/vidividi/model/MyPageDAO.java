package com.vidividi.model;

import java.util.List;
import java.util.Map;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.User_channelDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface MyPageDAO {
	
	List<VideoPlayDTO> getHistory_list(int code);
	List<VideoPlayDTO> getPlaylist_list(int code);
	List<VideoPlayDTO> getGood_list(int code);
	User_channelDTO getChannel_info(int code);
	List<VideoPlayDTO> getChannel_video(int code);
	List<SubscribeDTO> getChannel_sub(int code); 
	List<ReplyDTO> getReply_list(int code);
	int delete_history(int code);
	List<VideoPlayDTO> searchHistory(Map<String, Object> map);
	int history_one_delete(Map<String, Object> map);
	int getHistory_num(Map<String, Object> map);
	int updateSequence(int num);
}
