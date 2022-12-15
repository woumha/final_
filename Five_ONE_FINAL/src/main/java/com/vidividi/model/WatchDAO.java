package com.vidividi.model;

import java.security.PublicKey;
import java.util.List;

import com.vidividi.variable.ReplyDTO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.VideoPlayDTO;

public interface WatchDAO {

	public VideoPlayDTO getVideo(String video_code);

	public int getReplyCount(String video_code);
	
	public int getCommentCount(String video_code, String reply_group);
	
	public List<VideoPlayDTO> getVideoList();
	
	public List<ReplyDTO> getReply(String video_code, String reply_option, int startNo, int endNo);

	public List<ReplyDTO> getComment(String video_code, String reply_group, int startNo, int endNo);
	
	public List<VideoPlayDTO> getPlayList(String playList_code);
	
	public List<VideoPlayDTO> getNavList(int startNo, int endNo);
	
	public List<VideoPlayDTO> getNavList(int startNo, int endNo, String navOption);
	
	
}
