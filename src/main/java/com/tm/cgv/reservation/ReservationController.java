package com.tm.cgv.reservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tm.cgv.couponInfo.CouponInfoService;
import com.tm.cgv.couponInfo.CouponInfoVO;
import com.tm.cgv.discountInfo.DiscountInfoService;
import com.tm.cgv.discountInfo.DiscountInfoVO;
import com.tm.cgv.guest.GuestService;
import com.tm.cgv.memberCoupon.MemberCouponService;
import com.tm.cgv.memberCoupon.MemberCouponVO;
import com.tm.cgv.movieInfo.MovieInfoService;
import com.tm.cgv.movieInfo.MovieInfoVO;
import com.tm.cgv.movieTime.MovieTimeService;
import com.tm.cgv.movieTime.MovieTimeVO;
import com.tm.cgv.payment.PaymentService;
import com.tm.cgv.point.PointService;
import com.tm.cgv.point.PointVO;
import com.tm.cgv.seat.SeatService;
import com.tm.cgv.seat.SeatVO;
import com.tm.cgv.seatBooking.SeatBookingService;
import com.tm.cgv.seatBooking.SeatBookingVO;
import com.tm.cgv.seatSpace.SeatSpaceService;
import com.tm.cgv.seatSpace.SeatSpaceVO;
import com.tm.cgv.timePrice.TimePriceService;
import com.tm.cgv.timePrice.TimePriceVO;
import com.tm.cgv.util.TimeADD;

@Controller
@RequestMapping("/reservation")
public class ReservationController {

	@Autowired
	private ReservationService reservationService;
	@Autowired
	private MovieInfoService movieInfoService;
	@Autowired
	private MovieTimeService movieTimeService;
	@Autowired
	private SeatService seatService;
	@Autowired
	private SeatSpaceService seatSpaceService;
	@Autowired
	private SeatBookingService seatBookingService;
	@Autowired
	private TimeADD timeAdd;
	@Autowired
	private PointService pointService;
	@Autowired
	private DiscountInfoService discountInfoService;
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private MemberCouponService memberCuponService;
	@Autowired
	private CouponInfoService cuponInfoService;
	@Autowired
	private TimePriceService timePriceService;
	@Autowired
	private GuestService guestService;
	
	
	
	
	
	//예매 취소
	@ResponseBody
	@GetMapping("reservationCancle")
	public int reservationCancle(ReservationVO reservationVO) throws Exception{
		int result = 0;
		
		//예매번호로 reservationVO 값 조회
		reservationVO = reservationService.reservationSelectOne(reservationVO);
		
		//좌석예약 DB삭제
		result = seatBookingService.seatBookingDelete(reservationVO.getNum());
		System.out.println("좌석예약 : "+result);
		
		//movieTime DB업데이트 - 잔여좌석 수정
		int totalCount = reservationVO.getCommon() + reservationVO.getTeenager() + reservationVO.getPreference();
		MovieTimeVO movieTimeVO = new MovieTimeVO();
		movieTimeVO.setNum(reservationVO.getMovieTimeNum());
		movieTimeVO.setRemainSeat(totalCount);
		result = movieTimeService.remainSeatSum(movieTimeVO);
		System.out.println("잔여좌석 : "+result);
		
		//포인트 DB업데이트 - (할인 정보 조회 -> 조회결과로 각 point 값 들 갱신)
		//1.할인정보 조회
		List<DiscountInfoVO> discountList = discountInfoService.discountInfoSelect(reservationVO.getNum());
		
		for (DiscountInfoVO vo : discountList) {
			if(vo.getType().equals("cgvCoupon")) { //2.멤버 할인쿠폰 갱신
				
				MemberCouponVO memberCuponVO = MemberCouponVO.builder().build();
				memberCuponVO.setKind("reserveDel");
				memberCuponVO.setUid(reservationVO.getUid());
				memberCuponVO.setCouponInfoNum(vo.getDiscountPrice());
				
				memberCuponService.memberCuponUpdate(memberCuponVO);
				
			}else { //2.point 정보 갱신
				PointVO pointVO = new PointVO();
				pointVO.setKind("sum");
				pointVO.setType(vo.getType());
				pointVO.setPrice(vo.getDiscountPrice());
				pointVO.setUsername(reservationVO.getUid());
				
				result = pointService.pointDiscountUpdate(pointVO);
				System.out.println("포인트 : "+result);
			}
			
		}
		
		//결제 DB삭제 -> 예매 삭제 -> 할인정보 삭제(cascade)
		//result = paymentService.paymentDelete(reservationVO.getPaymentNum());
		//System.out.println("결제 : "+result);
		
		//예매 DB삭제 - 결제 삭제시 casecade 할 필요 X (테스트용으로 필요)
		result = reservationService.reservationDelete(reservationVO);
		System.out.println("예매정보 : "+result);
		
		return result;
	}
	
	
	
