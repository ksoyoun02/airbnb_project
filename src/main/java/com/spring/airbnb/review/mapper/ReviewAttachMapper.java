package com.spring.airbnb.review.mapper;

import java.util.List;

import com.spring.airbnb.review.domain.ReviewAttachDTO;
import com.spring.airbnb.review.domain.ReviewDTO;
import com.spring.airbnb.review.domain.ReviewResultDTO;

public interface ReviewAttachMapper {
	public void insert(ReviewAttachDTO reviewAttachDto);
	public void delete(String uuid);
	public List<ReviewAttachDTO> findByRno(int rno);
	
	public void deleteAll(int rno);	
	
	public List<ReviewAttachDTO> getOldFiles();
	public List<ReviewResultDTO> reviewResult(String r_code);
}
