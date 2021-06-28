package com.spring.airbnb.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.spring.airbnb.domain.MemberDTO;
import com.spring.airbnb.mapper.MemberMapper;
import com.spring.airbnb.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{

	@Setter(onMethod_ = {@Autowired})
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("Load User By UserName" + username);
			MemberDTO mDto = new MemberDTO();
			
		try {
			mDto = memberMapper.read(username);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		log.info("queried by member mapper : " + mDto);
		return mDto == null ? null : new CustomUser(mDto);
	}

}
