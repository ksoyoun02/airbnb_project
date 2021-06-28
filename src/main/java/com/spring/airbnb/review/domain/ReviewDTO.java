package com.spring.airbnb.review.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewDTO{

	private int r_no;
	private String r_name;
	private String r_content;
	private String r_g_name;
	private String r_img;
	private String r_score;
	private String r_date;
	private String r_filename;
	private String r_id;
	private String r_r_code;
	private String r_g_code;
	private String reserve_code;
	
	private List<ReviewAttachDTO> reviewAttachList;
	
}
