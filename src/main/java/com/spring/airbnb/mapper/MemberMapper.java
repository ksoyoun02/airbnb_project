package com.spring.airbnb.mapper;

import com.spring.airbnb.domain.MemberDTO;

public interface MemberMapper {
	
	public MemberDTO read(String id);
}
