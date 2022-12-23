package com.vidividi.five.one;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vidividi.model.ChannelDAO;
import com.vidividi.model.VidividiDAO;
import com.vidividi.variable.MainListDTO;
import com.vidividi.variable.VideoPlayDTO;

@Controller
public class VideoListController {
	
	@Inject
    private VidividiDAO dao;
	
	@Inject
	private ChannelDAO dao2;
	
	
	@ResponseBody
	@RequestMapping("mainVideoList.do")
	public List<MainListDTO> mainList(int page){
		
	 	int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<MainListDTO> list = this.dao.mainVideo(startNo, endNo);

		return list;
	}
	
	//최신순 정렬
	@ResponseBody
	@RequestMapping("mainVideoList_up.do")
	public List<MainListDTO> mainList_up(int page){
		
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<MainListDTO> list2 = this.dao.mainVideo_up(startNo, endNo);
		
		return list2;
	}
	
	//소트 정렬
	@ResponseBody
	@RequestMapping("mainVideoList_sort.do")
	public List<MainListDTO> mainList_sort(int page, @RequestParam("option") String option){
		
		int rowsize = 12;
		int startNo = (page * rowsize) - (rowsize - 1);
		int endNo = (page * rowsize);
		
		List<MainListDTO> list3 = this.dao.mainVideo_sort(startNo, endNo, option);
		
		System.out.println("소트 옵션>>>" + option);
		
		return list3;
	}


}
