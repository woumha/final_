package com.vidividi.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.security.SecureRandom;
import java.util.Collections;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.vidividi.variable.GoogleLoginDTO;
import com.vidividi.variable.KakaoLoginDTO;
import com.vidividi.variable.NaverLoginDTO;

@Service
public class SocialLoginService {
	
		static final String google_client_id = "279446786317-1d8b3dusm3g9oc69uvskvd84p04eira1.apps.googleusercontent.com";
		
		
	
	public GoogleLoginDTO decodeGoogleJWT(String jwt_token) throws GeneralSecurityException, IOException {
		// ajax에서 받아온 토큰 유효성 검사
		GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(), new GsonFactory())
				.setAudience(Collections.singletonList(google_client_id)).build();
		GoogleIdToken idToken = verifier.verify(jwt_token);
		
		// 토큰 디코딩
		if (idToken != null) {
		  Payload payload = idToken.getPayload();

		  String userId = payload.getSubject();
		  System.out.println("구글에서 보내준 ID: " + userId);

		  String email = payload.getEmail();
		  System.out.println("구글에서 보내준 이메일: " + email);
			/* boolean emailVerified = Boolean.valueOf(payload.getEmailVerified()); */
		  String name = (String) payload.get("name");
		  System.out.println("구글에서 보내준 이름: " + name);
		  String pictureUrl = (String) payload.get("picture");
			/*
			 * String locale = (String) payload.get("locale"); String familyName = (String)
			 * payload.get("family_name"); String givenName = (String)
			 * payload.get("given_name");
			 */
		  
		  GoogleLoginDTO dto = new GoogleLoginDTO();
		  
		  dto.setGoogle_id(userId);
		  dto.setGoogle_name(name);
		  dto.setGoole_pictureURL(pictureUrl);
		  dto.setGoogle_email(email);
		  
		  return dto;

		} else {
		  System.out.println("잘못된 jwt 토큰");
		  return null;
		}
	}
	
	
	
	public String getKakaoAccessToken(String code) {
		
		String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=36a540fc867285d0b0fa00df7d1a8569"); // REST_API_KEY
            sb.append("&redirect_uri=http://localhost:8282/one/kakao_login.do"); // 인가코드 받은 redirect_uri
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            //결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("카카오 access_token : " + access_Token);
            System.out.println("카카오 refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return access_Token;
	}
	
	
	public KakaoLoginDTO getKakaoData(String token) {
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		KakaoLoginDTO dto = new KakaoLoginDTO();

	    //access_token을 이용하여 사용자 정보 조회
	    try {
	       URL url = new URL(reqURL);
	       HttpURLConnection conn = (HttpURLConnection) url.openConnection();

	       conn.setRequestMethod("POST");
	       conn.setDoOutput(true);
	       conn.setRequestProperty("Authorization", "Bearer " + token); //전송할 header 작성, access_token전송

	       //결과 코드가 200이라면 성공
	       int responseCode = conn.getResponseCode();
	       System.out.println("카카오 응답 코드 : " + responseCode + "/ 200이면 성공");

	       //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	       BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	       String line = "";
	       String result = "";

	       while ((line = br.readLine()) != null) {
	           result += line;
	       }
	       System.out.println("카카오 응답 : " + result);

	       //Gson 라이브러리로 JSON파싱
	       JsonParser parser = new JsonParser();
	       JsonElement element = parser.parse(result);

	       String id = element.getAsJsonObject().get("id").getAsString();
	       boolean hasEmail = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("has_email").getAsBoolean();
	       String email = "";
	       if(hasEmail){
	           email = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("email").getAsString();
	       }
	       
	       String name = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("profile").getAsJsonObject().get("nickname").getAsString();
	       String profile_image = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("profile").getAsJsonObject().get("profile_image_url").getAsString();
	       
	       System.out.println("카카오에서 보내준 id : " + id);
	       System.out.println("카카오에서 보내준 email : " + email);
	       System.out.println("카카오에서 보내준 name : "+name);
	       System.out.println("카카오에서 보내준 profile_image : "+profile_image);
	       	       
	       dto.setKakao_id(id);
	       dto.setKakao_email(email);
	       dto.setKakao_name(name);
	       dto.setKakao_profile(profile_image);
	       
	       br.close();

	       } catch (IOException e) {
	            e.printStackTrace();
	       }
	    
	    return dto;
		
	}
	
	public String getNaverAuthUrl(HttpSession session) throws UnsupportedEncodingException {
		String clientId = "pxGGP8ZfRImO4dLuH7q4";//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode("http://localhost:8282/one/naver_login.do", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    session.setAttribute("state", state);
	    
		return apiURL;
	}
	
	
	public String getNaverAccessToken(String code, HttpSession session) {

		String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://nid.naver.com/oauth2.0/token";

        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //POST 요청을 위해 기본값이 false인 setDoOutput을 true로
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=pxGGP8ZfRImO4dLuH7q4"); // REST_API_KEY
            sb.append("&client_secret=fWz53whOXC");
            sb.append("&state="+session.getAttribute("state"));
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            //결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("네이버 응답 코드 : " + responseCode + "/ 200이면 성공");

            //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("네이버 응답 : " + result);

            //Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("네이버 access_token : " + access_Token);
            System.out.println("네이버 refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return access_Token;
	}
	
	public NaverLoginDTO getNaverData(String token) {
		String reqURL = "https://openapi.naver.com/v1/nid/me";
		NaverLoginDTO dto = new NaverLoginDTO();

	    //access_token을 이용하여 사용자 정보 조회
	    try {
	       URL url = new URL(reqURL);
	       HttpURLConnection conn = (HttpURLConnection) url.openConnection();

	       conn.setRequestMethod("POST");
	       conn.setDoOutput(true);
	       conn.setRequestProperty("Authorization", "Bearer " + token); //전송할 header 작성, access_token전송. 공백을 꼭 포함해야함..

	       //결과 코드가 200이라면 성공
	       int responseCode = conn.getResponseCode();
	       System.out.println("네이버 응답 코드 : " + responseCode + "/ 200이면 성공");

	       //요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
	       BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	       String line = "";
	       String result = "";

	       while ((line = br.readLine()) != null) {
	           result += line;
	       }
	       System.out.println("네이버 응답 : " + result);

	       //Gson 라이브러리로 JSON파싱
	       JsonParser parser = new JsonParser();
	       JsonElement element = parser.parse(result);
	       

	       String id = element.getAsJsonObject().get("response").getAsJsonObject().get("id").getAsString();
	       String email = element.getAsJsonObject().get("response").getAsJsonObject().get("email").getAsString();
	       String name = element.getAsJsonObject().get("response").getAsJsonObject().get("name").getAsString();
	       String profile_image = element.getAsJsonObject().get("response").getAsJsonObject().get("profile_image").getAsString();
	       String phone = element.getAsJsonObject().get("response").getAsJsonObject().get("mobile").getAsString();
	       String birthday = element.getAsJsonObject().get("response").getAsJsonObject().get("birthday").getAsString();
	       String birthyear = element.getAsJsonObject().get("response").getAsJsonObject().get("birthyear").getAsString();
	       
	       System.out.println("네이버에서 보내준 id : " + id);
	       System.out.println("네이버에서 보내준 email : " + email);
	       System.out.println("네이버에서 보내준 name : "+name);
	       System.out.println("네이버에서 보내준 profile_image : "+profile_image);
	       System.out.println("네이버에서 보내준 phone : "+phone);
	       System.out.println("네이버에서 보내준 birthyear + birthday : "+birthyear+"-"+birthday);
	       	       
	       dto.setNaver_id(id);
	       dto.setNaver_name(name);
	       dto.setNaver_email(email);
	       dto.setNaver_phone(phone);
	       dto.setNaver_profile(profile_image);
	       dto.setNaver_birth(birthyear+"-"+birthday);
	       
	       br.close();

	       } catch (IOException e) {
	            e.printStackTrace();
	       }
	    
	    return dto;
	}
	
}
