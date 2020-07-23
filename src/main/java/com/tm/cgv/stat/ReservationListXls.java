package com.tm.cgv.stat;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DataFormat;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractXlsView;

import com.tm.cgv.reservation.ReservationVO;

@Component("reservationListStat")
public class ReservationListXls extends AbstractXlsView {

    @Override
    protected void buildExcelDocument(
        Map<String, Object> model, Workbook workbook,
        HttpServletRequest request, HttpServletResponse response) throws Exception {

    	//헤더의 설정 변경
        response.setHeader("Content-Disposition", "attachment;filename=\"reservation.xls\"");
        
        //컨트롤러에서 받은 model값 
        List<ReservationVO> voList = (List<ReservationVO>)model.get("reservationList");

        //셀 스타일 지정
        CellStyle numberCellStyle = workbook.createCellStyle();
        
        DataFormat numberDataFormat = workbook.createDataFormat();
        numberCellStyle.setDataFormat(numberDataFormat.getFormat("#,##0"));

        CellStyle styleOfBoardFillFontBlack11 = workbook.createCellStyle();
        styleOfBoardFillFontBlack11.setFillForegroundColor(IndexedColors.LAVENDER.getIndex());

        
        //시트 생성(시트 제목)
        Sheet sheet = workbook.createSheet("sheet01");

        //vo의 크기 만큼 반복하며 각 셀에 값 지정
        //reservationVO : num,uid,filmType,cinemaName,theaterName,seats,common,teenager,preference,totalPrice,creatAt
        //movieInfoVO : title,runTime
        //movieTimeVO : screenTime,screenDate,
        //paymentVO : imp_uid,merchant_uid,pg,pay_method,apply_num
        ReservationVO stat = voList.get(0);
        Row row = sheet.createRow(0);
        
        Cell cell0 = row.createCell(0);
        cell0.setCellStyle(styleOfBoardFillFontBlack11);
        cell0.setCellValue("번호");
        Cell cell1 = row.createCell(1);
        cell1.setCellValue("아이디");
        Cell cell2 = row.createCell(2);
        cell2.setCellValue("필름타입");
        Cell cell3 = row.createCell(3);
        cell3.setCellValue("극장");
        Cell cell4 = row.createCell(4);
        cell4.setCellValue("상영관");
        Cell cell5 = row.createCell(5);
        cell5.setCellValue("좌석");
        Cell cell6 = row.createCell(6);
        cell6.setCellValue("일반");
        Cell cell7 = row.createCell(7);
        cell7.setCellValue("청소년");
        Cell cell8 = row.createCell(8);
        cell8.setCellValue("우대");
        Cell cell9 = row.createCell(9);
        cell9.setCellValue("총 결제액");
        Cell cell10 = row.createCell(10);
        cell10.setCellValue("예매일");
        Cell cell11 = row.createCell(11);
        cell11.setCellValue("제목");
        Cell cell12 = row.createCell(12);
        cell12.setCellValue("러닝타임");
        Cell cell13 = row.createCell(13);
        cell13.setCellValue("상영시간");
        Cell cell14 = row.createCell(14);
        cell14.setCellValue("상영날짜");
        Cell cell15 = row.createCell(15);
        cell15.setCellValue("imp_uid");
        Cell cell16 = row.createCell(16);
        cell16.setCellValue("merchant_uid");
        Cell cell17 = row.createCell(17);
        cell17.setCellValue("pg");
        Cell cell18 = row.createCell(18);
        cell18.setCellValue("pg_method");
        Cell cell19 = row.createCell(19);
        cell19.setCellValue("applyNum");
        
        
        
        for (int i = 1 ; i < voList.size() ; i++) {
            stat = voList.get(i);
            row = sheet.createRow(i);
            
            cell0 = row.createCell(0);
            cell0.setCellValue(stat.getNum());

            cell1 = row.createCell(1);
            cell1.setCellValue(stat.getUid());

            cell2 = row.createCell(2);
            cell2.setCellValue(stat.getFilmType());
            
            cell3 = row.createCell(3);
            cell3.setCellValue(stat.getCinemaName());

            cell4 = row.createCell(4);
            cell4.setCellValue(stat.getTheaterName());

            cell5 = row.createCell(5);
            cell5.setCellValue(stat.getSeats());
            
            cell6 = row.createCell(6);
            cell6.setCellValue(stat.getCommon());
            
            cell7 = row.createCell(7);
            cell7.setCellValue(stat.getTeenager());
            
            cell8 = row.createCell(8);
            cell8.setCellValue(stat.getPreference());
            
            cell9 = row.createCell(9);
            cell9.setCellType(CellType.NUMERIC);
            cell9.setCellValue(stat.getTotalPrice());
            cell9.setCellStyle(numberCellStyle);
            
            cell10 = row.createCell(10);
            cell10.setCellValue(stat.getCreateAt());
            
            //movieInfoVO
            cell11 = row.createCell(11);
            cell11.setCellValue(stat.getMovieInfoVO().getTitle());
            
            cell12 = row.createCell(12);
            cell12.setCellValue(stat.getMovieInfoVO().getRuntime());
            
            //MovieTimeVO
            cell13 = row.createCell(13);
            cell13.setCellValue(stat.getMovieTimeVO().getScreenTime());
            
            cell14 = row.createCell(14);
            cell14.setCellValue(stat.getMovieTimeVO().getScreenDate());
            
            //PaymentVO
            cell15 = row.createCell(15);
            cell15.setCellValue(stat.getPaymentVO().getImp_uid());
            
            cell16 = row.createCell(16);
            cell16.setCellValue(stat.getPaymentVO().getMerchant_uid());
            
            cell17 = row.createCell(17);
            cell17.setCellValue(stat.getPaymentVO().getPg());
            
            cell18 = row.createCell(18);
            cell18.setCellValue(stat.getPaymentVO().getPay_method());
            
            cell19 = row.createCell(19);
            cell19.setCellValue(stat.getPaymentVO().getApply_num());
            
            
        }

    }

}