package com.spring.airbnb.excel;

import java.io.FileInputStream;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelReadTest {
	public static void main(String[] args) throws Exception{
		
		try {
			FileInputStream file = new FileInputStream("C:\\sts-4.10.0.RELEASE\\airbnb\\src\\main\\webapp\\resources\\excel\\groom_update.xlsx");
			XSSFWorkbook workbook = new XSSFWorkbook(file);
			
			int rowNo = 0;
			int cellIndex = 0;
			
			
			XSSFSheet sheet = workbook.getSheetAt(0);
			
			int rows = sheet.getPhysicalNumberOfRows();
			for(rowNo = 1; rowNo < rows; rowNo++) {
				XSSFRow row = sheet.getRow(rowNo);
				if(row != null) {
					int cells = row.getPhysicalNumberOfCells();
					
					for(cellIndex = 0; cellIndex <= cells; cellIndex++) {
						XSSFCell cell = row.getCell(cellIndex);
						String value = "";
						if(cell == null) {
							continue;
						}else {
							switch (cell.getCellType()) {
							case XSSFCell.CELL_TYPE_FORMULA:
								value = cell.getCellFormula();
								break;
							case XSSFCell.CELL_TYPE_NUMERIC:
								value = cell.getNumericCellValue()+"";
								break;
							case XSSFCell.CELL_TYPE_STRING:
								value = cell.getStringCellValue()+"";
								break;
							case XSSFCell.CELL_TYPE_BLANK:
								value = cell.getBooleanCellValue()+"";
								break;
							case XSSFCell.CELL_TYPE_ERROR:
								value = cell.getErrorCellValue() + "";
								break;
							}
						}
						System.out.println(rowNo + "번 행 : " + cellIndex + "번 열 값은: "+value);
							
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
