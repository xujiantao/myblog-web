package me.jiantao.util;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public class ServletUtil {
	/**
	 * 转发
	 * @param path
	 * @param request
	 * @param response
	 */
	public static void forward(String path,HttpServletRequest request,HttpServletResponse response){
		try {
			request.getRequestDispatcher(path).forward(request, response);
		} catch (ServletException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void forward404(ModelAndView mv){
		mv.setViewName("404");
	}
	
	public static void forward404(HttpServletRequest request,HttpServletResponse response){
		String path="/404";
		forward(path, request, response);
	}
	
	public static void forward500(ModelAndView mv){
		mv.setViewName("500");
	}
	
	public static void forward500(HttpServletRequest request,HttpServletResponse response){
		String path="/500";
		forward(path, request, response);
	}
	
}
