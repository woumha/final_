package com.vidividi.five.one;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.vidividi.model.VidividiDAO;
import com.vidividi.variable.VideoPlayDTO;

@Controller
public class SearchController {
	
	@Autowired
	private VidividiDAO dao;
	
	  @RequestMapping("search.do") public String search(@RequestParam("field")String field, @RequestParam("keyword") String keyword, Model model) {
	  
		  List<VideoPlayDTO> searchList = this.dao.searchVideoList(field, keyword);
		 
		  model.addAttribute("Search", searchList);
		 
		  return "mainSearch"; 
	  }
	 

}
