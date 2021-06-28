package com.spring.airbnb;

import java.io.File;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.airbnb.board.domain.B_AttachFileDTO;
import com.spring.airbnb.review.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

@Controller
@Log4j
public class UploadController {
	
	
	private String uploadPath = "C:\\sts-4.10.0.RELEASE\\airbnb\\src\\main\\webapp\\resources\\fileUpload";
	
	public String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}

	public boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	@PostMapping(value = "/uploadReviewAction",
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>>
	uploadRevoewPost(MultipartFile[] uploadFile) {
		log.info("update ajax post.............");
		List<AttachFileDTO> attachList = new ArrayList<>();
		
		String uploadFolderPath = getFolder();
		
		File uploadFolder = new File(uploadPath, getFolder());
		log.info("uploadFolder path : " + uploadFolder);
		
		if(uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
			
		}
		
		for (MultipartFile multipartFile : uploadFile) {
			
			log.info("===================================");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			log.info("Upload File ContentType : " + multipartFile.getContentType());

			AttachFileDTO attachFileDto = new AttachFileDTO();
			String uploadFileName = multipartFile.getOriginalFilename();

			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("Only file name : " + uploadFileName);
			
			attachFileDto.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadFolder, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachFileDto.setUuid(uuid.toString());
				attachFileDto.setUploadPath(uploadFolderPath);
				
				if (checkImageType(saveFile)) {
					attachFileDto.setImage(true);
					
					File thumbnail = new File(uploadFolder, "s_" + uploadFileName);
					Thumbnails.of(saveFile).size(100, 100).toFile(thumbnail);
					
				}
				attachList.add(attachFileDto);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		
		return new ResponseEntity<>(attachList, HttpStatus.OK);
	}
	
	@PostMapping(value = "/uploadAjaxAction",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<B_AttachFileDTO>>
	uploadAjaxPost(MultipartFile[] uploadFile) {
	log.info("update ajax post.............");
	List<B_AttachFileDTO> attachList = new ArrayList<>();
	
	String uploadFolderPath = getFolder();
	
	File uploadFolder = new File(uploadPath, getFolder());
	log.info("uploadFolder path : " + uploadFolder);
	
	if(uploadFolder.exists() == false) {
		uploadFolder.mkdirs();
		
	}
	
	for (MultipartFile multipartFile : uploadFile) {
		
		log.info("===================================");
		log.info("Upload File Name : " + multipartFile.getOriginalFilename());
		log.info("Upload File Size : " + multipartFile.getSize());
		log.info("Upload File ContentType : " + multipartFile.getContentType());

		B_AttachFileDTO B_attachFileDto = new B_AttachFileDTO();
		String uploadFileName = multipartFile.getOriginalFilename();

		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
		log.info("Only file name : " + uploadFileName);
		
		B_attachFileDto.setFileName(uploadFileName);
		
		UUID uuid = UUID.randomUUID();
		
		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		try {
			File saveFile = new File(uploadFolder, uploadFileName);
			multipartFile.transferTo(saveFile);
			
			B_attachFileDto.setUuid(uuid.toString());
			B_attachFileDto.setUploadPath(uploadFolderPath);
			
			if (checkImageType(saveFile)) {
				B_attachFileDto.setImage(true);
				
				File thumbnail = new File(uploadFolder, "s_" + uploadFileName);
				Thumbnails.of(saveFile).size(100, 100).toFile(thumbnail);
				
			}
			attachList.add(B_attachFileDto);
			
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}
	
	return new ResponseEntity<>(attachList, HttpStatus.OK);
}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("fileName : " + fileName);
		
		File file = new File(uploadPath + "\\" + fileName);
		log.info("file : " +file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("deleteFile : " + fileName);
		
		HttpHeaders headers = new HttpHeaders();
		
		headers.add("Content-Type", "text/html;charset=UTF-8");
		
		File file;
		
		try {
			file = new File(uploadPath + "\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			if (type.equals("image")) {
				
				String largeFileName = file.getAbsolutePath().replace("\\s_", "\\");
				
				log.info("largeFileName : " + largeFileName);
				
				file = new File(largeFileName);
				file.delete();
			}
					
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<>("정상처리 되었습니다.", headers, HttpStatus.OK);
	}
}










