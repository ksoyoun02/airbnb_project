package com.spring.airbnb.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.airbnb.board.domain.BoardAttachDTO;
import com.spring.airbnb.board.mapper.BoardAttachMapper;
import com.spring.airbnb.review.domain.ReviewAttachDTO;
import com.spring.airbnb.review.mapper.ReviewAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
//	@Scheduled(cron="0 * * * * *")
//	public void checkFiles() throws Exception{
//		log.warn("File Check Task run.........");
//		log.warn(("=========================="));
//	}
	
	@Setter(onMethod_ = {@Autowired})
	private BoardAttachMapper BoardAttachMapper;
	
	@Setter(onMethod_ = {@Autowired})
	private ReviewAttachMapper ReviewAttachMapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 0 2 * * *")
	public void checkFiles() throws Exception{
		
		log.warn("File Check Task run............");
		log.warn(new Date());
		
		List<BoardAttachDTO> B_fileList = BoardAttachMapper.getOldFiles();
		List<ReviewAttachDTO> R_fileList = ReviewAttachMapper.getOldFiles();
		
		//-----------------------------------------------------------------------------------
		List<Path> B_filelistPaths = B_fileList.stream()
				.map(vo -> Paths.get("D:\\sts-4.10.0.RELEASE\\airbnb\\src\\main\\webapp\\resources\\fileUpload", vo.getUploadPath(),
						vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());
		
		List<Path> R_filelistPaths = R_fileList.stream()
				.map(vo -> Paths.get("D:\\sts-4.10.0.RELEASE\\airbnb\\src\\main\\webapp\\resources\\fileUpload", vo.getUploadPath(),
						vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());
		
		//------------------------------------------------------------------------------------
		
		B_fileList.stream()
			.filter(vo -> vo.isFiletype() == true)
			.map(vo -> Paths.get("D:\\sts-4.10.0.RELEASE\\airbnb\\src\\main\\webapp\\resources\\fileUpload", vo.getUploadPath(),"s_" 
			+ vo.getUuid() + "_" +vo.getFileName())).forEach(B -> B_filelistPaths.add(B));
		
		R_fileList.stream()
		.filter(vo -> vo.isFiletype() == true)
		.map(vo -> Paths.get("D:\\sts-4.10.0.RELEASE\\airbnb\\src\\main\\webapp\\resources\\fileUpload", vo.getUploadPath(),"s_" 
		+ vo.getUuid() + "_" +vo.getFileName())).forEach(R -> R_filelistPaths.add(R));
		
		
		log.warn("=========================================================");
		
		B_filelistPaths.forEach(B -> log.warn(B));
		R_filelistPaths.forEach(R -> log.warn(R));
	
		File targetDir = Paths.get("D:\\sts-4.10.0.RELEASE\\airbnb\\src\\main\\webapp\\resources\\fileUpload", getFolderYesterDay()).toFile();
		
		File[] B_removeFiles = targetDir.listFiles(file -> B_filelistPaths.contains(file.toPath()) == false);
		File[] R_removeFiles = targetDir.listFiles(file -> R_filelistPaths.contains(file.toPath()) == false);
		
		log.warn("=========================================================");
		for (File file : B_removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		
		for (File file : R_removeFiles) {
			log.warn(file.getAbsolutePath());
			file.delete();
		}
		
				
		
	}
}
