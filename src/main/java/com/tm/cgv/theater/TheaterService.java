package com.tm.cgv.theater;



import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tm.cgv.cinema.CinemaRepository;
import com.tm.cgv.cinema.CinemaVO;
import com.tm.cgv.movieTime.MovieTimeRepository;
import com.tm.cgv.movieTime.MovieTimeVO;
import com.tm.cgv.seat.SeatRepository;
import com.tm.cgv.seat.SeatVO;
import com.tm.cgv.seatBooking.SeatBookingRepository;
import com.tm.cgv.seatBooking.SeatBookingVO;
import com.tm.cgv.seatSpace.SeatSpaceRepository;
import com.tm.cgv.seatSpace.SeatSpaceVO;
import com.tm.cgv.util.BitFilmType;

@Service
@Transactional
public class TheaterService {
	@Autowired
	private TheaterRepository theaterRepository;
	
	@Autowired
	private SeatRepository seatRepository;
	
	@Autowired
	private SeatSpaceRepository seatSpaceRepository;
	
	@Autowired
	private SeatBookingRepository seatBookingRepository;
	
	@Autowired
	private CinemaRepository cinemaRepository;
	
	@Autowired
	private MovieTimeRepository movieTimeRepository;
	
	//theater list
	public List<TheaterVO> theaterList()throws Exception{
		
		return theaterRepository.theaterList();
	}
	
	//cinema list
	public List<CinemaVO> cinemaList() throws Exception{
		return theaterRepository.cinemaList();
	}
	
	//theater name check
	public TheaterVO theaterNameCheck(TheaterVO theaterVO) throws Exception {
		return theaterRepository.theaterNameCheck(theaterVO);
	}
	
	//theater insert
	public int theaterInsert(TheaterVO theaterVO, int [] filmType, String [] row, String [] col, String [] grade, String [] row_space, String [] col_space) throws Exception{
		
		BitFilmType bitFilmType = new BitFilmType();

		//film type
		int film = 0;
		for(int i:filmType) {
			film += i;
		}
		theaterVO.setFilmType(film);
		
		
		//theaterVO Insert 하고 오기
		int result = theaterRepository.theaterInsert(theaterVO);
		int result2 = 0;
		if(result>0) {
			//맨 위에 있는 theater의 theaterNum 가져오기
			
			//System.out.println("theaterNum : " + theaterNum);
			
			//seatVO Insert하기
			for(int i=0; i<row.length; i++) {
				SeatVO seatVO = new SeatVO();
				seatVO.setTheaterNum(theaterVO.getNum());
				seatVO.setRowIdx(row[i]);
				seatVO.setColIdx(Integer.parseInt(col[i]));
				seatVO.setGrade(Integer.parseInt(grade[i]));
				result2 = seatRepository.seatInsert(seatVO);
			}
		}
		
		if(result2>0) {
			//seatSpaceVO Insert 하기
			//SeatNum 필요
			//int theaterNum = seatRepository.theaterSelect();
			SeatSpaceVO seatSpaceVO = new SeatSpaceVO();
			
			//row 넣기
			if(row_space!=null && row_space.length>0) {
				for(int i=0; i<row_space.length; i++) {
					//다녀오기
					seatSpaceVO.setTheaterNum(theaterVO.getNum());
					seatSpaceVO.setRowOrCol(0);
					seatSpaceVO.setIndex(Integer.parseInt(row_space[i]));
					seatSpaceRepository.seatSpaceInsert(seatSpaceVO);
				}
			}
			
			if(col_space!=null && col_space.length>0) {
				for(int i=0; i<col_space.length; i++) {
					//다녀오기
					seatSpaceVO.setTheaterNum(theaterVO.getNum());
					seatSpaceVO.setRowOrCol(1);
					seatSpaceVO.setIndex(Integer.parseInt(col_space[i]));
					seatSpaceRepository.seatSpaceInsert(seatSpaceVO);
				}
			}
		}
		
		
		//cinema table의 totalTheater, totalSeat 수정하기
		CinemaVO cinemaVO = new CinemaVO();
		cinemaVO.setNum(theaterVO.getCinemaNum());
		cinemaVO.setTotalSeat(theaterVO.getSeatCount());
		cinemaRepository.totalUpdate(cinemaVO);
		
		return result;
	}
	
	

