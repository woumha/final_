package com.vidividi.variable;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class TestDTO {
	
	private String test1;
	private String test2;
	private MultipartFile file;

}
