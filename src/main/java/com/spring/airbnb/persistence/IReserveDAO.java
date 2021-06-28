package com.spring.airbnb.persistence;

import java.util.List;
import java.util.Map;

import com.spring.airbnb.domain.ReserveDTO;

public interface IReserveDAO {

	public String selGCode(Map<String, String> g_codeMap);
	public String selGPrice(String g_code);
	public int reserveRoom(ReserveDTO rDto);
	public List<ReserveDTO> listUserReserve(String userId);
	public int deleteReserve(int r_no);
}