	//Select
	public TheaterVO theaterSelect(int num) throws Exception {
		return theaterRepository.theaterSelect(num);
	}
	
	public List<SeatVO> theaterSeat(int num) throws Exception{
		return theaterRepository.theaterSeat(num);
	}
	
	public List<SeatSpaceVO> theaterSpace(int num) throws Exception{
		return theaterRepository.theaterSpace(num);
	}
	
	public String selectRow(int num) throws Exception{
		return theaterRepository.selectRow(num);
	}
	
	public int selectCol(int num) throws Exception{
		return theaterRepository.selectCol(num);
	}
	
	//Update
	public int theaterUpdate(TheaterVO theaterVO, int [] filmType, String [] row, String [] col, String [] grade, String [] row_space, String [] col_space, String [] stop_rc, String [] stop_idx) throws Exception{
		//theater update
		//film type
		int film = 0;
		for(int i:filmType) {
			film += i;
		}
		theaterVO.setFilmType(film);
		
		theaterRepository.theaterUpdate(theaterVO);
		//end theater update
		
		
		//seat update
		for(int i=0; i<row.length; i++) {

			SeatVO seatVO = new SeatVO();
			
			seatVO.setTheaterNum(theaterVO.getNum());
		
			System.out.println(">>>>>> UI 넘어온 seats");
			System.out.println("상영관 번호 : " + seatVO.getTheaterNum());
			seatVO.setRowIdx(row[i]);
			System.out.println("seat : " + row[i]+col[i]);
			seatVO.setColIdx(Integer.parseInt(col[i]));
			seatVO.setGrade(Integer.parseInt(grade[i]));

			Integer num = seatRepository.selectSeatNum(seatVO);
			seatVO.setNum(num);
			System.out.println("DB seat번호 : " + num);

			seatRepository.seatUpdate(seatVO);
		}
		//end seat update
		
		//seat space update
		System.out.println("before delete");
		//space 싹 지웠다가 
		seatSpaceRepository.seatSpaceDelete(theaterVO.getNum()); //>> cascade 때문에 안 될 것 같음
		System.out.println("after delete");
		//다시 하나씩 insert하기
		SeatSpaceVO seatSpaceVO = new SeatSpaceVO();
		seatSpaceVO.setTheaterNum(theaterVO.getNum());
		if(row_space!=null) {
			System.out.println(row_space.length);
			for(int i=0; i<row_space.length; i++) {
				seatSpaceVO.setRowOrCol(0);
				seatSpaceVO.setIndex(Integer.parseInt(row_space[i]));
				seatSpaceRepository.seatSpaceInsert(seatSpaceVO);
			}
		}
		if(col_space!=null) {
			for(int i=0; i<col_space.length; i++) {
				System.out.println("i : " + i);
				seatSpaceVO.setRowOrCol(1);
				System.out.println("col : " + seatSpaceVO.getRowOrCol());
				seatSpaceVO.setIndex(Integer.parseInt(col_space[i]));
				seatSpaceRepository.seatSpaceInsert(seatSpaceVO);
			}
		}
		//end seat space update
		
		//seat stop 
		if(stop_rc!=null) {
			List<SeatVO> stopSeat = seatRepository.selectStopSeat(theaterVO.getNum());
			System.out.println(stopSeat.size());
			System.out.println(stop_rc.length);
			
			List<Integer> movieTimeNum = movieTimeRepository.movieTimeList(theaterVO.getNum());
			System.out.println("size : " + movieTimeNum.size());
			
			for(int j=0; j<stop_rc.length; j++) {
				SeatVO seatVO = new SeatVO();
				seatVO.setTheaterNum(theaterVO.getNum());
				seatVO.setRowIdx(stop_rc[j]);	
				seatVO.setColIdx(Integer.parseInt(stop_idx[j]));
				int seatNum = seatRepository.selectSeatNum(seatVO);
				
				SeatBookingVO seatBookingVO = new SeatBookingVO();
				for(Integer i:movieTimeNum) {
					seatBookingVO.setSeatNum(seatNum);
					seatBookingVO.setMovieTimeNum(i);
					Integer result = seatBookingRepository.selectCheckExist(seatBookingVO);
					System.out.println("seatBooking에 존재여부 : "+result);
					
					if(result!=null) {
						//update
						seatBookingVO.setReservationNum(0);
						seatBookingRepository.updateReservationNum(seatBookingVO);
					}else {
						//insert
						seatBookingVO.setReservationNum(0);
						seatBookingRepository.insertReservationNum(seatBookingVO);
					}
				}
			}
			
			Set<String> stopSeatSet = new HashSet<String>();
			
			for (SeatVO seatVO : stopSeat) {
				stopSeatSet.add(seatVO.getRowIdx()+seatVO.getColIdx()); // ex) "A1"
			}
			
			System.out.println("stopSeatSet view");
			for (String string : stopSeatSet) {
				System.out.println(string);
			}
			
			for(int i=0; i<stop_rc.length; i++) {
				
				String compSeat = stop_rc[i] + stop_idx[i];
				System.out.println(compSeat);
				
				if(stopSeatSet.contains(compSeat))
					stopSeatSet.remove(compSeat);
			}
			
			int result = 0;
			System.out.println("stopSeatSet view2");
			for (String string : stopSeatSet) {
				String rc = string.substring(0,1);
				System.out.println("rc : " + rc);
				String idx = string.substring(1,2);
				System.out.println("idx : " + idx);
				SeatVO seatVO = new SeatVO();
				seatVO.setRowIdx(rc);
				seatVO.setColIdx(Integer.parseInt(idx));
				seatVO.setTheaterNum(theaterVO.getNum());
				int seatNum = seatRepository.selectSeatNum(seatVO);
				result = seatBookingRepository.deleteReservationNum(seatNum);
			}
			
			if(result>0)
				System.out.println("성공");
			
			
		}else {
			//null이면 해당 theaterNum의 seayBooking 0인 것 모두 삭제
			List<SeatVO> stopSeat = seatRepository.selectStopSeat(theaterVO.getNum());
			int result = 0;
			for(SeatVO k:stopSeat) {
				SeatVO seatVO = new SeatVO();
				seatVO.setRowIdx(k.getRowIdx());
				seatVO.setColIdx(k.getColIdx());
				seatVO.setTheaterNum(theaterVO.getNum());
				int seatNum = seatRepository.selectSeatNum(seatVO);
				result = seatBookingRepository.deleteReservationNum(seatNum);
			}
			
			if(result>0)
				System.out.println("삭제 성공");
			
			
		}
		//end stop update
		
		return theaterRepository.theaterUpdate(theaterVO);
	}
	
	
	
