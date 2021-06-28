package com.spring.airbnb.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	private static final String LOGIN = "loginUser";
	private static final Logger log =
			LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		HttpSession session = request.getSession();
		ModelMap modelMap = modelAndView.getModelMap();
		Object memInfo = modelMap.get("memInfo");
		
		if (memInfo != null) {
			log.info("new login success");
			session.setAttribute(LOGIN, memInfo);
			
			Object dest = session.getAttribute("dest");
//			response.sendRedirect("/");
			if (dest == null) {
				dest = "/main";
			}
			
			log.info("LoginInterceptor Dest : " + dest);
			
			modelAndView.setViewName("redirect:" + (String)dest);
			
		}
	} 
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute(LOGIN) != null) {
			log.info("clear login data before");
			session.removeAttribute(LOGIN);
		}
		return true;
	}
}





















