package com.vidividi.five.one;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.vidividi.model.ChannelDAO;
import com.vidividi.model.MemberDAO;
import com.vidividi.model.VidividiDAO;
import com.vidividi.variable.ChannelDTO;
import com.vidividi.variable.MemberDTO;


@Controller
public class HomeController {
	
	@Inject
    private VidividiDAO dao;

    @Inject
    private MemberDAO memberDAO;
    
    @Inject
    private ChannelDAO channelDAO;

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model, HttpSession session) {

        if (session.getAttribute("MemberCode")!=null) {
            String memberCode = (String)session.getAttribute("MemberCode");
            String repChannelCode = (String)session.getAttribute("RepChannelCode");
            MemberDTO memberDTO = memberDAO.getMember(memberCode);
            //String repChannelPsa = ChannelDAO.getChannelPsa(repChannelCode);

            model.addAttribute("MemberCode", memberCode);
            model.addAttribute("MemberName", memberDTO.getMember_name());
            //model.addAttribute("RepChannelPsa", repChannelPsa);
            model.addAttribute("RepChannelCode", repChannelCode);
        }

        return "main";

    }
   
   
    
}
