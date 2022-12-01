package com.vidividi.five.one;

import java.io.File;
import java.util.Calendar;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class userUpload {
	public boolean userFileUpload(HttpServletRequest request) throws Exception {
		//MultipartHttpServletRequest mRequest
		boolean isUpload = true;
		
		String fileName = "";
		String folderName = "";
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/").concat("resources"); // 이미지를 업로드할 폴더 경로 설정 = /uploadPath/imgUpload
		//String imgUploadPath = uploadPath + File.separator + "imgUpload";
		System.out.println(uploadPath);
//		Calendar cal = Calendar.getInstance();
//		int year = cal.get(Calendar.YEAR);
//		int month = cal.get(Calendar.MONTH) + 1;
//		int day = cal.get(Calendar.DAY_OF_MONTH);
//
//		Iterator<String> iterator = mRequest.getFileNames();
//		
//		while(iterator.hasNext()) {
//			String uploadFileName = iterator.next();
//			MultipartFile mFile = mRequest.getFile(uploadFileName);
//			String originalFileName = mFile.getOriginalFilename();
//			
//			folderName = year + "-" + month + "-" + day;
//			String homedir = uploadPath + folderName; // 경로 + 폴더이름
//			
//			File path1 = new File(homedir);
//			if(!path1.exists()) {
//				path1.mkdirs();
//			}		
//			
//			fileName = originalFileName;
//			if(!fileName.equals("")) {
//				fileName = System.currentTimeMillis() + "_" + fileName;
//			}
//			
//			File origin = new File(homedir + "/" + fileName);
//			try {
//				mFile.transferTo(origin);
//				
//				isUpload = true;
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		} // while
		
		return  isUpload; // 업로드가 완료되면 true 반환
	
	}
}
