package com.spring.airbnb.persistence.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.airbnb.domain.ReserveDTO;
import com.spring.airbnb.persistence.IReserveDAO;

@Repository
public class ReserveDAOImpl implements IReserveDAO{

	@Autowired
	private SqlSession session;
	
	@Override
	public String selGCode(Map<String, String> g_codeMap) {
		return session.selectOne("ReserveMapper.selGCode", g_codeMap);
	}

	@Override
	public String selGPrice(String g_code) {
		return session.selectOne("ReserveMapper.selGPrice", g_code);
	}

	@Override
	public int reserveRoom(ReserveDTO rDto) {
		return session.insert("ReserveMapper.insertReserve", rDto);
	}

	@Override
	public List<ReserveDTO> listUserReserve(String userId) {
		return session.selectList("ReserveMapper.selUserReserve", userId);
	}

	@Override
	public int deleteReserve(int r_no) {
		
		return session.delete("ReserveMapper.deleteReserve" , r_no);
	}
}
