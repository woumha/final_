package com.vidividi.variable;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.Data;

@Data
public class ChannelDTO {

	private String channel_code; // 채널 코드
	private String channel_name; // 채널 이름
	private String channel_banner; // 배너 이미지 경로
	private String channel_profil;
	private String channel_cont; // 채널 설명
	private int channel_like; // 채널 구독자수
	private String channel_live; // 채널 커뮤니티
	private String channel_date; // 채널 생성일
	private String channel_lastupload; // 마지막 업로드 날짜
	private String member_code; // 채널 주인 코드
	
	
	private MultipartHttpServletRequest multi_title;
	
}
