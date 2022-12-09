package com.vidividi.five.one;

import java.util.List;

import javax.inject.Inject;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vidividi.model.VidividiDAO;
import com.vidividi.variable.VideoPlayDTO;

@Controller
public class VideoListController {
	
	@Inject
    private VidividiDAO dao;
	
	@ResponseBody
	@RequestMapping(value = "/ajax/main_video.do")
	public JSONArray video_list(@RequestParam("video_option") String video_option){
		
		JSONArray jArray = new JSONArray();
		
		List<VideoPlayDTO> list = this.dao.video(video_option);
		
		for(VideoPlayDTO dto : list) {
			
			JSONObject json = new JSONObject();
		
			json.put("video_title", dto.getVideo_title());
			json.put("video_cont", dto.getVideo_cont());
			json.put("channel_name", dto.getChannel_name());
			json.put("video_view_cnt", dto.getVideo_view_cnt());
			json.put("video_regdate", dto.getVideo_regdate());
			json.put("video_good", dto.getVideo_good());
			
			jArray.put(json);
		}
		
		return jArray;
	}
    

}
