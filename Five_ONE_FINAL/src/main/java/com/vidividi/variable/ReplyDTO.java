package com.vidividi.variable;

import lombok.Data;

@Data
public class ReplyDTO {

	private int video_code;
	private int reply_no;
	private int reply_comment;
	private String reply_cont;
	private String member_code;
	private String reply_regdate;
	private String reply_update;
	
}
