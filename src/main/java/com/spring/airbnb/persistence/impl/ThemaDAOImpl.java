package com.spring.airbnb.persistence.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.airbnb.domain.ThemaDTO;
import com.spring.airbnb.persistence.IThemaDAO;

@Repository
public class ThemaDAOImpl implements IThemaDAO{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<ThemaDTO> listCulture() {
		return session.selectList("ThemaMapper.cultureList");
	}

	@Override
	public List<ThemaDTO> listActivity() {
		return session.selectList("ThemaMapper.activityList");
	}

	@Override
	public List<ThemaDTO> listHealing() {
		return session.selectList("ThemaMapper.healingList");
	}

}
