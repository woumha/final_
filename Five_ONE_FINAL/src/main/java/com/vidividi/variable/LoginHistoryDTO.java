package com.vidividi.variable;

import lombok.Data;

@Data
public class LoginHistoryDTO {
	private String member_code;
	private String login_country;
	private String login_region;
	private String login_city;
	private String login_ip;
	private String login_date;
}
