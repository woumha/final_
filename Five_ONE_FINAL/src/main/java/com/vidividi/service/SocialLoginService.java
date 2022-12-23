package com.vidividi.service;

import java.io.IOException;
import java.security.GeneralSecurityException;
import java.util.Collections;

import org.springframework.stereotype.Service;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.vidividi.variable.GoogleLoginDTO;

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
	
}
