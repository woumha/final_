package com.vidividi.variable;

import lombok.Data;

@Data
public class ReplyDTO {

	private String video_code;
	private int reply_no;
	private int reply_comment;
	private String reply_cont;
	private String member_code;
	private String member_name;
	private String reply_regdate;
	private String reply_update;
	private String channel_code;
	private String channel_name;
	private String channel_profil;
	private int reply_good;
	private int reply_bad;
	private String reply_group;
	
	
	
}
