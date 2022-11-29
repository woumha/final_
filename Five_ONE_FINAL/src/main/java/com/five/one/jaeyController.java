package com.five.one;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.youtube.model.DonghwanDAO;
import com.youtube.model.EunjiDAO;
import com.youtube.model.HochanDAO;
import com.youtube.model.JaeyDAO;
import com.youtube.model.SeungjunDAO;

@Controller
public class jaeyController {
	private DonghwanDAO donghwan;
	private EunjiDAO eunji;
	private HochanDAO hochan;
	private JaeyDAO jaey;
	private SeungjunDAO seungjun;
	
	@Inject
	private Upload upload;
	
	@RequestMapping("upload.do")
	public String uploadOk(Model model, MultipartHttpServletRequest mRequest) {
		
		model.addAttribute("File", upload.fileUpload(mRequest));
		
		return "upload_result";
	}
	
}
