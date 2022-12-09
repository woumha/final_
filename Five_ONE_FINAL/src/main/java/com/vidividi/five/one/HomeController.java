package com.vidividi.five.one;

import java.text.DateFormat;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vidividi.model.MemberDAO;
import com.vidividi.model.VidividiDAO;
import com.vidividi.variable.MemberDTO;
import com.vidividi.variable.VideoPlayDTO;

@Controller
public class HomeController {
	
	@Inject
    private VidividiDAO dao;

    @Inject
    private MemberDAO memberDAO;

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);


    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model, HttpSession session) {

        List<VideoPlayDTO> list = this.dao.video();
        model.addAttribute("video_list", list);
        
        if (session.getAttribute("MemberCode")!=null) {
        	String memberCode = (String)session.getAttribute("MemberCode");
        	String lastChannelCode = (String)session.getAttribute("LastChannelCode");
        	System.out.println(memberCode);
			MemberDTO memberDTO = memberDAO.getMember(memberCode);
            model.addAttribute("MemberCode", memberCode);
			model.addAttribute("MemberName", memberDTO.getMember_name());
			model.addAttribute("LastChannelCode", lastChannelCode);
        }

        return "main";
        		
    }
}
