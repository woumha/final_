package com.vidividi.five.one;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.vidividi.model.VidividiDAO;
import com.vidividi.variable.TestDTO;

@Controller
public class TestController {
	
	@Inject
	private Upload upload;
	
	@Inject
	private VidividiDAO dao;
	
	@RequestMapping("upload.do")
	public String uploadOk(Model model, MultipartHttpServletRequest mRequest) {
		
		model.addAttribute("File", upload.fileUpload(mRequest));
		
		return "upload_result";
	}
	
	@RequestMapping("DBtest.do")
	public String testGO(Model model) {
		
		List<TestDTO> list = this.dao.test();
		model.addAttribute("Test", list);
		return "db_test";
	}
	
}
