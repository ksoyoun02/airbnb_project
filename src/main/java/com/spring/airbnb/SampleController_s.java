package com.spring.airbnb;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.airbnb.domain.SampleDTO;
import com.spring.airbnb.domain.SampleDTOList;
import com.spring.airbnb.domain.TodoDTO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/sample")
public class SampleController_s {

	private static final Logger logger = LoggerFactory.getLogger(SampleController_s.class);
	
	@RequestMapping("/star")
	public void basic() {
		logger.info("basic1..");
		log.info("basic2...");
	}
	@RequestMapping("/craft")
	// 기본은 get
	public void basic1() {
		logger.info("basic3 .............");
		log.info("basic4 ...............");
	}
	
	// get/post 둘 다 읽을 수 있음
	@RequestMapping(value = "/basic", method = {RequestMethod.GET, RequestMethod.POST})
	public void basicGet() {
		logger.info("basicGet1 .............");
		log.info("basicGet2 ...............");
	}
	
	@RequestMapping(value = "/basic1", method = {RequestMethod.POST})
	public void basicPost() {
		logger.info("basicPost1 .............");
		log.info("basicPost2 ...............");
	}
	
	@RequestMapping(value = "/basic1", method = {RequestMethod.GET})
	public void basicGet2() {
		logger.info("basicGet3 .............");
		log.info("basicGet4 ...............");
	}
	
	// 뒤에 설정 안하면 get 방식
	@RequestMapping("/basicOnlyGet")
	public void basicGet3() {
		logger.info("basic Get Only 5 .............");
		log.info("basic Get Only 6...............");
	}
	
	@RequestMapping("/basicOnlyGet1")
	public void basicPost2() {
		logger.info("basic Get Only Post3 .............");
		log.info("basic Get Only Post4...............");
	}
	
	@RequestMapping("/ex01")
	public String ex01(SampleDTO sDto) {
		logger.info(sDto.toString());
		logger.info("" + sDto);
		log.info("" + sDto);
		logger.info("" + sDto.getSuperName());
		logger.info(sDto.getSuperName());
		logger.info("" + sDto.getAge());
		//logger.info(sDto.getAge());  -> int 값이여서 ""붙여줘야함ㄴ
		return "ex01";
	}

	@RequestMapping("/ex02")
	public String ex02(@RequestParam("name") String superName,
						@RequestParam("age") int superAge) {
		log.info("superName = " + superName);
		log.info("superAge = " + (superAge+1));
		SampleDTO sDto = new SampleDTO();
		sDto.setAge(superAge);
		sDto.setSuperName(superName);
		return "ex02";
	}
	
	@GetMapping("/ex02List")
	public String ex02List(@RequestParam("ids") ArrayList<String> ids) {
		log.info("ids : " + ids);
	
		log.info("======================");
		for (String idsStr : ids) {
			log.info(idsStr);
		}
		
		log.info(">======== 람다 출력 ==========<");
		ids.forEach(idsStr -> {log.info(idsStr);});
		return "ex02List";
	}
	
	@GetMapping("/ex02Bean")
	public String ex02Bean(SampleDTOList list) {
		log.info("list dtos : " + list);
		return "ex02Bean";
	}

	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		
		log.info("todo ==>" + todo);
		return "ex03";
	}
	
	
	/*
	 * @InitBinder public void initBinder(WebDataBinder binder) { SimpleDateFormat
	 * dataFormat = new SimpleDateFormat("yyyy-mm-dd");
	 * 
	 * binder.registerCustomEditor(java.util.Date.class, new
	 * CustomDateEditor(dataFormat, false)); }
	 */
	
}
