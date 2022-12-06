package com.vidividi.variable;

import lombok.Data;

@Data
public class ReplyDTO {

	private int video_code;
	private int reply_no;
	private int reply_comment;
	private String reply_cont;
	private int member_code;
	private String member_name;
	private String reply_regdate;
	private String reply_update;
	
}
