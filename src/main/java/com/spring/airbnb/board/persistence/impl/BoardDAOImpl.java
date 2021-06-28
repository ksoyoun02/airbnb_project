package com.spring.airbnb.board.persistence.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.airbnb.board.domain.BoardDTO;
import com.spring.airbnb.board.domain.Criteria;
import com.spring.airbnb.board.persistence.IBoardDAO;

@Repository
public class BoardDAOImpl implements IBoardDAO{
	
	@Autowired
	private SqlSession session;
	
	@Override
	// 게시물작성
	public void create(BoardDTO bDto) throws Exception {
		session.insert("BoardMapper.create", bDto);
		
	}

	@Override
	// 게시물 읽기
	public BoardDTO read(Integer bno) throws Exception {
		return session.selectOne("BoardMapper.read", bno);
	}

	@Override
	// 게시물 수정
	public int update(BoardDTO bDto) throws Exception {
		return session.update("BoardMapper.update", bDto);
	}

	@Override
	// 게시물 삭제
	public int delete(Integer bno) throws Exception {
		return session.delete("BoardMapper.delete", bno);
	}

	@Override
	//게시물 리스트
	public List<BoardDTO> listAll(Criteria cri) throws Exception {
		return session.selectList("BoardMapper.getListWithPaging", cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		return session.selectOne("BoardMapper.getTotalCnt", cri);
	}

	@Override
	public void updateViewCnt(Integer bno) throws Exception {
		session.update("BoardMapper.updateViewCnt", bno);
		
	}

	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		
		paramMap.put("bno", bno);
		paramMap.put("amount", amount);
		
		session.update("BoardMapper.updateReplyCnt", paramMap);
		
	}

	



}
