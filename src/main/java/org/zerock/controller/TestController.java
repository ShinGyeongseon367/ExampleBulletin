package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class TestController {

	@GetMapping("/temp")
	public String ex04(@RequestParam(required = false) String name) {
		log.info("name : " + name);
		return "/sample/ex04";
	}
	
	@GetMapping("/error")
	public String ex05(@RequestParam String name) {
		
		log.info("error");
		
		return "";
	}
}