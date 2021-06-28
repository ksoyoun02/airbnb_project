package com.spring.airbnb.domain;

import java.util.List;

import lombok.Data;

@Data
public class GRoomDTO {
	private String g_code;
	private String g_name;
	private String g_img;
	private String g_content;
	private int g_maxGuest;
	private int g_minGuest;
	private String g_rentTime;
	private String g_rentPrice;
	private int g_accomPrice;
	private String g_r_code;
	
	private List<GRoomDTO> grDtoList;

	
}
