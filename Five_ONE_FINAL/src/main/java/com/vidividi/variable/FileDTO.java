package com.vidividi.variable;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class FileDTO {
	private MultipartFile file;
}
