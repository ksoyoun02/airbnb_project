package com.spring.airbnb;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;

import com.spring.airbnb.domain.MemberDTO;
import com.spring.airbnb.mapper.MemberMapper;
import com.spring.airbnb.persistence.impl.MemberDAOImpl;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
				"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class MemberMapperTest {

//	@Setter(onMethod_ = @Autowired)
	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void testRead(){
		MemberDTO mDto = mapper.read("admin");
		log.info(mDto);
		
		mDto.getAuthList().forEach(authDTO -> log.info(authDTO));
	}
}
