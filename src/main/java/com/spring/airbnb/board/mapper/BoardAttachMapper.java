package com.spring.airbnb.board.mapper;

import java.util.List;

import com.spring.airbnb.board.domain.BoardAttachDTO;
import com.spring.airbnb.board.domain.BoardDTO;

public interface BoardAttachMapper {
	public void insert(BoardAttachDTO boardAttachDto);
	public void delete(String uuid);
	public List<BoardAttachDTO> findByBno(int bno);
	
	public void deleteAll(int bno);
	public void selFile(BoardAttachDTO boardAttachDto);
	public List<BoardAttachDTO> getOldFiles();

	
	
	
	

}
