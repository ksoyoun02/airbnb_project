package com.spring.airbnb.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class SeasonDTO implements Serializable{

	private static final long serialVersionUID = 1L;

	private int code;
	private String subject;
	private int month;
	private String img;
	private String tag;
	private String summary;
	private String sido;
	private String gungu;
}
