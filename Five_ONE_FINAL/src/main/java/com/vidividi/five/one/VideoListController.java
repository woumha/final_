package com.vidividi.five.one;

import java.util.List;

import javax.inject.Inject;

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
	
	//최신순 정렬
	@ResponseBody
	@RequestMapping("mainVideoList_up.do")
	public List<VideoPlayDTO> mainList_up(int page){
		
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<VideoPlayDTO> list2 = this.dao.mainVideo_up(startNo, endNo);
		
		return list2;
	}
	
	//소트 정렬
	@ResponseBody
	@RequestMapping("mainVideoList_sort_cook.do")
	public List<VideoPlayDTO> mainList_sort(int page){
		
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<VideoPlayDTO> list3 = this.dao.mainVideo_sort_music(startNo, endNo);
		
		return list3;
	}


}
