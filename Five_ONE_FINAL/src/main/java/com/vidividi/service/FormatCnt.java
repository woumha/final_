package com.vidividi.service;

import java.text.DecimalFormat;

public class FormatCnt {
	
	public static String format(int no) {
		
		String result = "";
		
		DecimalFormat df = new DecimalFormat("#.#");
		
		if(no >= 10000000) {
			result = df.format(no/10000000.0) +"천 만";
		}else if(no >= 10000) {
			result = df.format(no/10000.0) +"만";
		}else if(no >= 1000) {
			result = df.format(no/1000.0) +"천";
		}else {
			result = String.valueOf(no);
		}
		
		return result;
	}


}
