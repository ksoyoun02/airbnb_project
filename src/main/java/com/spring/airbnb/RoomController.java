package com.spring.airbnb;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.airbnb.domain.GRoomDTO;
import com.spring.airbnb.domain.ReserveDTO;
import com.spring.airbnb.domain.RoomDTO;
import com.spring.airbnb.persistence.IGRoomDAO;
import com.spring.airbnb.persistence.IReserveDAO;
import com.spring.airbnb.persistence.IRoomDAO;
import com.spring.airbnb.review.domain.ReviewDTO;
import com.spring.airbnb.review.persistence.IReviewDAO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/room")
public class RoomController {

	@Autowired
	private IRoomDAO room;
	
	@Autowired
	private IGRoomDAO groom;
	
	@Autowired
	private IReviewDAO review;
	
	@Autowired
	private IReserveDAO reserve;
	
	@RequestMapping("/roomList")
	public String RoomList(RoomDTO rDto, Model model) {
		log.info("list ==> " + rDto.toString());
		
		String sido = rDto.getR_sido();
		float map_code1 = 0;
		float map_code2 = 0;
		
		if(sido.equals("1835848")) {
			sido = "서울";
			map_code1 = (float) 33.450701;
			map_code2 = (float) 126.570667;
		}else if(sido.equals("1838524")) {
			sido = "부산";
			map_code1 = (float) 35.17996636771367;
			map_code2 = (float) 129.0748965907486;
		}else if(sido.equals("1835327")) {
			sido = "대구";
			map_code1 = (float) 35.798838;
			map_code2 = (float) 128.583052;
		}else if(sido.equals("1843561")) {
			sido = "인천";
			map_code1 = (float) 37.456143199324885;
			map_code2 = (float) 126.70590784492909;
		}else if(sido.equals("1841811")) {
			sido = "광주";
			map_code1 = (float) 37.42950139754643;
			map_code2 = (float) 127.25514209820943;
		}else if(sido.equals("1835224")) {
			sido = "대전";
			map_code1 = (float) 36.35057765500597;
			map_code2 = (float) 127.38476505400395;
		}else if(sido.equals("1833747")) {
			sido = "울산";
			map_code1 = (float) 35.54260354162596;
			map_code2 = (float) 129.31216168181368;
			
		}
		model.addAttribute("sido", sido);
		model.addAttribute("map_code1", map_code1);
		model.addAttribute("map_code2", map_code2);
		
		//model.addAttribute("list", );
		if(rDto.getR_accomCheckIn() == "" || rDto.getR_accomCheckOut() == "") {
			model.addAttribute("period", "날짜를 선택하지 않았습니다");
		}else {
			model.addAttribute("checkIn", rDto.getR_accomCheckIn());
			model.addAttribute("checkOut", rDto.getR_accomCheckOut());
			model.addAttribute("period", rDto.getR_accomCheckIn() + "~" +rDto.getR_accomCheckOut());
		}
		
		model.addAttribute("roomList", room.listRoom(sido));
		return "/room/roomList";
	}
	
	@RequestMapping("/roomDetail")
	public String roomDetail(@RequestParam("r_code") String r_code, Model model) {
		
		log.info("roomDetail" + room.listDetailRoom(r_code));
		//int r_no = Integer.parseInt(r_code);

		model.addAttribute("roomDetail", room.listDetailRoom(r_code));
		model.addAttribute("g_roomList", groom.listGRoom(r_code));
		//model.addAttribute("reviewList", review.listReview(r_code));
		//model.addAttribute("reviewImgList", review.getAttachList(r_no));
		model.addAttribute("reviewList", review.reviewResult(r_code));
		
		
		return "/room/roomDetail";
	}
	
