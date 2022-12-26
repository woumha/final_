package com.vidividi.five.one;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vidividi.model.VidividiDAO;
import com.vidividi.variable.MainListDTO;
import com.vidividi.variable.PlaylistDTO;
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
	  public List<MainListDTO> search(@RequestParam("field") String field, @RequestParam("keyword") String keyword,
			  			@RequestParam("option") String option, int page) {

		 	int rowsize = 10;
			int startNo = (page * rowsize) - (rowsize - 1);
			int endNo = (page * rowsize);
		 
			List<MainListDTO> searchList = this.dao.searchVideoList(field, keyword, option, startNo, endNo);
			
			System.out.println("field>>>>" + field);
			System.out.println("keyword>>>" + keyword);
			
			return searchList; 
	  }
	 
	 
	 //ajax로 list출력(최신순)
	 @ResponseBody
	  @RequestMapping("search_result_new.do")
	  public List<MainListDTO> search_new(@RequestParam("field") String field, @RequestParam("keyword") String keyword, 
			  @RequestParam("option") String option, int page) {

		 	int rowsize = 10;
			int startNo = (page * rowsize) - (rowsize - 1);
			int endNo = (page * rowsize);
		 
			List<MainListDTO> searchList2 = this.dao.searchVideoList_new(field, keyword, option, startNo, endNo);
			
			return searchList2; 
		 
	  }
	 
	 	//재생목록 리스트 불러오기
	 	@ResponseBody
		@RequestMapping("playList_result.do")
		public List<PlaylistDTO> list(@RequestParam("play_code") String play_code) {
			
			System.out.println("playListlist 메소드 실행");
			
			List<PlaylistDTO> p_list = this.dao.getPlaylistList(play_code);
			
			System.out.println("p_list>>>" + p_list);
			System.out.println("play_code>>" + play_code);
			
			return p_list;
		}
	  

}
