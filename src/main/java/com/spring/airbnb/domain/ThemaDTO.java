package com.spring.airbnb.domain;

import java.io.Serializable;

import lombok.Data;


@Data
public class ThemaDTO implements Serializable{

	private static final long serialVersionUID = 1L;

	private int code;
	private String subject;
	private String tag;
	private String price;
	private String content;
	private String time;
	private String sido;
	private String img;
	private String place;
}
