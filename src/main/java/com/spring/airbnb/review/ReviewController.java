package com.spring.airbnb.review;

import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.airbnb.domain.ReserveDTO;
import com.spring.airbnb.review.domain.ReviewAttachDTO;
import com.spring.airbnb.review.domain.ReviewDTO;
import com.spring.airbnb.review.persistence.IReviewDAO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	IReviewDAO review;
	
	private String uploadPath = "D:\\sts-4.10.0.RELEASE\\airbnb\\src\\main\\webapp\\resources\\fileUpload";
	
	@PostMapping("/reviewForm")
	public String reviewForm(ReserveDTO rDto, Model model, HttpServletRequest request) {
		
		log.info("reviewForm rDto ===> " + rDto);
		
		model.addAttribute("rDto", rDto);
		
		return "/review/reviewForm";
	}
	
	@PostMapping("/reviewAdd")
	public String reviewAdd(ReviewDTO rDto, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		rDto.setR_score(request.getParameter("score"));
		
		int reserve_code = rDto.getR_no();
		ReviewDTO alreadyDto = review.already(reserve_code);
		log.info("alreadyDto==> " + alreadyDto);
		log.info("리뷰 작성 ==> " + rDto);
		
		if(alreadyDto == null) {
			int result = review.create(rDto);
			
			log.info("====================================");
			
			if(rDto.getReviewAttachList() != null) {
				rDto.getReviewAttachList().forEach(attach -> log.info(attach));
			}
			
			log.info("===================================");
			
			
			
			if (result > 0) {
				pw.print("<script>" + " alert('후기작성완료');" + " history.go(-2);" + "</script>");
			}else {
				pw.print("<script>" + " alert('다시 한번 시도해 주세요');" + " history.go(-1);" + "</script>");
			}
			
		}else {
			pw.print("<script>" + " alert('이미 등록된 후기입니다');" + " history.go(-2);" + "</script>");
		}
		
		
		return null;
	}
	
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
			// produces : 요청에 대한 필터링
		@ResponseBody //json 데이터 반환하기위해-
		public ResponseEntity<List<ReviewAttachDTO>> getAttachList(int rno){
			// ResponseEntity -> HTTP 정보들을 담아서 전달
			
			log.info("getAttachList : " + rno);
			return new ResponseEntity<>(review.getAttachList(rno), HttpStatus.OK);
		}
	
	
	@GetMapping("deleteReview")
	public String deleteReview(@RequestParam("r_no") int r_no, HttpServletResponse response) throws Exception {
		
		log.info("온다");
		
		List<ReviewAttachDTO> attachList = review.getAttachList(r_no);
		
		deleteFiles(attachList);
		int result = review.deleteReview(r_no);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		if (result > 0) {
			pw.print("<script>" + " alert('후기삭제완료');" + " location.href='" + "/airbnb/member/mypage';" + "</script>");
		}else {
			pw.print("<script>" + " alert('다시 한번 시도해 주세요');" + " history.go(-1);" + "</script>");
		}
		
		
		return null;
	}
	
	private void deleteFiles(List<ReviewAttachDTO>attachList) {
			if (attachList == null || attachList.size() == 0) {
				return;
			}
			log.info("delete attache files ...............");
			log.info("" + attachList);
			
			attachList.forEach(attach -> {
				// io 객체를 사용하기위해 예외처리
				try {
					Path file = Paths.get(uploadPath + "\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
					Files.deleteIfExists(file);
						 // 존재한다면 삭제해라
					
					if (Files.probeContentType(file).startsWith("img")) {
						Path thumbNail = Paths.get(uploadPath + "\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
						Files.delete(thumbNail);
					}
				} catch (Exception e) {
					log.error("delete file error : " + e.getMessage());
				}
			});
		}
	
}