	//예매 완료 페이지 
	@GetMapping("reservationResultSelectOne")
	public ModelAndView reservationResultSelectOne(String num) throws Exception{
		ModelAndView mv = new ModelAndView();

		//예매정보 
		ReservationVO reservationVO = reservationService.reservationResultSelectOne(Integer.parseInt(num));
		
		//EndTime
		int runningTime = Integer.parseInt(reservationVO.getMovieInfoVO().getRuntime()); 
		String startTime = reservationVO.getMovieTimeVO().getScreenTime();
		String endTime = timeAdd.timeAdd(startTime, runningTime);
		
		//할인 적용 정보
		List<DiscountInfoVO> discountInfoList = discountInfoService.discountInfoSelect(reservationVO.getNum());
		
		//쿠폰일때와 포인트 일때 구별
		for (DiscountInfoVO vo : discountInfoList) {
			if(vo.getType().equals("cgvCoupon")) {
				//쿠폰 번호로 해당 쿠폰의 금액 조회
				CouponInfoVO couponInfoVO = new CouponInfoVO();
				couponInfoVO.setNum(vo.getDiscountPrice());
				couponInfoVO = cuponInfoService.couponInfoSelect(couponInfoVO);
				
				discountInfoList.get(0).setDiscountPrice(couponInfoVO.getPrice());
			}
		}
		
		mv.addObject("endTime", endTime);
		mv.addObject("reservationVO", reservationVO);
		mv.addObject("discountInfoList", discountInfoList);
		
		mv.setViewName("movie/movieReservationResult");
		return mv;
	}
	
	
	//예매하기
	@ResponseBody
	@PostMapping("reservationInsert")
	public int reservationInsert(ReservationVO reservationVO,String selectedSeatNums,String[] discountList,int type,int couponNum) throws Exception{
		int result = 0;
		int seatCheck = 0;
		
		System.out.println("할인 타입(0없음/1쿠폰/2포인트/3비회원) : "+type);
		System.out.println("선택한 쿠폰 번호 : "+couponNum);
		
		//예매 번호 등록 - Reservation
		result = reservationService.reservationInsert(reservationVO);
		result = reservationVO.getNum();
		
		
		
		if(type != 0) {
			//할인정보 추가
			DiscountInfoVO discountInfoVO = new DiscountInfoVO();
			
			if(type == 1) {
				//멤버쿠폰 deleteAt 업데이트
				MemberCouponVO memberCuponVO = MemberCouponVO.builder().build();
				memberCuponVO.setUid(reservationVO.getUid());
				memberCuponVO.setCouponInfoNum(couponNum);
				
				memberCuponService.memberCuponUpdate(memberCuponVO);
				//쿠폰일 때는 금액 대신 쿠폰의 번호를 넣어 줌
				discountInfoVO.setDiscountPrice(couponNum);
			}
			
			//할인 금액 디비에 적용 + 할인 정보 테이블 추가 - 포인트
			for (String str : discountList) {
				String arr[]  = str.split("_");
				
				if(type == 2) {
					//할인금액 point에 적용(빼기)
					PointVO pointVO = new PointVO();
					pointVO.setUsername(reservationVO.getUid());
					pointVO.setType(arr[0]);
					pointVO.setPrice(Integer.parseInt(arr[1]));
						
					pointService.pointDiscountUpdate(pointVO);
					
					//포인트일때는 할인된 금액을 넣어줌
					discountInfoVO.setDiscountPrice(Integer.parseInt(arr[1]));
				}
				
				discountInfoVO.setReservationNum(result);
				discountInfoVO.setType(arr[0]);
				discountInfoService.discountInfoInsert(discountInfoVO);
			}
		}
		
		
		
		//좌석 번호 등록 : SeatBooking
		if(result > 0) {
			
			String [] selectedSeat = selectedSeatNums.split(",");
			
			for (String str : selectedSeat) {
				SeatBookingVO seatBookingVO = new SeatBookingVO();
				seatBookingVO.setReservationNum(reservationVO.getNum());
				seatBookingVO.setMovieTimeNum(reservationVO.getMovieTimeNum());
				seatBookingVO.setSeatNum(Integer.parseInt(str));
				
				seatCheck = seatBookingService.seatBookingInsert(seatBookingVO);
			}
			
			//상영관 잔여좌석 수 변경 - MovieTime
			if(seatCheck > 0) {
				
				MovieTimeVO movieTimeVO = new MovieTimeVO();
				movieTimeVO = movieTimeService.movieTimeSelectOne(reservationVO.getMovieTimeNum());
				int remainSeat = movieTimeVO.getRemainSeat() - (reservationVO.getCommon()+reservationVO.getTeenager()+reservationVO.getPreference());
				
				movieTimeVO.setRemainSeat(remainSeat);
				movieTimeVO.setNum(reservationVO.getMovieTimeNum());
				movieTimeService.remainSeatUpdate(movieTimeVO);
			}
		}
		
		
		return result;
	}
	
	
	
	
	
	
	//좌석예매 페이지 출력
	@PostMapping("/seatReservation")
	public ModelAndView seatReservation(ReservationVO reservationVO,int seatCount,String time,int cinemaNum,String timeType) throws Exception{
		ModelAndView mv = new ModelAndView();
		//System.out.println("선택한 시간 - "+time);
		//System.out.println("필름 타입 : "+reservationVO.getFilmType());
		
		MovieInfoVO movieInfoVO = movieInfoService.movieSelectOne(reservationVO.getMovieNum());
		MovieTimeVO movieTimeVO = movieTimeService.movieTimeSelectOne(reservationVO.getMovieTimeNum());
		
		//좌석 관련
		SeatVO seatVO = new SeatVO();
		seatVO.setTheaterNum(movieTimeVO.getTheaterNum());
		seatVO.setMovieTimeNum(reservationVO.getMovieTimeNum());
		
		List<SeatVO> rowList = seatService.rowCount(seatVO);
		int maxCol = seatService.colCount(seatVO);
		
		//seatSapce 
		SeatSpaceVO seatSpaceVO = new SeatSpaceVO();
		seatSpaceVO.setTheaterNum(movieTimeVO.getTheaterNum());
		List<SeatSpaceVO> seatSpaceList = seatSpaceService.seatSpaceSelect(seatSpaceVO);
		
		//좌석 리스트 - seat - seatBooking (Join)
		List<SeatVO> seatList = seatService.seatSelectList(seatVO);
		
		
		//시간대별 가격 조회 - String time
		TimePriceVO timePriceVO = new TimePriceVO();
		timePriceVO.setTime(time);
		timePriceVO.setCinemaNum(cinemaNum);
		timePriceVO.setFilmType(reservationVO.getFilmType());
		
		timePriceVO = timePriceService.timePriceSelect(timePriceVO);
		
		
		
		//영화 종료시간 생성
		int runningTime = Integer.parseInt(movieInfoVO.getRuntime()); 
		String startTime = movieTimeVO.getScreenTime();
		String endTime = timeAdd.timeAdd(startTime, runningTime);
		
		//조조.심야 or 일반인지 구분
		mv.addObject("timeType", timeType);
		
		mv.addObject("rowList", rowList);
		mv.addObject("maxCol", maxCol);
		
		mv.addObject("endTime", endTime);
		mv.addObject("seatCount", seatCount);
		
		mv.addObject("seatSpaceList", seatSpaceList);
		mv.addObject("movieVO", movieInfoVO);
		mv.addObject("movieTimeVO", movieTimeVO);
		mv.addObject("seatList", seatList);
		mv.addObject("reservationVO", reservationVO);
		mv.addObject("timePriceVO", timePriceVO);
		
		mv.setViewName("movie/movieSeat");
		return mv;
	}
	
	
	@PostMapping("reservePayment")
	public ModelAndView reservePayment() throws Exception{
		ModelAndView mv = new ModelAndView();

		mv.setViewName("movie/moviePayment");
		return mv;
	}
	
}









