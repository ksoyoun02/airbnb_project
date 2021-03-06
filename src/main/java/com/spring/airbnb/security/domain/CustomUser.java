package com.spring.airbnb.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.spring.airbnb.domain.MemberDTO;

public class CustomUser extends User{

	private static final long serialVersionUID = 1L;
	
	private MemberDTO member;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	
	}

	public CustomUser(MemberDTO mDto) {
		super(mDto.getId(), mDto.getPwd(), mDto.getAuthList().stream()
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		
		this.member = mDto;
}
}