	@PostMapping("/reserveRoom")
	public String reserveRoom(@RequestParam("userId") String userId, ReserveDTO rDto, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("reserveRoom rDto ==>  " + rDto);
		
		HashMap<String, String> g_codeMap = new HashMap<>();
		g_codeMap.put("r_code", rDto.getR_code());
		g_codeMap.put("g_room", rDto.getR_g_name());
		
		// 숙소코드
		String g_code = reserve.selGCode(g_codeMap);
		System.out.println("g_code ===> "+g_code);
		
		// 방가격
		String r_price = reserve.selGPrice(g_code);
		System.out.println("g_price -> " + r_price);
		
		// 예약목록에 insert하기
		ReserveDTO reserveDto = new ReserveDTO();
		reserveDto.setId(userId);
		reserveDto.setR_name(rDto.getR_name());
		reserveDto.setR_code(rDto.getR_code());
		reserveDto.setR_g_code(g_code);
		reserveDto.setR_g_name(rDto.getR_g_name());
		reserveDto.setR_address(rDto.getR_address());
		reserveDto.setR_checkIn(rDto.getR_checkIn());
		reserveDto.setR_checkOut(rDto.getR_checkOut());
		reserveDto.setR_img(rDto.getR_img());
		reserveDto.setR_price(r_price);
		
		int result = reserve.reserveRoom(reserveDto);
		System.out.println("result -> " + result);
		
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		if(result > 0) {
			pw.print("<script>" + " alert('예약 성공.');" + " history.go(-1);" + "</script>");
		}else {
			pw.print("<script>" + " alert('다시 한번 시도해주세요');" + " history.go(-1);" + "</script>");
		}
		return null;
	}
	
	@RequestMapping("/roomInsert")
	public String roomInsert() throws Exception{
		log.info("roomInsert");
		
		return "room/roomInsert";
	}
	
