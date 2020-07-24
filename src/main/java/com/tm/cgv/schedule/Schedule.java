package com.tm.cgv.schedule;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.tm.cgv.guest.GuestService;
import com.tm.cgv.point.PointService;
import com.tm.cgv.point.PointVO;
import com.tm.cgv.reservation.ReservationService;
import com.tm.cgv.reservation.ReservationVO;


import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.tm.cgv.couponInfo.CouponInfoRepository;
import com.tm.cgv.couponInfo.CouponInfoVO;
import com.tm.cgv.member.MemberBasicVO;
import com.tm.cgv.member.MemberRepository;
import com.tm.cgv.memberCoupon.MemberCouponRepository;
import com.tm.cgv.memberCoupon.MemberCouponVO;
import com.tm.cgv.movieTime.MovieTimeRepository;
import com.tm.cgv.movieTime.MovieTimeVO;
import com.tm.cgv.seatBooking.SeatBookingRepository;
import com.tm.cgv.seatBooking.SeatBookingVO;
import com.tm.cgv.util.GenerateRandomNumber;
import com.tm.cgv.util.Pager;

@Component
@Transactional
public class Schedule {

	// tm
	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	private PointService pointService;
	
	@Autowired
    RedisTemplate<String, Object> redisTemplate;
	
	@Autowired
	private GuestService guestService;

	// hr
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private CouponInfoRepository couponInfoRepository;
	
	@Autowired
	private MemberCouponRepository memberCouponRepository;
	
	@Autowired
	private MovieTimeRepository movieTimeRepository;
	
	@Autowired
	private SeatBookingRepository seatBookingRepository;
	
	private final String BIRTH_COUPON_NAME = "생일축하쿠폰_";
	private final int COUPON_EXFIRE_MONTH = 3;
	private final int MOVIETIME_EXFIRE_DATE = 1;
	private final String TEST_CRON = "0 * * * * *";

	//==============================
	// tm
	//==============================
	//	@Scheduled(cron ="50 * * * * *") - 예제
	public void cronSchedule() throws Exception{
		System.out.println(Thread.currentThread().getName());
		Calendar cal = Calendar.getInstance();
		System.out.println(cal.getTimeInMillis());
	}
	
	//자정에 이미 상영이 마친 예매에 해당하는 guest Table 컬럼 삭제
	@Scheduled(cron ="0 0 0 * * *")
	public void guestDeleteSchedule() throws Exception{
		//비회원으로 당일 기준 상영이 종료된 테이블 리스트 조회
		List<ReservationVO> guestReservationList = reservationService.guestReservationList();
		
		//조회한 값을 이용해서 guest Table값 삭제
		if(guestReservationList != null) {
			for (ReservationVO reservationVO : guestReservationList) {
				guestService.guestDelete(reservationVO.getNum());
			}
		}
	}
	
	//자정에 결제금액에 해당하는 일정 포인트 지급 - (resevationTable이용)
	@Scheduled(cron ="0 0 0 * * *")
//	@Scheduled(cron ="10 * * * * *")
	public void pointSchedule() throws Exception{
		Calendar cal = Calendar.getInstance();
		String year = cal.get(Calendar.YEAR)+"";
		String month = (cal.get(Calendar.MONTH)+1)+"";
		String date = cal.get(Calendar.DATE)+"";
		
		if(month.length() < 2) {
			month = "0"+month;
		}
		if(date.length() < 2) {
			date = "0"+date;
		}
		String nowDate = year+"-"+month+"-"+date;
		
		//지금 날짜와 DB의 날짜와 비교해서 오늘 결제 된 사람들의 ID를 얻어옴
		ReservationVO reservationVO = new ReservationVO();
		reservationVO.setCreateAt(nowDate);
		List<ReservationVO> reservationList = reservationService.pointAccumlate(reservationVO);
		
		//할인율 읽어와야됨 - redis
		Integer rate = (Integer)redisTemplate.opsForValue().get("cjDiscountRate");
		double changeRate = rate*0.01;
		
		int result = 0;
		for (ReservationVO vo : reservationList) {
			String uid = vo.getUid();
			int totalPrice = vo.getTotalPrice();
			int accumulatePoint = (int)(totalPrice * changeRate);
			
			PointVO pointVO = new PointVO();
			pointVO.setKind("sum");
			pointVO.setUsername(uid);
			pointVO.setType("cjOnePointipt");
			pointVO.setPrice(accumulatePoint);
			
			result = pointService.pointDiscountUpdate(pointVO);
			
			if(result == 0) {
				result = pointService.pointInsert(pointVO);
			}
		}	
	}

	//==============================
	// hr
	//==============================
	//@Scheduled(cron = TEST_CRON)
	//@Scheduled(cron = "0 0 4 * * *")
	public void schedule_4AM() throws Exception{
		
		// movieTime 관련
		List<Integer> movieTimeNumList = deleteExpiredMovieTime();
		
		// seatBooking 관련
		deleteExpiredSeatBooking(movieTimeNumList);
	}
	
	// 매 자정에 해줘야하는 기능들
	//@Scheduled(cron = TEST_CRON)
	//@Scheduled(cron = "0 0 0 * * *")
	public void schedule_0AM() throws Exception{
		
		// coupon 관련
		this.deleteExpiredCoupon();
		this.createBirthCoupon();
		this.issueBirthCoupon();
	}
	
