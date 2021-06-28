package com.spring.airbnb.persistence;

import java.util.List;

import com.spring.airbnb.domain.ThemaDTO;

public interface IThemaDAO {

	public List<ThemaDTO> listCulture();
	public List<ThemaDTO> listActivity();
	public List<ThemaDTO> listHealing();
}
