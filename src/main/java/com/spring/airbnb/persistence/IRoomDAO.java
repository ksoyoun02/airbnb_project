package com.spring.airbnb.persistence;

import java.util.List;

import com.spring.airbnb.domain.RoomDTO;

public interface IRoomDAO {

	public List<RoomDTO> listRoom(String sido);
	public RoomDTO listDetailRoom(String r_code);
	public Integer insertRoom(RoomDTO rDto);
	public Integer updateImg(RoomDTO rDto);

}
