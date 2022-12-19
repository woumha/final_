package com.vidividi.five.one;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;

import com.vidividi.model.VidividiDAO;
import com.vidividi.variable.VideoPlayDTO;

@Controller
public class VideoListController {
	
	@Inject
    private VidividiDAO dao;
	
	@ResponseBody
	@RequestMapping("mainVideoList.do")
	public List<VideoPlayDTO> mainList(int page){
		
	 	int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<VideoPlayDTO> list = this.dao.mainVideo(startNo, endNo);

		return list;
	}
	
	@ResponseBody
	@RequestMapping("mainVideoList_up.do")
	public List<VideoPlayDTO> mainList_up(int page){
		
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<VideoPlayDTO> list2 = this.dao.mainVideo_up(startNo, endNo);
		
		return list2;
	}


}
