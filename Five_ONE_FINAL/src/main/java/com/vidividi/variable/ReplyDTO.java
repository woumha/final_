package com.vidividi.variable;

import java.util.Date;

import com.vidividi.service.FormatCnt;
import com.vidividi.service.Time;

import lombok.Data;

public class ReplyDTO {

	private String video_code;
	private String reply_code;
	private int reply_comment;
	private String reply_cont;
	private String member_code;
	private String member_name;
	private String reply_regdate;
	private String reply_update;
	private String channel_code;
	private String channel_name;
	private String channel_profil;
	private String reply_good;
	private int reply_bad;
	private String reply_group;
	
	// myPage 댓글에 사용할 내용
	private String video_title;
	private String video_img;
	// video_play 테이블의 channel_code
	private String video_owner;
	
	public String getVideo_title() {
		return video_title;
	}
	public void setVideo_title(String video_title) {
		this.video_title = video_title;
	}
	public String getVideo_img() {
		return video_img;
	}
	public void setVideo_img(String video_img) {
		this.video_img = video_img;
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
	public int getReply_comment() {
		return reply_comment;
	}
	public void setReply_comment(int reply_comment) {
		this.reply_comment = reply_comment;
	}
	public String getReply_cont() {
		return reply_cont;
	}
	public void setReply_cont(String reply_cont) {
		this.reply_cont = reply_cont;
	}
	public String getMember_code() {
		return member_code;
	}
	public void setMember_code(String member_code) {
		this.member_code = member_code;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getReply_regdate() {
		return reply_regdate;
	}
	public void setReply_regdate(Date reply_regdate) {
		this.reply_regdate = Time.calculateTime(reply_regdate);
	}
	public String getReply_update() {
		return reply_update;
	}
	public void setReply_update(Date reply_update) {
		this.reply_update = Time.calculateTime(reply_update);
	}
	public String getChannel_code() {
		return channel_code;
	}
	public void setChannel_code(String channel_code) {
		this.channel_code = channel_code;
	}
	public String getChannel_name() {
		return channel_name;
	}
	public void setChannel_name(String channel_name) {
		this.channel_name = channel_name;
	}
	public String getChannel_profil() {
		return channel_profil;
	}
	public void setChannel_profil(String channel_profil) {
		this.channel_profil = channel_profil;
	}
	public String getReply_good() {
		return reply_good;
	}
	public void setReply_good(int reply_good) {
		this.reply_good = FormatCnt.format(reply_good);
	}
	public int getReply_bad() {
		return reply_bad;
	}
	public void setReply_bad(int reply_bad) {
		this.reply_bad = reply_bad;
	}
	public String getReply_group() {
		return reply_group;
	}
	public void setReply_group(String reply_group) {
		this.reply_group = reply_group;
	}
	public String getVideo_owner() {
		return video_owner;
	}
	public void setVideo_owner(String video_owner) {
		this.video_owner = video_owner;
	}
	
	
	
}
