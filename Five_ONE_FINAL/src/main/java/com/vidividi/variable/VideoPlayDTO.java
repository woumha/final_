package com.vidividi.variable;

import lombok.Data;

@Data
public class VideoPlayDTO {

	private int video_code;
	private int channel_code;
	private String channel_name;
	private String video_title;
	private String video_cont;
	private String video_img;
	private int video_good;
	private int video_bad;
	private int video_view_cnt;
	private String video_hash;
	private String video_regdate;
	private int video_open;
	private int category_code;
	
}
