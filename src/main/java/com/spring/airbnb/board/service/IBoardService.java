package com.spring.airbnb.board.service;

import java.util.List;

import com.spring.airbnb.board.domain.BoardAttachDTO;
import com.spring.airbnb.board.domain.BoardDTO;
import com.spring.airbnb.board.domain.Criteria;

public interface IBoardService {
	public void register(BoardDTO bDto) throws Exception;
	public BoardDTO read(Integer bno) throws Exception;
	public boolean modify(BoardDTO bDto) throws Exception;
	public boolean remove(Integer bno) throws Exception;
	public List<BoardDTO> listAll(Criteria cri) throws Exception;
	public int getTotalCnt(Criteria cri) throws Exception;
	public List<BoardAttachDTO> getAttachList(int bno);
	

}
