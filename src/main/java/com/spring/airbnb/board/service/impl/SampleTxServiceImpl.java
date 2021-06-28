package com.spring.airbnb.board.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.airbnb.board.mapper.Sample1Mapper;
import com.spring.airbnb.board.service.ISampleTxService;


@Service
public class SampleTxServiceImpl implements ISampleTxService{

	@Autowired
	private Sample1Mapper mapper;
	
	private static final Logger log = 
			LoggerFactory.getLogger(SampleTxServiceImpl.class);
	
	// 둘 다 정상 작동하면 처리됨.
	@Transactional
	@Override
	public void addData(String value) {
			log.info("inserCol1.....");
			mapper.insertCol1(value);
			
			log.info("insertCol2...........");
			mapper.insertCol2(value);
			
			log.info("end............");
	}

}
