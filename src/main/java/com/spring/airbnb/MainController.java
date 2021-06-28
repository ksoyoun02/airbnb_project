package com.spring.airbnb;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.airbnb.persistence.ISeasonDAO;
import com.spring.airbnb.persistence.IThemaDAO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/main")
public class MainController {
	
	@Autowired
	private ISeasonDAO season;
	
	@Autowired
	private IThemaDAO thema;

	@RequestMapping("")
	public String main() {
		log.info("main page");
		return "/main/mainPage";
	}
	
	@RequestMapping("/season")
	public String season(Model model) {
		log.info("season page");
		
		model.addAttribute("springList", season.listSpring());
		model.addAttribute("summerList", season.listSummer());
		model.addAttribute("fallList", season.listFall());
		model.addAttribute("winterList", season.listWinter());
		
		return "/main/season";
	}
	
	@RequestMapping("/thema")
	public String thema(Model model) {
		log.info("thema page");
		
		model.addAttribute("cultureList", thema.listCulture());
		model.addAttribute("activityList", thema.listActivity());
		model.addAttribute("healingList", thema.listHealing());
		
		return "/main/thema";
	}
}
