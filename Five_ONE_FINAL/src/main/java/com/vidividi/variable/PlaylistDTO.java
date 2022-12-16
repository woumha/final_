package com.vidividi.variable;

import lombok.Data;

@Data
public class PlaylistDTO {
	
	private int playlist_num;
	private String channel_code;
	private String playlist_title;
	private String playlist_code;
	private String video_code;
	private int playlist_open;
	private String playlist_regdate;
}
