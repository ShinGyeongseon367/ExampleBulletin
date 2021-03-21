package org.zerock.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleVO;
import org.zerock.domain.SampleVOList;
import org.zerock.domain.Ticket;
import org.zerock.domain.ToDoDTO;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {

	// 아래 사용되는 produces는 해당 메서드가 생산하는 MIME(Multipurpose Internet Mail Extensions) 타입을 의미한다.  
	// MIME는 이메일과 동봉할 파일을 텍스트 문자로 전환해서 이메일 시스템을 통해 전달하기 위해 개발되었기 때문에 이름이 InternetMailExtensions이다. 그렇지만 현재 웹을 통해 여러형태의 전달하는데 쓰이고 있다. 
	@GetMapping(value = "/getText", produces= "text/plain; charset=UTF-8")	
	public String getText() {
		
		log.info("MIME TYPE : " + org.springframework.http.MediaType.TEXT_PLAIN_VALUE);
		
		return "안녕하세요";
	}
	
	@GetMapping(value="/getSample", 
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE,
						MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSample() {
		
		return new SampleVO(112, "스타", "로드");
	}
	
	@GetMapping(value="/getSample2")
	public SampleVO getSameple2() {
		return new SampleVO(112, "start", "load");
	}
	
	@GetMapping("/getList")
	public List<SampleVO> getList() {
		List<SampleVO> list = new ArrayList<SampleVO>();
		for (int i=0; i < 10; i++) {
			list.add(new SampleVO(i, "스타", "크래"));
		}
		return list;
	}
	
	@GetMapping(value="/check", params= {"height", "weight"})
	public ResponseEntity<SampleVO> check(Double height, Double weight) {
		
		SampleVO vo = new SampleVO(0, ""+height, ""+weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if (height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
	}
	
	@GetMapping("/product/{cat}/{pid}")
	//pathvariable을 사용할 때는 int ,double같은 기본자료형은 사용할 수 없다. 
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") Integer pid) {
		
		return new String[] {"category:" + cat, "productid:"+pid};
	}
	
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		
		log.info("convert.......ticket" + ticket);
		
		return ticket;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(sdf, false));
	}
	
	@GetMapping("ex03")
	public String ex03(ToDoDTO todo) {
		
		log.info(todo);
		return "ex03";
	}
	
	@GetMapping("/ex04")
	public String ex04(SampleVO vo, int page) {
		
		log.info(vo);
		log.info(page);
		
		return "/sample/ex04";
	}
	
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("ex06......");
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("신경선");
		return dto;
	}
}

