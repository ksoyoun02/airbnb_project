package com.spring.airbnb.review.domain;

import lombok.Data;

@Data
public class ReviewAttachDTO {

	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean filetype;
	
	private int r_no;
	
}