	@Transactional
	@PostMapping("/roomInsert")
	public String roomInsert(RoomDTO rDto, @RequestParam("file") MultipartFile uploadFile, Model model) throws Exception{
		log.info("입력한 숙소정보 : " + rDto.toString());
		log.info("파일명 : " + uploadFile.getOriginalFilename());
		
		//파일명
		rDto.setR_img(uploadFile.getOriginalFilename());
		room.insertRoom(rDto);
		
		String r_code = rDto.getR_code();
		String fileName = uploadFile.getOriginalFilename();
		
		//파일 경로와 함께 db저장 (update)
		rDto.setR_img("/resources/roomImg/"+r_code+"/"+fileName);
		room.updateImg(rDto);
		
		model.addAttribute("roomInsert",rDto);
		model.addAttribute("r_code",rDto.getR_code());
		model.addAttribute("imgName",fileName);
		String uploadFolder = "C:\\sts-4.10.0.RELEASE\\airbnb\\src\\main\\webapp\\resources\\roomImg";
		File dir = new File(uploadFolder + File.separator + r_code);
		
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		log.info("===================================");
		log.info("Upload File Name : " + uploadFile.getOriginalFilename());
		log.info("Upload File Size : " + uploadFile.getSize());
		log.info("Upload File ContentType : " + uploadFile.getContentType());
		log.info("===================================");
		
		File saveFile = new File(dir, fileName);
		

		try {
			uploadFile.transferTo(saveFile);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
			return "room/roomInsert_result";
	}
	
	@RequestMapping("/g_roomInsert")
	public String g_roomInsert(@RequestParam("r_code") String r_code, Model model) {
		
		
		model.addAttribute("r_code", r_code);
		return "room/g_roomInsert";
	}
	
	@PostMapping("/g_roomInsert")
	public String g_roomInsert(ArrayList<GRoomDTO> grDto, Model model) {
		
		return "room/g_roomInsert_result";
	}
	
	@RequestMapping("/sample")
	public String sample() {
		
		return "room/sample";
	}
	
	 @GetMapping("/excel_download")
	    public void excelDownload(HttpServletResponse response, @RequestParam("r_code") String r_code) throws IOException {
//	        Workbook wb = new HSSFWorkbook();
	        Workbook wb = new XSSFWorkbook();
	        Sheet sheet = wb.createSheet("객실추가양식");
	        Row row = null;
	        Cell cell = null;
	        int rowNum = 0;

	        // Header
	        row = sheet.createRow(rowNum++);
	        cell = row.createCell(0);
	        cell.setCellValue("객실코드");
	        cell = row.createCell(1);
	        cell.setCellValue("객실이름");
	        cell = row.createCell(2);
	        cell.setCellValue("객실이미지");
	        cell = row.createCell(3);
	        cell.setCellValue("객실내용");
	        cell = row.createCell(4);
	        cell.setCellValue("기준인원");
	        cell = row.createCell(5);
	        cell.setCellValue("최대인원");
	        cell = row.createCell(6);
	        cell.setCellValue("대실시간");
	        cell = row.createCell(7);
	        cell.setCellValue("대실금액");
	        cell = row.createCell(8);
	        cell.setCellValue("숙박금액");

	        // Body
//	        for (int i=0; i<3; i++) {
//	            row = sheet.createRow(rowNum++);
//	            cell = row.createCell(0);
//	            cell.setCellValue(i);
//	            cell = row.createCell(1);
//	            cell.setCellValue(i+"_name");
//	            cell = row.createCell(2);
//	            cell.setCellValue(i+"_title");
//	        }

	        // 컨텐츠 타입과 파일명 지정
	        response.setContentType("ms-vnd/excel");
//	        response.setHeader("Content-Disposition", "attachment;filename=example.xls");
	        response.setHeader("Content-Disposition", "attachment;filename=groom_update.xlsx");

	        // Excel File Output
	        wb.write(response.getOutputStream());
	        
	    }
	 
	@PostMapping("/excel_upload")
	public String excel_upload (HttpServletResponse response, @RequestParam("uploadFile") MultipartFile file, @RequestParam("r_code") String r_code, Model model) throws Exception{
		List<GRoomDTO> dataList = new ArrayList<>();

	    String extension = FilenameUtils.getExtension(file.getOriginalFilename());

	    if (!extension.equals("xlsx")) {
	      throw new IOException("xlsx 파일만 업로드 해주세요.");
	    }

	    int result = 0;
	    Workbook workbook = null;
	   
	    workbook = new XSSFWorkbook(file.getInputStream());

	    Sheet worksheet = workbook.getSheetAt(0);
	  
	    for (int i = 1; i < worksheet.getPhysicalNumberOfRows(); i++) {

	      Row row = worksheet.getRow(i);

	      GRoomDTO data = new GRoomDTO();

	      data.setG_code(r_code + "-" +(String)row.getCell(0).getStringCellValue());
	      data.setG_name((String)row.getCell(1).getStringCellValue());
	      data.setG_img((String)row.getCell(2).getStringCellValue());
	      data.setG_content((String)row.getCell(3).getStringCellValue());
	      data.setG_minGuest((int)row.getCell(4).getNumericCellValue());
	      data.setG_maxGuest((int) row.getCell(5).getNumericCellValue());
	      data.setG_rentTime((String)row.getCell(6).getStringCellValue());
	      data.setG_rentPrice((String)row.getCell(7).getStringCellValue());
	      data.setG_accomPrice((int)row.getCell(8).getNumericCellValue());
	      data.setG_r_code((String)r_code);
	 
	      dataList.add(data);
	      
	      result = groom.insertGRoom(data);
	    }

	    response.setContentType("text/html; charset=UTF-8");
		PrintWriter pw = response.getWriter();
		
		if(result > 0) {
			pw.print("<script>" + " alert('객실업로드완료');" + " location.href='" + "/airbnb/main';" + "</script>");
		}else {
			pw.print("<script>" + " alert('다시 한번 시도해주세요');" + " history.go(-2);" + "</script>");
		}

	    return null;

	  
	
	 
}
}
