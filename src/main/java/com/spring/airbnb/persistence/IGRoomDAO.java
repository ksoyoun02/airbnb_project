package com.spring.airbnb.persistence;

import java.util.List;

import com.spring.airbnb.domain.GRoomDTO;

public interface IGRoomDAO {

	public List<GRoomDTO> listGRoom(String r_code);
	public Integer insertGRoom(GRoomDTO grDto);
}
