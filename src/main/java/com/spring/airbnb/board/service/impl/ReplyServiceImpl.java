package com.spring.airbnb.board.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.airbnb.board.domain.Criteria;
import com.spring.airbnb.board.domain.ReplyDTO;
import com.spring.airbnb.board.domain.ReplyPageDTO;
import com.spring.airbnb.board.mapper.ReplyMapper;
import com.spring.airbnb.board.persistence.IBoardDAO;
import com.spring.airbnb.board.service.IReplyService;


@Service
public class ReplyServiceImpl implements IReplyService{
	
	@Autowired
	private ReplyMapper mapper;
	
	@Autowired
	private IBoardDAO boardDao;
	
	private static final Logger log = LoggerFactory.getLogger(ReplyServiceImpl.class);
	
	@Transactional
	@Override
	public int register(ReplyDTO replyDto) {
		// 댓글 작성
		// read.jsp의 #addReplyBtn 선택~
		log.info("reply register...." + replyDto);
		try {
			boardDao.updateReplyCnt(replyDto.getBno(), +1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapper.insert(replyDto);
	}

	@Override
	public ReplyDTO read(int rno) {
		// 댓글 읽기
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyDTO replyDto) {
		// 댓글 수정
		return mapper.update(replyDto);
	}
	
	@Transactional
	@Override
	public int remove(int rno) {
		// 댓글 삭제
		ReplyDTO replyDto = mapper.read(rno);
		try {
			boardDao.updateReplyCnt(replyDto.getBno() , +1);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyDTO> getList(Criteria cri, int bno) {
		// 댓글 리스트
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, int bno) {
		// 댓글 페이징
		return new ReplyPageDTO(
				mapper.getCountByBno(bno), 
				mapper.getListWithPaging(cri, bno));
	}

}