	// movieTime 의 screenDate 지난거 찾아서 delete
	private List<Integer> deleteExpiredMovieTime() throws Exception{
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
		Calendar time = Calendar.getInstance();
		time.add(Calendar.DATE, -MOVIETIME_EXFIRE_DATE);
		String exfireDay = format.format(time.getTime());
		System.out.println(exfireDay);
		
		MovieTimeVO movieTimeVO = new MovieTimeVO();
		movieTimeVO.setScreenDate(exfireDay);
		
		//지워질 movieTime num List 가져오기
		List<Integer> list = movieTimeRepository.selectNumByScreenDate(movieTimeVO);
		movieTimeRepository.updateDeleteAtByScreenDate(movieTimeVO);
		
		return list;
	}
	
	// 지워진 movieTimeNum에 해당하는 예약좌석 테이블 삭제
	private void deleteExpiredSeatBooking(List<Integer> movieTimeNumList) throws Exception{
		
		SeatBookingVO seatBookingVO = new SeatBookingVO();
		for (Integer num : movieTimeNumList) {
			seatBookingVO.setMovieTimeNum(num);
			seatBookingRepository.deletesByMovieTimeNum(seatBookingVO);
		}
	}
	
	// 매 자정마다 기간만료된 생일 쿠폰 삭제 X 전체 쿠폰으로 기간만료 후 3개월
	private void deleteExpiredCoupon() throws Exception{
		
		SimpleDateFormat format = new SimpleDateFormat ("yyyy-MM-dd");
		Calendar time = Calendar.getInstance();
		time.add(Calendar.MONTH, -COUPON_EXFIRE_MONTH);
		String exfireDay = format.format(time.getTime());
		System.out.println(exfireDay);
		
		CouponInfoVO couponInfoVO = new CouponInfoVO();
		couponInfoVO.setEIssuance(exfireDay);
		
		int result = couponInfoRepository.couponInfoDeleteExpired(couponInfoVO);
		if(result > 0) {
			System.out.println(couponInfoVO.toString());
		}
	}
	
	// 매 자정마다 해당 생일자 쿠폰 생성
	private void createBirthCoupon() throws Exception{
		
		// 쿠폰 설정값
		String name = BIRTH_COUPON_NAME;
		String serialNum = new GenerateRandomNumber().excuteGenerate();	// 일련번호 생성을 위해 선언 
		int price = 2000;
		int type = 2;
		int count = 1;
		String sIssuance = null;
		String eIssuance = null;
		
		CouponInfoVO couponInfoVO = new CouponInfoVO();
		
		SimpleDateFormat format = new SimpleDateFormat ("MM-dd");
		Calendar time = Calendar.getInstance();
		String today = format.format(time.getTime());
		
		format = new SimpleDateFormat ("yyyy-MM-dd");
		sIssuance = format.format(time.getTime());
		time.add(Calendar.DATE, 14);
		eIssuance = format.format(time.getTime());
		
		couponInfoVO.setName(name+today);
		couponInfoVO.setSerialNum(serialNum);
		couponInfoVO.setPrice(price);
		couponInfoVO.setType(type);
		couponInfoVO.setCount(count);
		couponInfoVO.setSIssuance(sIssuance);
		couponInfoVO.setEIssuance(eIssuance);
		
		int result = couponInfoRepository.couponInfoInsert(couponInfoVO);
		if(result>0) {			
			System.out.println(couponInfoVO.toString());
		}
	}
	
	// 매 자정마다 생일인지 체크해서 생일자인 사람에게 쿠폰 발급
	private void issueBirthCoupon() throws Exception{
		
		// values
		String birthDay = null;
		Pager pager = new Pager();
		CouponInfoVO couponInfoVO = new CouponInfoVO();
		MemberCouponVO memberCouponVO = null;
		
		// 오늘 날짜 가져오기
		SimpleDateFormat format = new SimpleDateFormat ("MM-dd");
		Calendar time = Calendar.getInstance();
		String today = format.format(time.getTime());	        
		
		// 생일쿠폰 num 가져오기
		couponInfoVO.setName(BIRTH_COUPON_NAME);
		couponInfoVO = couponInfoRepository.couponInfoSelectRecentBirth(couponInfoVO);
		System.out.println(couponInfoVO.toString());
		
		// memberCouponVO 디폴트값 넣어주기
		memberCouponVO = MemberCouponVO.builder()
				.couponInfoNum(couponInfoVO.getNum())
				.build();
		
		// 회원리스트 가져와서 생일자 회원에게 쿠폰 발급
		pager.setPerPage(memberRepository.memberTotalCount().intValue());
		List<MemberBasicVO> memberList = memberRepository.memberList(pager);
		for (MemberBasicVO memberBasicVO : memberList) {
			birthDay = memberBasicVO.getBirth().substring(memberBasicVO.getBirth().indexOf("-")+1);
			if(birthDay.equals(today)) {
				
				memberCouponVO.setUid(memberBasicVO.getUsername());
				int result = memberCouponRepository.memberCouponInsert(memberCouponVO);
				if(result > 0)
					System.out.println(memberCouponVO.toString());
			}
		}
	}
}




	
	
	
	