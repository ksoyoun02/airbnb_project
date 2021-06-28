package com.spring.airbnb.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.airbnb.board.domain.BoardAttachDTO;
import com.spring.airbnb.board.domain.BoardDTO;
import com.spring.airbnb.board.domain.Criteria;
import com.spring.airbnb.board.mapper.BoardAttachMapper;
import com.spring.airbnb.board.mapper.ReplyMapper;
import com.spring.airbnb.board.persistence.IBoardDAO;
import com.spring.airbnb.board.service.IBoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements IBoardService{
	
	@Autowired
	private IBoardDAO bDao;
	
	@Autowired
	private BoardAttachMapper attachMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
	@Transactional
	@Override
	public void register(BoardDTO bDto) throws Exception {
		bDao.create(bDto);
		
		if(bDto.getAttachList() == null || bDto.getAttachList().size() <= 0) {
			return;
		}
		
		bDto.getAttachList().forEach(attch -> {
			attch.setBno(bDto.getBno());
			attachMapper.insert(attch);
		});
	}
		
		
								// 정상적으로 COMMIT 된 것만 읽어라
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardDTO read(Integer bno) throws Exception {
		bDao.updateViewCnt(bno);
		return bDao.read(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardDTO bDto) throws Exception {
		attachMapper.deleteAll(bDto.getBno());
		boolean modifyResult = bDao.update(bDto) == 1;
		
		log.info("modifyResult  ==> " + modifyResult);
		
		if(modifyResult && bDto.getAttachList().size() > 0) {
			bDto.getAttachList().forEach(attach -> {
				attach.setBno(bDto.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}
	
	@Transactional
	@Override
	public boolean remove(Integer bno) throws Exception {
		// 댓글 등록시 - 부모 먼저
		// 댓글 삭제시 - 자식 먼저
		attachMapper.deleteAll(bno);
		replyMapper.deleteAll(bno);
		return bDao.delete(bno) == 1;
	}

	@Override
	public List<BoardDTO> listAll(Criteria cri) throws Exception {
	
		return bDao.listAll(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		return bDao.getTotalCnt(cri);
	}


	@Override
	public List<BoardAttachDTO> getAttachList(int bno) {
		return attachMapper.findByBno(bno);
	}


	



}
