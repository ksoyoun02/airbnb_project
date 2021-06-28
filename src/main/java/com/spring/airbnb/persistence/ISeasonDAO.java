package com.spring.airbnb.persistence;

import java.util.List;

import com.spring.airbnb.domain.SeasonDTO;

public interface ISeasonDAO {

	public List<SeasonDTO> listSpring();
	public List<SeasonDTO> listSummer();
	public List<SeasonDTO> listFall();
	public List<SeasonDTO> listWinter();
	
	
	
}
