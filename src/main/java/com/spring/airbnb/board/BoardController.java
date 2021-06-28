package com.spring.airbnb.board;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.airbnb.board.domain.BoardAttachDTO;
import com.spring.airbnb.board.domain.BoardDTO;
import com.spring.airbnb.board.domain.Criteria;
import com.spring.airbnb.board.domain.PageDTO;
import com.spring.airbnb.board.service.IBoardService;


@Controller
// @Controller를 사용하면 파라미터가 자동으로 수집됨
@RequestMapping("/board")
public class BoardController {
	
	private static final Logger logger =
				LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private IBoardService service;
	
	private String uploadPath = "D:\\sts-4.10.0.RELEASE\\springstudy\\src\\main\\webapp\\resources\\fileUpload";
	
	@RequestMapping("/list")
	public void listAll(Criteria cri, Model model) throws Exception{
		logger.info("show all list......" + cri);
									// default값 => Criteria(pageNum=1, amount=10)
		
		model.addAttribute("list", service.listAll(cri));
		
		int total = service.getTotalCnt(cri);
		logger.info("total : " + total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		
		//model.addAttribute("replyCnt", service.replycnt(bno));
		
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET() {
		logger.info("register get.....");
	}
	
	// board 글쓰기
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPOST(BoardDTO bDto, RedirectAttributes rttr) throws Exception{
							// register.jsp 에서 title, content, writer값 담아서 받음
							// RedirectAttributes -> 등록작업 후 목록화면으로 이동할때, 추가적으로 새롭게 등록된 게시물의 번호를 같이 전달하기위함.
		logger.info("register post.....");
		logger.info("/register  ===> " + bDto);
		
		logger.info("=============================================");
		
		if (bDto.getAttachList() != null) {
			bDto.getAttachList().forEach(attach -> logger.info("" + attach));
		}
		logger.info("=============================================");
		
		service.register(bDto);
		
		rttr.addFlashAttribute("result", bDto.getBno());
		// 새로 등록한 게시글 번호 
		return "redirect:/board/list";
		// redirect -> 스프링mvc가 내부적으로 response.sendRedirect()를 처리해줌
	}
	
//	// board 조회
//	@RequestMapping(value = "/read", method = RequestMethod.GET) 
//	public void read(@RequestParam("bno") int bno, Model model) throws Exception{
//		model.addAttribute("board", service.read(bno));
//		
//	}
//	
//	// board 수정
//	@RequestMapping(value = "/modify", method = RequestMethod.POST)
//	public String modifiyPost(BoardDTO bDto, RedirectAttributes rttr) throws Exception{
//		logger.info("modify post.....");
//		
//		if(service.modify(bDto)) {
//			rttr.addFlashAttribute("result", "success");
//		}else {
//			rttr.addFlashAttribute("result", "fail");
//		}
//			
//		return "redirect:/board/list";
//	}
	
	// 두개의 method 호출 방법!
	@RequestMapping(value = {"/read", "/modify"}, method = RequestMethod.GET)
	public void modifyGET(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		logger.info("/read or /modify............");
		
		model.addAttribute("board", service.read(bno));
		
		
	}
	
	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception{
		logger.info("remove............" + bno);
		
		List<BoardAttachDTO> attachList = service.getAttachList(bno);
		
		if(service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result","success");
		}else {
			rttr.addFlashAttribute("result","fail");
		}
		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		

		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modifyPOST(BoardDTO bDto, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception{
		logger.info("modify post...." + bDto);
		
		if(service.modify(bDto)) {
		
			rttr.addFlashAttribute("result", "success");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
		
//		return "redirect:/board/list" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList",
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
				// produces : 요청에 대한 필터링
	@ResponseBody //json 데이터 반환하기위해-
	public ResponseEntity<List<BoardAttachDTO>> getAttachList(int bno){
		// ResponseEntity -> HTTP 정보들을 담아서 전달
		
		logger.info("getAttachList : " + bno);
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	
	private void deleteFiles(List<BoardAttachDTO> attachList) {
	// 여기서만 쓸거라서 private
		if (attachList == null || attachList.size() == 0) {
			// -> 첨부파일이 없다
			return;
		}
		logger.info("delete attache files ...............");
		logger.info("" + attachList);
		
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
				logger.error("delete file error : " + e.getMessage());
			}
		});
	}

}











