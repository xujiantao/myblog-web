package me.jiantao.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CommonController {
	
	@RequestMapping("/404")
	public ModelAndView to404(){
		ModelAndView mv = new ModelAndView("404");
		return mv;
	}
	
	@RequestMapping("/500")
	public ModelAndView to500(){
		ModelAndView mv = new ModelAndView("500");
		return mv;
	}
	
}
