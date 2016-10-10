package me.jiantao.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import me.jiantao.common.Constant;
import me.jiantao.po.Me;
import me.jiantao.util.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {
	
	@RequestMapping("/login")
	public ModelAndView login(){
		ModelAndView mv = new ModelAndView("login/login");
		return mv;
	}
	
	@RequestMapping("/loginVerify")
	@ResponseBody
	public Map<String,Object> loginVerify(String username, String password, HttpSession session){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("status", 0);
		if(StringUtil.hasText(username) && StringUtil.hasText(password)){
			if("jiantao".equals(username) && "0.123jiantao".equals(password)){
				session.setAttribute(Constant.SESSION_ME, Me.getInstance());
				result.put("status", 1);
			}
		}
		return result;
	}
	
}
