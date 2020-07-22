package com.tm.cgv.guest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tm.cgv.reservation.ReservationService;
import com.tm.cgv.reservation.ReservationVO;
import com.tm.cgv.util.MakeSerialCode;
import com.tm.cgv.util.SmsSender;

@Controller
@RequestMapping("/guest/**")
public class GuestController {

	@Autowired
	private GuestService guestService;
	@Autowired
	private SmsSender smsSender;
	@Autowired
	private MakeSerialCode makeSerialCode;
	@Autowired
	private ReservationService reservationService;
	
	
	
	//검색된 비밀번호 출력페이지 이동
	@PostMapping("pwdFindResult")
	public ModelAndView pwdFindResult(String pwd) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("pwd", pwd);
		mv.setViewName("member/guest/memberGuestShowPwd");
		return mv;
	}
	
	
	
	//비회원 정보 비밀번호 찾기페이지로 이동
	@GetMapping("memberGuestPwd")
	public ModelAndView memberGuestPwd() throws Exception{
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("member/guest/memberGuestPwd");
		return mv;
	}
	
	//비밀번호 존재 여부 확인
	@ResponseBody
	@PostMapping("guestFindPwd")
	public int guestFindPwd(GuestVO guestVO) throws Exception{
		int result = 0;
		
		guestVO = guestService.guestFindPwd(guestVO);
		if(guestVO != null) {
			result = Integer.parseInt(guestVO.getPwd());
		}
		return result;
	}
	
	
	
	//비회원 등록 정보가 일치하는지 확인
	@ResponseBody
	@PostMapping("guestCheck")
	public int guestReservationcheck(GuestVO guestVO) throws Exception{
		System.out.println("INNNNNNNNNNNN><<>>>>>>>>>>>>>>>>>>");
		
		//생년월일, 전화번호, 비밀번호 일치 확인
		int result = 0;
		
		guestVO = guestService.guestReservationCheck(guestVO);
		if(guestVO != null) {
			result = guestVO.getReservationNum();
		}
		
		return result;
	}
	
	
	//비회원 예매 정보  조회
	@GetMapping("reservationSelect")
	public ModelAndView guestReservationSelect(int reservationNum) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		//예매번호로 예매 정보 조회 - reservationTable
		ReservationVO reservationVO = new ReservationVO();
		reservationVO = reservationService.reservationResultSelectOne(reservationNum);
		
		mv.addObject("reservationVO", reservationVO);
		
		mv.setViewName("member/guest/memberGuestList");
		return mv;
	}
	
	
	//비회원 예매 확인 페이지 이동
	@GetMapping("reservationInfo")
	public ModelAndView guestReservationInfo() throws Exception{
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("member/guest/memberGuestChk");
		return mv;
	}

	
	//sessionVO생성해서 임시 아이디로 예매 가능하게 해줌
	@PostMapping("guestSession")
	public ModelAndView guestSession(GuestVO guestVO,HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		if(guestVO != null) {
			//beMemberVO session생성 부여
			session.setAttribute("beMemberVO", guestVO);
		}
		mv.setViewName("redirect:../movie/movieReservation");
		return mv;
	}
	
	//에매 완료시 guest 테이블에 정보 저장
	@ResponseBody
	@PostMapping("guestInsert")
	public int guestInsert(GuestVO guestVO,HttpSession session) throws Exception{
		int result = 0;
		result = guestService.guestInsert(guestVO);
		
		session.removeAttribute("beMemberVO");
		
		return result;
	}
	
	
	
	
	//비회원 예매 인증 페이지로 이동
	@GetMapping("guestReservation")
	public ModelAndView guestReservation() throws Exception{
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("member/guest/memberGuestReserve");
		return mv;
	}
	
	//메일 인증번호 발송
	@ResponseBody
	@PostMapping("guestCertification")
	public int guestCertification(String phoneNumber) throws Exception{
		System.out.println("폰 넘버 : "+phoneNumber);
		int certifiNum = 0;

		//인증 번호 생성
		certifiNum = makeSerialCode.makeNumber();

		//인증 메일 전송
		phoneNumber = "01071679549";
		String contents = "[CGV]인증번호는 "+certifiNum+" 입니다";
		//smsSender.smsSend(phoneNumber, contents);
		
		return certifiNum;
	}
	
	
	
}
