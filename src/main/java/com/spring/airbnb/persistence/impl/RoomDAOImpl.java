package com.spring.airbnb.persistence.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.airbnb.domain.RoomDTO;
import com.spring.airbnb.persistence.IRoomDAO;

@Repository
public class RoomDAOImpl implements IRoomDAO{

	@Autowired
	private SqlSession session;
	
	@Override
	public List<RoomDTO> listRoom(String sido) {
		return session.selectList("RoomMapper.roomList", sido);
	}

	@Override
	public RoomDTO listDetailRoom(String r_code) {
		return session.selectOne("RoomMapper.roomDetail", r_code);
	}

	@Override
	public Integer insertRoom(RoomDTO rDto) {
		return session.insert("RoomMapper.insertRoom", rDto);
	}

	@Override
	public Integer updateImg(RoomDTO rDto) {
		
		return session.update("RoomMapper.updateImg", rDto);
	}

	

}
