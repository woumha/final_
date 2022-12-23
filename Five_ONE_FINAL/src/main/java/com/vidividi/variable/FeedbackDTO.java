package com.vidividi.variable;

import java.util.Date;

import com.vidividi.service.Time;

public class FeedbackDTO {

	String feedback_code;
	String video_code;
	String reply_code;
	String channel_code;
	int feedback_good;
	String feedback_regdate;
	
	public String getFeedback_code() {
		return feedback_code;
	}
	public void setFeedback_code(String feedback_code) {
		this.feedback_code = feedback_code;
	}
	public String getVideo_code() {
		return video_code;
	}
	public void setVideo_code(String video_code) {
		this.video_code = video_code;
	}
	public String getReply_code() {
		return reply_code;
	}
	public void setReply_code(String reply_code) {
		this.reply_code = reply_code;
	}
	public String getChannel_code() {
		return channel_code;
	}
	public void setChannel_code(String channel_code) {
		this.channel_code = channel_code;
	}
	public int getFeedback_good() {
		return feedback_good;
	}
	public void setFeedback_good(int feedback_good) {
		this.feedback_good = feedback_good;
	}
	public String getFeedback_regdate() {
		return feedback_regdate;
	}
	public void setFeedback_regdate(Date feedback_regdate) {
		this.feedback_regdate = Time.calculateTime(feedback_regdate);
	}
	
	
}
