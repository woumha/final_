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
import com.vidividi.variable.SearchPlayListDTO;
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
	public List<SearchPlayListDTO> list(@RequestParam("play_code") String play_code) {
			
		System.out.println("playListlist 메소드 실행");
			
		List<SearchPlayListDTO> p_list = this.dao.getPlaylistList(play_code);
			
		return p_list;
	}
	 
	 
	 @ResponseBody
	 @RequestMapping("playList_add.do")
	 public List<SearchPlayListDTO> insertPlayList(@RequestParam("play_code") String play_code,
			 										@RequestParam("play_video_code") String play_video_code,
			 										@RequestParam("play_bundle_code") String play_bundle_code,
			 										@RequestParam("play_bundle_title") String play_bundle_title){
		 
		 System.out.println("------------------------플레이 리스트 추가 메소드 실행---------------------------");
		 
		 System.out.println("멤버코드>>>" + play_code);
		 System.out.println("비디오코드>>>" + play_video_code);
		 System.out.println("play_bundle_code>>>" + play_bundle_code);
		 System.out.println("재생목록이름>>>" + play_bundle_title);
		 
		 List<SearchPlayListDTO> a_list = this.dao.insertPlaylistList(play_code, play_video_code, play_bundle_code, play_bundle_title);
		 
		 return a_list;
	 }
	 
	  

}
