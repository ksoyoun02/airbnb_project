package com.spring.airbnb.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
//모든 controller에서 예외가 발생하면 처리하겠다~
public class CommonExceptionAdvice {
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);
	
	//예외를 컨트롤 한다~
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		logger.error("Exception ........{}", ex);
								//ex가 {}안에 표시
								//....+ex와 비슷
		model.addAttribute("exception",ex);
					//식별자가 없을때는 변수 이름으로 호출됨
		logger.error("model ........{}", model);
		
		return "error_page";
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		return "custom404";
		
	}
}
