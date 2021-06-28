package com.spring.airbnb.domain;


import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberDTO{

	private String id;
	private String pwd;
	private String name;
	private String email;
	private String address;
	private String phone;
	private String useryn;
	private Date indate;
	private String zip_num;
	private boolean enabled;
	
	private List<AuthDTO> authList;

	
}
