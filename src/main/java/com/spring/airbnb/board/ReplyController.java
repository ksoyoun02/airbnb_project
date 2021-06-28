package com.spring.airbnb.board;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.airbnb.board.domain.Criteria;
import com.spring.airbnb.board.domain.ReplyDTO;
import com.spring.airbnb.board.domain.ReplyPageDTO;
import com.spring.airbnb.board.service.IReplyService;

@RestController
//순수한 데이터를 반환하는 형태 (일반 문자열, json, xml...)
@RequestMapping("/replies")
// @AllArgsConstructor
// ->@Autowired 생략가능 (4.3부터)
public class ReplyController {

	//  < REST CRUD >
	// GET = SELECT,  POST = INSERT,  PUT = UPDATE,  DELETE = DELETE
	// josn 방식(문자열), xml 방식 (무거움, 객체개념, 가독성 떨어짐)
	@Autowired
	private IReplyService service;
	
	private static final Logger log = LoggerFactory.getLogger(ReplyController.class);
	
	/*
	 	@PathVariable : URL경로의 일부를 파라미터로 사용할 때 이용
	 	@RequestBody : JSON 데이터를 원하는 타입의 객체로 변환해야 하는 경우에 사용
	 */
	
	@PostMapping(value = "/new",
				consumes = "application/json",
				// @Consumes : 수신하고자 하는 데이터 포맷을 정의
				produces = {MediaType.TEXT_PLAIN_VALUE})
				// @Produces : 출력하고자 하는 데이터 포맷을 정의
	public ResponseEntity<String> create(@RequestBody ReplyDTO replyDto) {
										//@RequestBody - 화면으로부터 json 데이터 타입으로 보낼때 받을 수 있음
		log.info("ReplyDTO : " + replyDto);
		
		int insertCount = service.register(replyDto);
		log.info("Reply Insert Count : " + insertCount);
		
		return insertCount == 1 
							  ? new ResponseEntity<>("success!", HttpStatus.OK)
							  : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	// test json data -> {"bno":"1048618","replytext":"Hello Reply","replyer":"user00"}
	}
	
	@GetMapping(value = "/pages/{bno}/{page}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(
			@PathVariable("page") int page,
			@PathVariable("bno") int bno) {
		
		Criteria cri = new Criteria(page, 10);
		log.info("get Reply List bno : " + bno);
		log.info("cri : " + cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK);
		
	}
	
	@GetMapping(value = "/{rno}",
			produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyDTO> read(@PathVariable("rno") int rno){
		
		log.info("get: " + rno);
		
		return new ResponseEntity<>(service.read(rno), HttpStatus.OK);
		
	}
	
	
	@DeleteMapping(value = "/{rno}",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("rno") int rno) {
		log.info("remove : " + rno);
		
		return service.remove(rno) == 1
									  ? new ResponseEntity<>("remove reply success", HttpStatus.OK)
									  : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
					value = "/{rno}",
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyDTO replyDto, @PathVariable("rno") int rno) {
			replyDto.setRno(rno);
			
			log.info("rno : " + rno);
			log.info("modify : " + replyDto);
			
			return service.modify(replyDto) == 1
					? new ResponseEntity<>("update reply success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}












