package com.spring.airbnb.review.persistence.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.spring.airbnb.review.domain.ReviewAttachDTO;
import com.spring.airbnb.review.domain.ReviewDTO;
import com.spring.airbnb.review.domain.ReviewResultDTO;
import com.spring.airbnb.review.mapper.ReviewAttachMapper;
import com.spring.airbnb.review.persistence.IReviewDAO;

import lombok.extern.log4j.Log4j;

@Log4j
@Repository
public class ReviewDAOImpl implements IReviewDAO{

	@Autowired
	private SqlSession session;
	
	@Autowired
	private ReviewAttachMapper attachMapper;
		
	@Override
	public Integer getNewReviewNo() {
		
		return session.selectOne("ReviewMapper.getNewReviewNo");
	}

	@Transactional
	@Override
	public int create(ReviewDTO rDto) throws Exception{
		log.info("리뷰 등록하기 ====> " + rDto);
		
		int result = 0;
		result = session.insert("ReviewMapper.createReview", rDto);
		
		//review의 r_no(순차)를 추출해야함
		int reviewR_no = session.selectOne("ReviewMapper.selR_no", rDto.getR_no());
		
		
		if(rDto.getReviewAttachList() == null || rDto.getReviewAttachList().size() <= 0) {
			return result;
		}
		
		rDto.getReviewAttachList().forEach(attch -> {
			attch.setR_no(reviewR_no);
			attachMapper.insert(attch);
		});
		
		return result;
	
	}

	@Override
	public List<ReviewDTO> selUserReview(String userId) {
		
		return session.selectList("ReviewMapper.selUserReview", userId);
	}

	@Override
	public List<ReviewDTO> listReview(String r_code) {
		
		return session.selectList("ReviewMapper.reviewList", r_code);
	}

	@Override
	public int deleteReview(int r_no) {
		
		attachMapper.deleteAll(r_no);
		return session.delete("ReviewMapper.deleteReview" , r_no);
	}

	@Override
	public List<ReviewAttachDTO> getAttachList(int r_no) {
		return attachMapper.findByRno(r_no);
	}

	@Override
	public ReviewDTO already(int reserve_code) {
		
		return session.selectOne("ReviewMapper.already", reserve_code);
	}

	@Override
	public List<ReviewResultDTO> reviewResult(String r_code) {
		return attachMapper.reviewResult(r_code);
	}


}
