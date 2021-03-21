package org.zerock.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

// 해당 객체가 스프링의 컨트롤러에서 발생하는 예외를 처리하는 존쟁임을 명시하는 용도
@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	
	// ExceptionHandler는 ()안에 들어가 있는 예외를 처리하겠다 
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		log.error("exception : " + ex);
		model.addAttribute("exception", ex);
		log.error(model);
		
		return "/error_page";
	}
	
	/* 정리하면 Contorller에서 발생하는 예외처리를 ControllerAdvice에서 진행을 하고 관리하고 싶은 exception을 ExceptionHandler를 통해서 처리를 해주는 것이다. */
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		return "custom404";
	}
	
}
