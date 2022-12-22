package com.vidividi.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import javax.inject.Inject;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import com.vidividi.model.MemberDAO;
import com.vidividi.variable.LoginHistoryDTO;

@Service
public class LoginHistoryService {
	
	@Inject
	private MemberDAO dao;
	
	public void setLoginData(String memberCode) throws Exception {

		URL url = new URL("http://ip-api.com/json");
		
		BufferedReader input = new BufferedReader(new InputStreamReader(url.openStream()));
		
		String line = "";
		StringBuffer sb = new StringBuffer();
		
		while((line = input.readLine()) != null) {
			System.out.println(line);
			sb.append(line);
		}
		
		input.close();
		
		JSONObject jobj = new JSONObject(sb.toString());
		
		String login_country = (String)jobj.getString("country");
		String login_region = (String)jobj.get("regionName");
		String login_city = (String)jobj.get("city");
		String login_ip = (String)jobj.get("query");
		
		LoginHistoryDTO dto = new LoginHistoryDTO();
		
		dto.setMember_code(memberCode);
		dto.setLogin_country(login_country);
		dto.setLogin_region(login_region);
		dto.setLogin_city(login_city);
		dto.setLogin_ip(login_ip);
		
		dao.insertLoginHistory(dto);
				
	}
	
	/*
	 * public List<LoginHistoryDTO> getLoginHistory(String memberCode){ return
	 * dao.getLoginHistroy(memberCode); }
	 */
}
