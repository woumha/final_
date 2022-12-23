package com.vidividi.service;

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailSendService {
	
	@Autowired
	private JavaMailSenderImpl mailsender;
	
	
	private int size;
	
	// 랜덤 숫자 생성
	private String makeRandomNumber() {
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		int num = 0;
		
		while (buffer.length() < size) {
			num = random.nextInt(10);
			buffer.append(num);
		}
		return buffer.toString();
	}
	
	// size자리 인증번호 얻어오기
		private String getKey(int size) {
			this.size = size;
			return makeRandomNumber();
		}
			
		
		
	// 메일을 보내고 해당 이메일로 전송되는 인증키를 반환하는 메서드
	public String sendAuthEmail(String email) {
		
		System.out.println("To.Email : " + email);
		
		String authKey = getKey(6);
		String setFrom = "vidivid.service@gmail.com";
		String toEmail = email;
		String title = "비디비디 이메일 인증 번호";
		
		StringBuffer mailContent = new StringBuffer();
		
		mailContent.append("<div>");
		mailContent.append("<div style='text-align: center;'>");
		mailContent.append("<img style='width: 300px' src='https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FA0vnu%2FbtrT5sokBPW%2FkVhdi9fiuDFk2PCAnWoNp1%2Fimg.png'>");
		mailContent.append("<h2>비디비디 이메일 인증</h2>");
		mailContent.append("</div>");
		mailContent.append("<div style='text-align: center; margin: auto; padding: 30px;'>");
		mailContent.append("<p>안녕하세요, 당신 근처의 비디오, 비디비디입니다.</p>");
		mailContent.append("<p>다음 인증 코드를 입력란에 입력해주세요.</p>");
		mailContent.append("<div style='margin: auto; padding: 20px'>");
		mailContent.append("<span style='letter-spacing: 20px; font-size: 20px; background-color: rgb(245,245,245); display: inline-block; padding-left: 20px;'>");
		mailContent.append(authKey);
		mailContent.append("</span>");
		mailContent.append("</div>");
		mailContent.append("<p>비디비디를 이용해주셔서 감사합니다.</p>");
		mailContent.append("</div>");
		mailContent.append("</div>");
		
		sendMail(setFrom, toEmail, title, mailContent.toString());
		
		return authKey;
	}
	
	
	
	// 실제 메일을 전송하는 메서드
	public void sendMail(String setFrom, String toEmail, String title, String mailContent) {

		MimeMessage message = mailsender.createMimeMessage();
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toEmail);
			helper.setSubject(title);
			helper.setText(mailContent.toString(), true);
			
			mailsender.send(message);
			
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}
