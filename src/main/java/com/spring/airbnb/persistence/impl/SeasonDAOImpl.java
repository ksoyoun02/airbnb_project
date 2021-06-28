package com.spring.airbnb.persistence.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.airbnb.domain.SeasonDTO;
import com.spring.airbnb.persistence.ISeasonDAO;

@Repository
public class SeasonDAOImpl implements ISeasonDAO{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<SeasonDTO> listSpring() {
		return session.selectList("SeasonMapper.springList");
		
	}

	@Override
	public List<SeasonDTO> listSummer() {
		return session.selectList("SeasonMapper.summerList");
	}

	@Override
	public List<SeasonDTO> listFall() {
		return session.selectList("SeasonMapper.fallList");
	}

	@Override
	public List<SeasonDTO> listWinter() {
		return session.selectList("SeasonMapper.winterList");
		
	}

}
