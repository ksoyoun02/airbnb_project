package com.spring.airbnb.board.domain;

import lombok.Data;

@Data
public class B_AttachFileDTO {

	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;
}
