package com.vidividi.five.one;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Iterator;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.PageContext;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

// �뒪�봽留곸뿉�꽌 鍮꾩��땲�뒪 濡쒖쭅�쓣 �닔�뻾�븷 �븣 遺숈씠�뒗 �븷�끂�뀒�씠�뀡
// �빐�떦 Upload�씪�뒗 �겢�옒�뒪�뒗 鍮꾩��땲�뒪 濡쒖쭅�쓣 �닔�뻾�븯�뒗 �겢�옒�뒪
@Service
public class UploadFile {
	public String dynamicPath_r() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		request.getContextPath();
		return request.getServletContext().getRealPath("resources");
	}
	
	
	public boolean fileUpload(MultipartHttpServletRequest mRequest, String lastChannelCode, String title) {
		boolean isUpload = false;
		
		// 梨꾨꼸 肄붾뱶 �삉�뒗 梨꾨꼸 �씠由�, �쁺�긽 �젣紐� 
		String saveFileName = "";
		String dateFolder = "";

		//String uploadVideoPath = "C:/final/GitHub/Five_ONE_Final/Five_ONE_FINAL/src/main/webapp/resources/AllChannel/" + lastChannelCode + "/";
		//String uploadVideoPath = "F:/GitHub/workspace(Spring)/Five_ONE_Final/Five_ONE_FINAL/src/main/webapp/resources/AllChannel/"; // 吏� PC
		//String uploadVideoPath = dynamicPath_r() + "/AllChannel/";
		
		String uploadVideoPath = "C:/final/GitHub/Five_ONE_Final/Five_ONE_FINAL/src/main/webapp/resources/AllChannel/";
		//thumbnail
		Iterator<String> iterator = mRequest.getFileNames();
		
		System.out.println("uploadVideoPath: " + uploadVideoPath);
		
		// �뱾�뼱�삤湲� �쟾遺��꽣 萸붽�瑜� �빐�빞�븷�벏...
		String extMovieArr[] = { "mp4",  };
		String extImgArr[] = { "png", "jpg" };
		
		while(iterator.hasNext()) {
			
			String uploadFileName = iterator.next(); 
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			
			String originalFileName = mFile.getOriginalFilename(); // �뙆�씪 �씠由� ���옣
			
			
			System.out.println("�뙆�씪�씠由�: " + originalFileName);
			String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
			System.out.println("ext: " + ext);
			
			// �쁺�긽 �솗�옣�옄 李얘린
			for(int i=0; i<extMovieArr.length; i++) {
				if(ext.equals(extMovieArr[i]) ) {
					dateFolder = uploadVideoPath + lastChannelCode;
					File path1 = new File(dateFolder); // �뤃�뜑 寃쎈줈
					
					if(!path1.exists()) {
						path1.mkdirs();
					}
					
					// �떎�젣 ���옣�릺�뒗 �뙆�씪 �씠由�
					saveFileName = originalFileName;
					if (!saveFileName.equals("")) {
						//saveFileName = System.currentTimeMillis() + "_" +saveFileName;
						saveFileName = title;
					}
					// �뙆�씪 ���옣 諛� �삁�쇅泥섎━
					try {
						// �뙆�씪 ���옣
						File origin = new File(dateFolder+"/"+saveFileName + ".mp4");
						mFile.transferTo(origin);     // �뙆�씪 �뜲�씠�꽣瑜� 吏��젙�븳 �뤃�뜑濡� �씠�룞�븯�뒗 硫붿꽌�뱶
						
						isUpload = true;
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
			// �씠誘몄� �솗�옣�옄 李얘린
			for(int i=0; i<extImgArr.length; i++) {
				if(ext.equals(extImgArr[i])) {
					// �떎�젣 �뤃�뜑瑜� 留뚮뱾�뼱蹂댁옄 
					dateFolder = uploadVideoPath + lastChannelCode + "/thumbnail";
					File path2 = new File(dateFolder); // �뤃�뜑 寃쎈줈
					
					if(!path2.exists()) {
						path2.mkdirs();
					}
					
					// �떎�젣 ���옣�릺�뒗 �뙆�씪 �씠由�
					saveFileName = originalFileName;
					if (!saveFileName.equals("")) {
						//saveFileName = System.currentTimeMillis() + "_" +saveFileName;
						saveFileName = title;
					}
					// �뙆�씪 ���옣 諛� �삁�쇅泥섎━
					try {
						// �뙆�씪 ���옣
						File origin = new File(dateFolder+"/"+saveFileName + ".png");
						mFile.transferTo(origin);     // �뙆�씪 �뜲�씠�꽣瑜� 吏��젙�븳 �뤃�뜑濡� �씠�룞�븯�뒗 硫붿꽌�뱶
						
						isUpload = true;
					} catch (IllegalStateException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					} 
				}
			}
		}
		
		return isUpload;
	}
	
	
	// �뙆�씪�씠 蹂�寃쎈맆�븣 �궗�슜�븯�뒗 硫붿냼�뱶
	public boolean fileChangeUpload(MultipartHttpServletRequest mRequest, String sendPosition, String channelCode) {
		boolean isUpload = false;
		
		String uploadVideoPath = "/Users/maclee/Public/Spring/Github/Five_ONE_Final/Five_ONE_FINAL/src/main/webapp/resources/AllChannel/"; // MACBOOK
		
		// 梨꾨꼸 肄붾뱶 �삉�뒗 梨꾨꼸 �씠由�, �쁺�긽 �젣紐� 
		String saveFileName = "";
		String dateFolder = "";
		
		
		
		
					
		if(sendPosition.equals("profilChange")) { // �봽濡쒗븘 �뾽濡쒕뱶
			//thumbnail
			Iterator<String> iterator = mRequest.getFileNames();
			
			
			// �뱾�뼱�삤湲� �쟾遺��꽣 萸붽�瑜� �빐�빞�븷�벏...
			String extImgArr[] = { "png" };
			
			while(iterator.hasNext()) {
				
				String uploadFileName = iterator.next(); 
				MultipartFile mFile = mRequest.getFile(uploadFileName);
				
				String originalFileName = mFile.getOriginalFilename(); // �뙆�씪 �씠由� ���옣
				
				
				System.out.println("�뙆�씪�씠由�: " + originalFileName);
				
				dateFolder = uploadVideoPath + channelCode;
				File path1 = new File(dateFolder); // �뤃�뜑 寃쎈줈
				
				if(!path1.exists()) {
					path1.mkdirs();
				}
				
				// �떎�젣 ���옣�릺�뒗 �뙆�씪 �씠由�
				saveFileName = originalFileName;
				if (!saveFileName.equals("")) {
					saveFileName = channelCode+"-profil";
				}
				// �뙆�씪 ���옣 諛� �삁�쇅泥섎━
				try {
					// �뙆�씪 ���옣
					File origin = new File(dateFolder+"/"+saveFileName + ".png");
					mFile.transferTo(origin);     // �뙆�씪 �뜲�씠�꽣瑜� 吏��젙�븳 �뤃�뜑濡� �씠�룞�븯�뒗 硫붿꽌�뱶
					
					isUpload = true;
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} //while
		} else if(sendPosition.equals(sendPosition)){ //�떎瑜� �뙆�씪 �뾽濡쒕뱶
			
			uploadVideoPath = "/Users/maclee/Public/Spring/Github/Five_ONE_Final/Five_ONE_FINAL/src/main/webapp/resources/AllChannel/";
			
			Iterator<String> iterator = mRequest.getFileNames();
			String extMovieArr[] = {"mp4" };
			String extImgArr[] = {"png"};
			
			while(iterator.hasNext()) {
				String uploadFileName = iterator.next();
				MultipartFile mFile = mRequest.getFile(uploadFileName);
				String originalFileName = mFile.getOriginalFilename();
				
				dateFolder = uploadVideoPath + channelCode;
				File path1 = new File(dateFolder);
				
				File pathCheck = new File(dateFolder + "/" + originalFileName);
			}
			
		}
		return isUpload;
	} // fileUpload
	
	
}
