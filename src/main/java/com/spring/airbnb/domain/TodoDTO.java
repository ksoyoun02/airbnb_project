package com.spring.airbnb.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TodoDTO {
	
	private String title;
	
	
	// 날짜 변환, initbinder 필요 x
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date dueDate;

}
