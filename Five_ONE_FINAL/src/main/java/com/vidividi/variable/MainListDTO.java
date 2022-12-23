package com.vidividi.variable;

import java.util.Date;

import com.vidividi.service.FormatCnt;
import com.vidividi.service.Time;

public class MainListDTO {
	
	private String video_title;
	private String video_code;
	private String video_cont;
	private String video_img;
	private String video_view_cnt;
	private String video_regdate;
	private String video_good;
	
	private String channel_code;
	private String channel_name;
	private String channel_profil;
	
	
	public String getVideo_title() {
		return video_title;
	}
	public void setVideo_title(String video_title) {
		this.video_title = video_title;
	}
	public String getVideo_code() {
		return video_code;
	}
	public void setVideo_code(String video_code) {
		this.video_code = video_code;
	}
	public String getVideo_cont() {
		return video_cont;
	}
	public void setVideo_cont(String video_cont) {
		this.video_cont = video_cont;
	}
	public String getVideo_img() {
		return video_img;
	}
	public void setVideo_img(String video_img) {
		this.video_img = video_img;
	}
	public String getVideo_view_cnt() {
		return video_view_cnt;
	}
	public void setVideo_view_cnt(int video_view_cnt) {
		this.video_view_cnt = FormatCnt.format(video_view_cnt);
	}
	public String getVideo_regdate() {
		return video_regdate;
	}
	public void setVideo_regdate(Date video_regdate) {
		this.video_regdate = Time.calculateTime(video_regdate);
	}
	public String getVideo_good() {
		return video_good;
	}
	public void setVideo_good(int video_good) {
		this.video_good = FormatCnt.format(video_good);
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
	
	
	
	
}
