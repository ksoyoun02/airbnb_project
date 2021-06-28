package com.spring.airbnb.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class RoomDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	
	private String r_code;
	private String r_name;
	private String r_address;
	private String r_img;
	private String r_service;
	private String r_score;
	private String r_price;
	private String r_sido;
	private String r_accomCheckIn;
	private String r_accomCheckOut;

}