	//Delete
	public int theaterDelete(int num) throws Exception{
		System.out.println("service : " + num);
		//cinema table의 totalTheater-1, totalSeat-좌석수 한 후 delete하기
		TheaterVO theaterVO = theaterRepository.theaterSelect(num);
		int result =  cinemaRepository.theaterDelete(theaterVO);
		return theaterRepository.theaterDelete(num);
	}
	
	
	//MovieTimeInfo
	public List<MovieTimeVO> theaterMovieTime(Map<String, Object> d) throws Exception{
		List<MovieTimeVO> list = theaterRepository.theaterMovieTime(d);
		
		return list;
	}
	
	
	//MovieTime
	public List<String[]> movieTime(List<MovieTimeVO> list) throws Exception{
		//screenDate 년 월 일로 쪼개기
		//screen time -10분 >> 시작시간  >>시 분
		//screen tile + runtime + 10 >> 끝나는시간
		//영화제목 / 요일 / 시작 년 월 일 시 분 / 끝 년 월 일 시 분
		
		List<String[]> totalInfo = new ArrayList<>();
		//String [] info = new String[12];
		// 제목 / 요일 / 년 / 월 / 일 / 시 / 분 / 년 / 월 / 일 / 시 / 분  / 필름타입
		// 0    1    2   3   4  5   6   7   8   9  10  11    12
		
		for(int i=0; i<list.size(); i++) {
			String [] info = new String[13];
			//영화 제목
			String title = list.get(i).getMovieInfoVOs().getTitle();
			info[0] = title;
			System.out.println("영화 제목 : " + title);
			
			
			//요일
			String date = list.get(i).getScreenDate();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String[] week = {"일","월","화","수","목","금","토"}; 
			Calendar cal = Calendar.getInstance(); 
			Date getDate; 
			String day="";
			try { 
				getDate = format.parse(date);
				cal.setTime(getDate); 
				int w = cal.get(Calendar.DAY_OF_WEEK)-1; 
				System.out.println(date + "는 " + week[w] +"요일 입니다");
				day = week[w];
				} 
	//		catch (ParseException e) {
	//			e.printStackTrace(); 
	//		} 
			catch (Exception e) {
				e.printStackTrace(); 
			}
			
		
			info[1] = day;
		
			//년 월 일 2 3 4 7 8 9
			String [] d = date.split("-");
			System.out.println(d[0]);
			System.out.println(d[1]);
			System.out.println(d[2]);
			info[2] = d[0];
			info[3] = d[1];
			info[4] = d[2];
			
			info[7] = d[0];
			info[8] = d[1];
			info[9] = d[2];
			
			//시작 시간
			String screentime = list.get(i).getScreenTime();
			String [] s = screentime.split(":");
			int startH = Integer.parseInt(s[0]); 
			int startM = Integer.parseInt(s[1]);
			info[5] = s[0];
			info[6] = s[1];
			
			System.out.println(s[0]);
			System.out.println(s[1]);
			System.out.println("=================");
			System.out.println(d[0]);
			System.out.println(d[1]);
			System.out.println(d[2]);
			
			
			//runtime으로 끝나는 시간 구하기
			int run = Integer.parseInt(list.get(i).getMovieInfoVOs().getRuntime());
			int h = run/60;
			int m = run%60;
			System.out.println("=============");
			System.out.println("시작 시간 : " + startH);
			System.out.println("시작 분 : " + startM);
			
			System.out.println("=============");
			System.out.println("시간 : " + h);
			System.out.println("분 : " + m);
			
			String endH = String.valueOf(startH + h);
			String endM = String.valueOf(startM + m);
			System.out.println("=============");
			System.out.println("끝나는 시간 : " + endH);
			System.out.println("끝나는 분 : " + endM);
			
			info[10] = endH;
			info[11] = endM;
	
			info[12] = String.valueOf(list.get(i).getSelectedFilm());
			System.out.println("FilmType : " + info[12]);
			totalInfo.add(info);
			
		}
		
	
		return totalInfo;
	}
	
	
	//시작일 마지막일 계산
	public String[] searchTime(String checkDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		//날짜 검색이 아닌 기본일때
		if(checkDate==null) {
			checkDate = sdf.format(date);
			System.out.println("현재 날짜 생성 : " +checkDate);
		}
		
		
		String [] day = new String[2];
		System.out.println("checkDate : " + checkDate);
		//받아온 날짜의 주의 시작일, 마지막일을 계산 후 쿼리문에 보내주기......
		
		String dataString = checkDate;
	
		try {
			date = sdf.parse(dataString);
			System.out.println("date : " + date);
			
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		Calendar cal = Calendar.getInstance(Locale.KOREA);
		cal.setTime(date); //이거 뭐하는거지..?
		
		cal.add(Calendar.DATE, 2-cal.get(Calendar.DAY_OF_WEEK));
		System.out.println("월요일 날짜 : " + sdf.format(cal.getTime()) );
		String mon =  sdf.format(cal.getTime());

		
		cal.setTime(date);
		
		cal.add(Calendar.DATE, 8-cal.get(Calendar.DAY_OF_WEEK));
		System.out.println("일요일 날짜 : " + sdf.format(cal.getTime()));
		String sun = sdf.format(cal.getTime());
		
		day[0] = mon;
		day[1] = sun;
		
		return day;
	}

	
	

}
