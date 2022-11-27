package com.five.one;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.youtube.model.DonghwanDAO;
import com.youtube.model.EunjiDAO;
import com.youtube.model.HochanDAO;
import com.youtube.model.JaeyDAO;
import com.youtube.model.SeungjunDAO;

@Controller
public class donghwanController {
	private DonghwanDAO donghwan;
	private EunjiDAO eunji;
	private HochanDAO hochan;
	private JaeyDAO jaey;
	private SeungjunDAO seungjun;
	
}
