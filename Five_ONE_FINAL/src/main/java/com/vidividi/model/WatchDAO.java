package com.vidividi.model;

import java.security.PublicKey;
import java.util.List;
import java.util.Map;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.BundleDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.FeedbackDTO;
import com.vidividi.variable.GoodDTO;
import com.vidividi.variable.HistoryDTO;
import com.vidividi.variable.PlaylistDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface WatchDAO {
	
	public int getHistory_save(String repChannelCode);
	
	public HistoryDTO checkHistory(Map<String, Object> map);
		
	public int insert_history(Map<String, Object> map);
	public int update_history(Map<String, Object> map);
	

	public VideoPlayDTO getVideo(String video_code);

	public int getReplyCount(String video_code);
	
	public int getCommentCount(String video_code, String reply_group);
	
	public List<VideoPlayDTO> getVideoList();
	
	public List<ReplyDTO> getReply(String video_code, String reply_option, int startNo, int endNo);
	
	public List<ReplyDTO> getReply(String video_code, String reply_option, String channel_code, int startNo, int endNo);
	
	public List<ReplyDTO> getComment(String video_code, String reply_group, int startNo, int endNo);
	
	public List<VideoPlayDTO> getPlayList(String playList_code);

	public List<VideoPlayDTO> getNavList(String navOption, String channel_code, String category_code);

	public int getVideoCount(String channel_code);
	
	public SubscribeDTO getSubscribe(String channel_code, String repChannelCode);

	public GoodDTO getGood(String video_code, String repChannelCode);

	public List<FeedbackDTO> getFeedback(String video_code, String repChannelCode);

	public int insertGood(String video_code, String good_code, int good_bad, String repChannelCode);

	public int deleteGood(String good_code);

	public int updateGood(String good_code, int good_bad);

	public void insertSubscribe(String subscribe_code, String channel_code, String repChannelCode);

	public void deleteSubscribe(String subscribe_code);

	public int getVideoGoodCount(String video_code);

	public void insertFeedback(String feedback_code, String video_code, String reply_code, String repChannelCode,
			int feedback_good);

	public void deleteFeedback(String feedback_code);

	public void updateFeedback(String feedback_code, int feedback_good);

	public int plusVideoGood(String video_code, String option);

	public int minusVideoGood(String video_code, String option);

	public int changeGood(String video_code, String option);

	public void inputReply(String video_code, String reply_code, String reply_cont, int reply_comment, String reply_group,
			String repChannelCode);

	public ReplyDTO getNewReply(String reply_code);

	public List<ReplyDTO> getMyReply(String video_code, String reply_option, String repChannelCode);

	public ChannelDTO getChannel(String repChannelCode);

	public void updateReplyComment(String reply_code);

	public int plusReplyGood(String reply_code, String option);

	public int minusReplyGood(String reply_code, String option);

	public int changeReply(String reply_code, String option);

	public void newPlaylist(String bundle_code, String playlist_title, int playlist_open, String repChannelCode);

	public List<BundleDTO> getBundleList(String repChannelCode);

	public List<PlaylistDTO> getMyPlayList(String video_code, String repChannelCode2);

	public void addPlaylist(String video_code, String playlist_code, String playlist_title, String repChannelCode);

	public void deletePlaylist(String video_code, String playlist_code, String repChannelCode);

	public void plusViewCnt(String video_code);

	
	
}
