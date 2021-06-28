package com.spring.airbnb.review.persistence;

import java.util.List;

import com.spring.airbnb.review.domain.ReviewAttachDTO;
import com.spring.airbnb.review.domain.ReviewDTO;
import com.spring.airbnb.review.domain.ReviewResultDTO;

public interface IReviewDAO {
	
	public Integer getNewReviewNo();
	public int create(ReviewDTO rDto) throws Exception;
	public List<ReviewDTO> selUserReview(String userId);
	public List<ReviewDTO> listReview(String r_code);
	public int deleteReview(int r_no);
	public List<ReviewAttachDTO> getAttachList(int r_no);
	public ReviewDTO already(int reserve_code);
	public List<ReviewResultDTO> reviewResult(String r_code);

	

}
