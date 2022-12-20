package com.vidividi.five.one;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vidividi.model.VidividiDAO;
import com.vidividi.variable.VideoPlayDTO;

@Controller
public class SearchController {
	
	 @Autowired
	 private VidividiDAO dao;
	 
	 //페이지 이동
	 @RequestMapping("search.do")
	  public String search(@RequestParam("field") String field, @RequestParam("auto_search") String keyword, Model model) {
			
			model.addAttribute("field", field);
			model.addAttribute("keyword", keyword);
					
			return "/search/mainSearch"; 
	  }
	 
	 
	 //ajax로 list출력(인기순)
	 @ResponseBody
	  @RequestMapping("search_result.do")
	  public List<VideoPlayDTO> search(@RequestParam("field") String field, @RequestParam("keyword") String keyword,
			  			@RequestParam("option") String option, int page) {

		 	int rowsize = 5;
			int startNo = (page * rowsize) - (rowsize - 1);
			int endNo = (page * rowsize);
		 
			List<VideoPlayDTO> searchList = this.dao.searchVideoList(field, keyword, option, startNo, endNo);
					
			return searchList; 
	  }
	 
	 
	 //ajax로 list출력(최신순)
	 @ResponseBody
	  @RequestMapping("search_result_new.do")
	  public List<VideoPlayDTO> search_new(@RequestParam("field") String field, @RequestParam("keyword") String keyword, 
			  @RequestParam("option") String option, int page) {

		 	int rowsize = 5;
			int startNo = (page * rowsize) - (rowsize - 1);
			int endNo = (page * rowsize);
		 
			List<VideoPlayDTO> searchList2 = this.dao.searchVideoList_new(field, keyword, option, startNo, endNo);
					
			return searchList2; 
		 
	  }
	 
	  
	  


}
