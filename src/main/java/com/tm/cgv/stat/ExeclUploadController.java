package com.tm.cgv.stat;

import java.io.IOException;

import org.apache.commons.io.FilenameUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tm.cgv.reservation.ReservationService;
import com.tm.cgv.reservation.ReservationVO;

@Controller
@RequestMapping("/excel/upload/**")
public class ExeclUploadController {
	
	@Autowired
	private ReservationService reservationService;
	
	
	@PostMapping("reservation")
	public ModelAndView readExcel(MultipartFile file, Model model) throws Exception { // 2
			ModelAndView mv = new ModelAndView();
		    String extension = FilenameUtils.getExtension(file.getOriginalFilename()); // 3

		    if (!extension.equals("xlsx") && !extension.equals("xls")) {
		      throw new IOException("엑셀파일만 업로드 해주세요.");
		    }

		    Workbook workbook = null;

		    if (extension.equals("xlsx")) {
		      workbook = new XSSFWorkbook(file.getInputStream());
		    } else if (extension.equals("xls")) {
		      workbook = new HSSFWorkbook(file.getInputStream());
		    }

		    Sheet worksheet = workbook.getSheetAt(0);

		    System.out.println(worksheet.getFirstRowNum());
		    System.out.println(worksheet.getLastRowNum());
		    for (int i = worksheet.getFirstRowNum(); i < worksheet.getLastRowNum(); i++) { // 4

		      Row row = worksheet.getRow(i);
	    	  ReservationVO reservationVO = new ReservationVO();

	    	  if(row.getCell(0) == null)
	    		  break;
	    	  
	    	  //num,uid,filmType,cinemaName,theaterName,seats,common,teenager,preference,totalPrice,creatAt
	    	  System.out.println("========================== "+i);
	    	  reservationVO.setNum(0);
	    	  reservationVO.setMovieNum((int)row.getCell(1).getNumericCellValue());
	    	  reservationVO.setPaymentNum((int)row.getCell(2).getNumericCellValue());
	    	  reservationVO.setMovieTimeNum((int)row.getCell(3).getNumericCellValue());
	    	  reservationVO.setUid(row.getCell(4).getStringCellValue());
	    	  reservationVO.setFilmType((int)row.getCell(5).getNumericCellValue());
	    	  reservationVO.setCinemaName(row.getCell(6).getStringCellValue());
	    	  reservationVO.setTheaterName(row.getCell(7).getStringCellValue());
	    	  reservationVO.setSeats(row.getCell(8).getStringCellValue());
	    	  reservationVO.setCommon((int)row.getCell(9).getNumericCellValue());
	    	  reservationVO.setTeenager((int)row.getCell(10).getNumericCellValue());
	    	  reservationVO.setPreference((int)row.getCell(11).getNumericCellValue());
	    	  reservationVO.setTotalPrice((int)row.getCell(12).getNumericCellValue());

	    	  reservationService.reservationInsert(reservationVO);
		      
		    }

		    mv.setViewName("redirect:../../admin/reservation/selectList");
		    return mv;
		  }
	
}
