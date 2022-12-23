package com.vidividi.model;

import java.security.PublicKey;
import java.util.List;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.FeedbackDTO;
import com.vidividi.variable.GoodDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface WatchDAO {

	public VideoPlayDTO getVideo(String video_code);

	public int getReplyCount(String video_code);
	
	public int getCommentCount(String video_code, String reply_group);
	
	public List<VideoPlayDTO> getVideoList();
	
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

	public void plusVideoGood(String video_code, String option);

	public void minusVideoGood(String video_code, String option);

	public void changeGood(String video_code, String option);

	public void inputReply(String video_code, String reply_code, String reply_cont, int reply_comment, String reply_group,
			String repChannelCode);

	public ReplyDTO getNewReply(String reply_code);
	
}
