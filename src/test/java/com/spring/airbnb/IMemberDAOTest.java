package com.spring.airbnb;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring.airbnb.persistence.IMemberDAO;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class IMemberDAOTest {

	
	@Autowired
	private IMemberDAO mDao;
	
	@Test
	// 로그인시 회원id조회
	public void testGetMem() throws Exception{
		log.info("mDao.getMem() ===>" + mDao.read("test"));
	}
	
	@Test
	// 회원가입시 있는 아이디인지 조회
	public void testconfirmID() throws Exception{
		log.info("mDao.confirmID() ===>" + mDao.confirmID("test"));
	}

}
