package me.jiantao.web.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.jiantao.common.Constant;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 登录的拦截器
 * @author xujiantao
 *
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		Object obj = request.getSession().getAttribute(Constant.SESSION_ME);
		if(obj != null){
			return true;
		}else{
			request.getRequestDispatcher("/login").forward(request, response);
			return false;
		}
	}
	
}
