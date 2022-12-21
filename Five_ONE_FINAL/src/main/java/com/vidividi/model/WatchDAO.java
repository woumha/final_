package com.vidividi.model;

import java.security.PublicKey;
import java.util.List;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.SubscribeDTO;
import com.vidividi.variable.ChannelDTO;
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
	
}
