package com.spring.airbnb.persistence.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.airbnb.domain.GRoomDTO;
import com.spring.airbnb.persistence.IGRoomDAO;

@Repository
public class GRoomDAOImpl implements IGRoomDAO{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<GRoomDTO> listGRoom(String r_code) {
		return session.selectList("GRoomMapper.g_roomList", r_code);
	}

	@Override
	public Integer insertGRoom(GRoomDTO grDto) {
		return session.insert("GRoomMapper.insertGRoom", grDto);
	}


}
