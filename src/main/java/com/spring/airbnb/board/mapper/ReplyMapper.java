package com.spring.airbnb.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.airbnb.board.domain.Criteria;
import com.spring.airbnb.board.domain.ReplyDTO;

public interface ReplyMapper {
	public String getTime2();
	public int insert(ReplyDTO replyDto);	
	public ReplyDTO read(int rno);
	public int delete(int rno);
	public int update(ReplyDTO replyDto);
	public List<ReplyDTO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") int bno);
	public int getCountByBno(int bno);
	public int deleteAll(int bno);
	
}
