package com.tm.cgv.admin;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.tm.cgv.banner.BannerService;
import com.tm.cgv.banner.BannerVO;
import com.tm.cgv.cinema.CinemaService;
import com.tm.cgv.cinema.CinemaVO;
import com.tm.cgv.couponInfo.CouponInfoService;
import com.tm.cgv.couponInfo.CouponInfoVO;
import com.tm.cgv.event.EventService;
import com.tm.cgv.event.EventVO;
import com.tm.cgv.eventImage.EventImageService;
import com.tm.cgv.member.MemberBasicVO;
import com.tm.cgv.member.MemberService;
import com.tm.cgv.movieImage.MovieImageVO;
import com.tm.cgv.movieInfo.MovieInfoService;
import com.tm.cgv.movieInfo.MovieInfoVO;
import com.tm.cgv.movieTime.MovieTimeService;
import com.tm.cgv.movieTime.MovieTimeVO;
import com.tm.cgv.payment.PaymentService;
import com.tm.cgv.payment.PaymentVO;
import com.tm.cgv.pointHistory.PointHistoryService;
import com.tm.cgv.pointHistory.PointHistoryVO;
import com.tm.cgv.reservation.ReservationService;
import com.tm.cgv.reservation.ReservationVO;
import com.tm.cgv.review.ReviewService;
import com.tm.cgv.review.ReviewVO;
import com.tm.cgv.seat.SeatService;
import com.tm.cgv.seat.SeatVO;
import com.tm.cgv.seatSpace.SeatSpaceService;
import com.tm.cgv.seatSpace.SeatSpaceVO;
import com.tm.cgv.theater.TheaterService;
import com.tm.cgv.theater.TheaterVO;
import com.tm.cgv.timePrice.TimePriceService;
import com.tm.cgv.timePrice.TimePriceVO;
import com.tm.cgv.util.BitFilmType;
import com.tm.cgv.util.MakeSerialCode;
import com.tm.cgv.util.Pager;
import com.tm.cgv.util.Pager_cinemaList;
import com.tm.cgv.util.Pager_eventList;


@Controller
@RequestMapping("/admin/**")
public class AdminController {

	@Autowired
	private CinemaService cinemaService;
	
	@Autowired
	private TheaterService theaterService;
	
	@Autowired
	private SeatService seatService;
	
	@Autowired
	private SeatSpaceService seatSpaceService;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MovieInfoService movieInfoService;
	
	@Autowired
	private MovieTimeService movieTimeService;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private TimePriceService timePriceService;
	@Autowired
	private CouponInfoService couponInfoService;
	@Autowired
	private PointHistoryService pointHistoryService;
	@Autowired
    RedisTemplate<String, Object> redisTemplate;
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private EventService eventService;
	
	@Autowired
	private EventImageService eventImageService;
	
	@Autowired
	private BannerService bannerService;
	
	
	@GetMapping("/")
	public String admin() throws Exception {
		return "admin/adminIndex";
	}
	
	//==============================
	// movieInfo
	//==============================
	

	@GetMapping("movie/movieList")
	public ModelAndView movieList(ModelAndView mv,Pager pager) throws Exception{
		
		if(pager.getKind()==null || pager.getKind().equals("")) {
			pager.setKind("date"); //최신순으로 설정
		}
		
		List<MovieInfoVO> list = movieInfoService.movieList(pager);
		
		System.out.println(pager.getKind()+"getKind");
		

		if(list !=null) {
			mv.addObject("list",list);
			mv.addObject("pager",pager);
			mv.setViewName("admin/movie/movieList");
		}
		return mv;
	}
	
	@GetMapping("movie/movieListSort")
	public ModelAndView movieListSort(ModelAndView mv,MovieInfoVO movieInfoVO) throws Exception{
		List<MovieInfoVO> list = movieInfoService.movieListAll(movieInfoVO);
		
		System.out.println(list.get(1).getTitle()+"정렬 0번 타이틀");
		
		mv.addObject("list",list);
		mv.setViewName("admin/movie/ajax/movieListSort");
		return mv;
	}
	
	

	@GetMapping("movie/movieSearchA")
	public ModelAndView movieSearchA(ModelAndView mv,Pager pager,String search) throws Exception{
		
		List<MovieInfoVO> searchA = movieInfoService.movieList(pager);
		System.out.println(pager.getSearch()+"search++++");
		System.out.println(search+"이거요거저거");
		
		if(searchA !=null) {
			mv.addObject("searchA",searchA);
			mv.setViewName("admin/movie/movieSearchA");
		}
		return mv;
	}
	
	@GetMapping("movie/movieWrite")
	public ModelAndView movieWrite(ModelAndView mv)throws Exception{

		mv.addObject("vo",new MovieInfoVO());
		mv.addObject("path","Write");
		mv.setViewName("admin/movie/movieWrite");
		return mv;
	}
	
	@PostMapping("movie/movieWrite")
	public ModelAndView movieWrite(ModelAndView mv,MovieInfoVO movieInfoVO,List<MultipartFile> files,String[] videolink,int trailerCount,int steelCutCount) throws Exception{
		int num = movieInfoVO.getNum();
		System.out.println("num : " + num);
		
		long result = movieInfoService.movieWrite(movieInfoVO, files,videolink,trailerCount,steelCutCount);
		if(result>0) {
			mv.setViewName("redirect:./movieList?kind=date");
		}else {
			System.out.println("등록 실패");
		}
		
		return mv;
	}
	//영화 제목 중복 체크
	@GetMapping("movie/titleCheck")
	@ResponseBody
	public int titleCheck(MovieInfoVO movieInfoVO) throws Exception{
		movieInfoVO = movieInfoService.titleCheck(movieInfoVO);
		
		int result=0;
		if(movieInfoVO != null) {
			
			result=1;
		}
		return result;
	}
	//영문 제목 중복 체크
	@GetMapping("movie/titleEngCheck")
	@ResponseBody
	public int titleEngCheck(MovieInfoVO movieInfoVO) throws Exception{
		movieInfoVO = movieInfoService.titleEngCheck(movieInfoVO);
		
		int result=0;
		if(movieInfoVO != null) {
			
			result=1;
		}
		return result;
	}
	
	
	@GetMapping("movie/movieSelect")
	public ModelAndView movieSelect(ModelAndView mv,ReservationVO reservationVO,MovieInfoVO movieInfoVO,MovieImageVO movieImageVO,int num) throws Exception{
		System.out.println(movieInfoVO.getNum()+"con 무비넘");
		reservationVO.setMovieNum(movieInfoVO.getNum());// 파라미터가 num인데 reservation에는 movieNum이 영화번호이니까
														// 영화번호에 num을 넣어줘야지 제대로 돌아감
		movieImageVO.setMovieNum(num);
		System.out.println(movieImageVO.getMovieNum()+"con num2");
		Map<String, Object> map = movieInfoService.movieSelect(movieInfoVO, reservationVO,movieImageVO);
		if(map.get("vo")==null) {
			mv.setViewName("redirect:../error/404");
		}
		System.out.println(map.get("tco")+"tco 출력");
						
		mv.addObject("vo",map.get("vo"));//정보+사진
		mv.addObject("ar",map.get("ar"));//사진+영상링크
		
		mv.addObject("tco",map.get("tco"));
		mv.addObject("gender",map.get("gender"));
		mv.addObject("gTotal",map.get("gTotal"));
		mv.addObject("ageTotal",map.get("ageTotal"));
		mv.addObject("age10",map.get("age10"));
		mv.addObject("age20",map.get("age20"));
		mv.addObject("age30",map.get("age30"));
		mv.addObject("age40",map.get("age40"));
		mv.addObject("age50",map.get("age50"));
		mv.addObject("path","Select");
		mv.addObject("cost",map.get("cost"));
		mv.addObject("cactor",map.get("cactor"));
		mv.addObject("cvisual",map.get("cvisual"));
		mv.addObject("cstory",map.get("cstory"));
		mv.addObject("cdirector",map.get("cdirector"));
		mv.addObject("cten",map.get("cten"));
		mv.addObject("cfun",map.get("cfun"));
		mv.addObject("cstr",map.get("cstr"));
		mv.addObject("cimp",map.get("cimp"));
		mv.addObject("cimm",map.get("cimm"));
		mv.setViewName("admin/movie/movieSelect");
		return mv;
	}
	
	@GetMapping("movie/movieUpdate")
	public ModelAndView movieUpdate(ModelAndView mv,MovieInfoVO movieInfoVO,ReservationVO reservationVO,MovieImageVO movieImageVO,int num) throws Exception{
		reservationVO.setMovieNum(movieInfoVO.getNum());
		movieImageVO.setMovieNum(num);
		
		Map<String, Object> map = movieInfoService.movieSelect(movieInfoVO, reservationVO,movieImageVO);
		
		if(map.get("vo")==null) {
			mv.setViewName("redirect:./error/404");
		}
		
		MovieInfoVO tmp = (MovieInfoVO)map.get("vo");//.movieImageVOs[0].num
		System.out.println("라라라라라 : "+tmp.getMovieImageVOs().get(0).getNum());
		mv.addObject("vo",map.get("vo"));
		mv.addObject("ar",map.get("ar"));
		mv.addObject("tco",map.get("tco"));
		mv.addObject("sco",map.get("sco"));
		mv.addObject("path","Update");
		mv.setViewName("admin/movie/movieUpdate");
		
		return mv;
	}
	
	@PostMapping("movie/movieUpdate")
	public ModelAndView movieUpdate(ModelAndView mv,MovieInfoVO movieInfoVO,List<MultipartFile> files,String[] videolink,int trailerCount,int steelCutCount,String[] delNum) throws Exception{
		long result = movieInfoService.movieUpdate(movieInfoVO, files, videolink,trailerCount,steelCutCount,delNum);
		
		mv.setViewName("redirect:./movieSelect?num="+movieInfoVO.getNum());
		return mv;
	}
	
	@GetMapping("movie/movieDelete")
	public ModelAndView movieDelete(ModelAndView mv, MovieInfoVO movieInfoVO) throws Exception{
		System.out.println(movieInfoVO.getNum()+"delete");
		long result = movieInfoService.movieDelete(movieInfoVO);
		System.out.println(movieInfoVO.getNum()+"delete2");
		mv.setViewName("redirect:./movieList?kind=date");
		return mv;
	}
	
	//==============================
	// cinemaPart
	//==============================
	@GetMapping("cinema/cinemaList")
	public ModelAndView adminCinemaList(ModelAndView mv, Pager_cinemaList pager) throws Exception {
		List<CinemaVO> list = cinemaService.adminCinemaList(pager);
		mv.addObject("list", list);
		mv.addObject("pager", pager);
		mv.setViewName("admin/cinema/cinemaList");
		return mv;
	}
	
	@PostMapping("cinema/cinemaList")
	@ResponseBody
	public ModelAndView adminCinemaList(ModelAndView mv, String local, Pager_cinemaList pager) throws Exception {
		pager.setlocal(local);
		List<CinemaVO> list = cinemaService.adminCinemaList(pager);
		mv.addObject("pager", pager);
		mv.addObject("list", list);
		mv.setViewName("admin/cinema/ajax/cineList");
		return mv;
		
	}
	
	@GetMapping("cinema/cinemaSelect")
	public ModelAndView adminCinemaSelect(ModelAndView mv, int num) throws Exception {
		CinemaVO cinemaVO = new CinemaVO();
		cinemaVO.setNum(num);
		cinemaVO = cinemaService.cinemaSelect(cinemaVO);
		List<TheaterVO> list = cinemaService.selectTheaterList(num);
	
		//가져온 theater list에 들어있는 filmType을 가져와서 리스트 생성
		List<Integer> values = new ArrayList<Integer>();
		for(TheaterVO i:list) {
			values.add(i.getFilmType());
		}
		
		//비트 플래그 이용하여 한자리수인 filmType을 쪼개어 list나 배열 형태로 가져와 jsp로 보내주기
		BitFilmType bitFilmType = new BitFilmType();
		List<List<Byte>> filmType = bitFilmType.getState(values);
		
		//timePrice에 해당 cinema가 등록 되어있는지 조회
		List<TimePriceVO> timePriceList = timePriceService.timePriceCinemaList(num);
		
		mv.addObject("timePriceList", timePriceList);
		mv.addObject("cinemaNum", num);
		mv.addObject("filmType", filmType);
		mv.addObject("cine", cinemaVO);
		mv.addObject("theaterList", list);
		mv.setViewName("admin/cinema/cinemaSelect");
		
		
		return mv;
	}
	
	@GetMapping("cinema/theaterTime")
	@ResponseBody
	public List<String[]> theaterTime(int theaterNum, String checkDate) throws Exception {
		ModelAndView mv = new ModelAndView();
		String [] day = theaterService.searchTime(checkDate);

		Map<String, Object> d = new HashMap();
		d.put("startDay", day[0]);
		d.put("lastDay", day[1]);
		d.put("theaterNum", theaterNum);
		
		
		
		List<MovieTimeVO> m = theaterService.theaterMovieTime(d);
		
		//쪼개는 서비스 만들기..theaterService에
		List<String[]> totalInfo = theaterService.movieTime(m);

		mv.addObject("totalInfo", totalInfo);
		mv.setViewName("admin/cinema/ajax/theaterTime");

		return totalInfo;
	}
	
	@GetMapping("cinema/searchTime")
	@ResponseBody
	public void searchTime(String checkDate) throws Exception {
		String [] day = theaterService.searchTime(checkDate);

		Map<String, String> d = new HashMap();
		d.put("startDay", day[0]);
		d.put("lastDay", day[1]);
		
		System.out.println("mon : " + day[0]);
		System.out.println("sun : " + day[1]);
	}
	
	
	@GetMapping("cinema/cinemaInsert")
	public ModelAndView admincinemaInsert() throws Exception {
		ModelAndView mv = new ModelAndView();
		CinemaVO cinemaVO = new CinemaVO();
		cinemaVO.setTotalSeat(0);
		cinemaVO.setTotalTheater(0);
		mv.addObject("vo", cinemaVO);
		mv.addObject("path", "Insert");
		mv.setViewName("admin/cinema/cinemaInsert");
		return mv;
	}
	
	@PostMapping("cinema/cinemaInsert")
	public ModelAndView cinemaInsert(ModelAndView mv, CinemaVO cinemaVO) throws Exception{
		System.out.println("입력한 totalseat : " + cinemaVO.getTotalSeat());
		System.out.println("ㅠ.ㅠ");
		int result = cinemaService.cinemaInsert(cinemaVO);
		
		if(result > 0) {
			mv.setViewName("redirect:./cinemaList");
		}else {
			System.out.println("삽입 실패");
		}
		
		return mv;
	}
	
	@GetMapping("cinema/cinemaNameCheck")
	@ResponseBody
	public int cinemaNameCheck(String name) throws Exception 	{
		System.out.println("입력한 name : " + name);
		int result = 0;
		CinemaVO cinemaVO = cinemaService.cinemaNameCheck(name);
		if(cinemaVO != null) {
			result = 1;
		}
		return result;
	}
	
	@GetMapping("cinema/cinemaUpdate")
	public ModelAndView adminCinemaUpdate(int num) throws Exception {
		ModelAndView mv = new ModelAndView();
		CinemaVO cinemaVO = new CinemaVO();
		cinemaVO.setNum(num);
		cinemaVO = cinemaService.cinemaSelect(cinemaVO);
		mv.addObject("path", "Update");
		mv.addObject("vo", cinemaVO);
		mv.setViewName("admin/cinema/cinemaInsert");

		return mv;
	}
	
	
	@PostMapping("cinema/cinemaUpdate")
	public ModelAndView cinemaUpdate(ModelAndView mv, CinemaVO cinemaVO) throws Exception{
		int result = cinemaService.cinemaUpdate(cinemaVO);
		if(result > 0) {
			mv.setViewName("redirect:./cinemaList");
		}else {
			System.out.println("삽입 실패");
		}
		
		return mv;
	}
	
	
	
	@GetMapping("cinema/cinemaDelete")
	public ModelAndView adminCinemaDelete(int num) throws Exception {
		ModelAndView mv = new ModelAndView();
		int result = cinemaService.cinemaDelete(num);
		
		mv.setViewName("redirect:./cinemaList");

		return mv;
	}
	
	
	
	
	//극장별 관람가격 (조회/수정/삭제 /삽입)
	
	@GetMapping("cinema/admissionPrice/deleteFilm")
	public ModelAndView admissionDeleteFilm(TimePriceVO timePriceVO) throws Exception{
		ModelAndView mv = new ModelAndView();

		int result = timePriceService.timePriceDeleteFilm(timePriceVO);
		
		mv.setViewName("redirect:../../cinemaSelect?num="+timePriceVO.getCinemaNum());
		
		return mv;
	}
	
	
	@ResponseBody
	@GetMapping("cinema/admissionPrice/deleteSelect")
	public int admissionDeleteSelect(int num) throws Exception{
		int result = 0;
		result = timePriceService.timePriceDeleteSelect(num);
		
		return result;
	}
	
	
	@GetMapping("cinema/admissionPrice/update")
	public ModelAndView admissionUpdate(TimePriceVO timePriceVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		//cinemaNum으로 cinema정보 조회(cinemaTable)
		CinemaVO cinemaVO = new CinemaVO();
		cinemaVO.setNum(timePriceVO.getCinemaNum());
		cinemaVO = cinemaService.cinemaSelect(cinemaVO);
		
		//cinemaNum filmType으로 정보 조회(timePriceTable)
		List<TimePriceVO> timePriceList = timePriceService.timePriceFilmTypeList(timePriceVO);
		
		mv.addObject("cinemaVO", cinemaVO);
		mv.addObject("timePriceList", timePriceList);
		mv.addObject("timePrice", "update");
		
		mv.setViewName("admin/timePrice/cinemaPrice");
		return mv;
	}
	
	@PostMapping("cinema/admissionPrice/update")
	public ModelAndView admissionUpdate2(String[] eTime,String[] commonPrice,String[] teenagerPrice,String[] num,String cinemaNum) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		//배열로 받아와서 for문 돌려서 일일이 업데이트
		for (int i = 0; i < eTime.length; i++) {
			TimePriceVO timePriceVO = new TimePriceVO();
			
			timePriceVO.setNum(Integer.parseInt(num[i]));
			String[] time = eTime[i].split(":");
			int chTime = Integer.parseInt(time[0]);
			if(chTime < 6) {
				chTime+=24;
			}
			timePriceVO.setETime(chTime+":"+time[1]);
			timePriceVO.setCommonPrice(Integer.parseInt(commonPrice[i]));
			timePriceVO.setTeenagerPrice(Integer.parseInt(teenagerPrice[i]));

			//업데이트 실행
			
			timePriceService.timePriceUpdate(timePriceVO);
		}
		
		mv.setViewName("redirect:./selectList?num="+cinemaNum);
		
		return mv;
	}
	
	
	@GetMapping("cinema/admissionPrice/selectList")
	public ModelAndView admissionPriceSelectList(CinemaVO cinemaVO) throws Exception{
		ModelAndView mv = new ModelAndView();

		//극장의 name, local
		cinemaVO = cinemaService.cinemaSelect(cinemaVO);
		
		//timePrice List
		List<TimePriceVO> timePriceList = timePriceService.timePriceCinemaList(cinemaVO.getNum());
		
		mv.addObject("cinemaVO", cinemaVO);
		mv.addObject("timePriceList", timePriceList);
		mv.setViewName("admin/timePrice/timePriceList");
		return mv;
	}
	
	
	
	
	@GetMapping("cinema/admissionPrice/write")
	public ModelAndView admissionPriceWrite(CinemaVO cinemaVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		cinemaVO = cinemaService.cinemaSelect(cinemaVO);
		
		//timePriceList-filmType group 조회
		List<TimePriceVO> filmTypeGroup = timePriceService.timePriceCinemaGroupList(cinemaVO.getNum());
		if(filmTypeGroup != null) {
			mv.addObject("filmTypeGroup", filmTypeGroup);
		}
		
		mv.addObject("cinemaVO", cinemaVO);
		mv.addObject("timePrice", "write");
		mv.setViewName("admin/timePrice/cinemaPrice");
		return mv;
	}
	
	@PostMapping("cinema/admissionPrice/write")
	public ModelAndView admissionPriceWrite(String[] eTime,String[] commonPrice,String[] teenagerPrice,String cinemaNum,String filmType) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		for (int i = 0; i < eTime.length; i++) {
			TimePriceVO timePriceVO = new TimePriceVO();
			timePriceVO.setCinemaNum(Integer.parseInt(cinemaNum));
			timePriceVO.setFilmType(Integer.parseInt(filmType));
			
			String[] time = eTime[i].split(":");
			System.out.println("time : "+time[0]);
			int chTime = Integer.parseInt(time[0]);
			if(chTime < 6) {
				chTime+=24;
			}
			System.out.println("chTime : "+chTime);
			timePriceVO.setETime(chTime+":"+time[1]);
			timePriceVO.setCommonPrice(Integer.parseInt(commonPrice[i]));
			timePriceVO.setTeenagerPrice(Integer.parseInt(teenagerPrice[i]));

			timePriceService.timePriceInsert(timePriceVO);
		}
		
		mv.setViewName("redirect:../cinemaSelect?num="+Integer.parseInt(cinemaNum));
		
		return mv;
	}
	
	
	
	
	
	
	//==============================
	// theater
	//==============================
	@GetMapping("cinema/theaterInsert")
	public ModelAndView adminTheaterInsert(int cinemaNum) throws Exception {
		ModelAndView mv = new ModelAndView();
		if(cinemaNum>0) {
			CinemaVO vo = new CinemaVO();
			vo.setNum(cinemaNum);
			vo = cinemaService.cinemaSelect(vo);
			mv.addObject("cineCheck", vo);
			System.out.println(vo);
		}
		List<CinemaVO> cinemaVO = theaterService.cinemaList();
		
		mv.addObject("cine", cinemaVO);
		mv.addObject("board", "theater");
		mv.addObject("path", "Insert");
		mv.setViewName("admin/cinema/theaterInsert");
		return mv;
	}
	
	
	
	@PostMapping("cinema/theaterInsert")
	public ModelAndView theaterInsert(TheaterVO theaterVO, int [] filmType, String [] row, String [] col, String [] grade, String [] row_space, String [] col_space, int cinemaNum) throws Exception{	
		ModelAndView mv = new ModelAndView();
		
		System.out.println("row : "+row);
		for (String str : row) {
			System.out.print(str+ "/ ");
		}
		System.out.println("col : "+col);
		for (String str : col) {
			System.out.print(str+ "/ ");
		}
		System.out.println("grade : "+grade);
		for (String str : grade) {
			System.out.print(str+ "/ ");
		}
		
		int result = theaterService.theaterInsert(theaterVO, filmType, row, col, grade, row_space, col_space);
		
		if(result>0) {
			mv.setViewName("redirect:./cinemaSelect?num="+cinemaNum);
		}else {
			System.out.println("등록 실패");
		}
		
		return mv;
	}
	
	@GetMapping("cinema/theaterNameCheck")
	@ResponseBody
	public int theaterNameCheck(TheaterVO theaterVO) throws Exception 	{
		System.out.println("cinemaNum : " + theaterVO.getCinemaNum());
		System.out.println("name : " + theaterVO.getName());
		int result = 0;
		TheaterVO vo = theaterService.theaterNameCheck(theaterVO);
		if(vo != null) {
			result = 1;
		}
		return result;
	}
	
	@GetMapping("cinema/theaterSelect")
	public ModelAndView adminTheaterSelect(int num, int cinemaNum) throws Exception {
		System.out.println("num : " +num);
		ModelAndView mv = new ModelAndView();
		TheaterVO theaterVO = theaterService.theaterSelect(num);
		CinemaVO cinemaVO = new CinemaVO();
		cinemaVO.setNum(cinemaNum);
		cinemaVO = cinemaService.cinemaSelect(cinemaVO);
		
		//theaterSelect
		//상영관 정보
		//좌석배치도
		
		SeatVO seatVO = new SeatVO();
		seatVO.setTheaterNum(num);
		SeatSpaceVO seatSpaceVO = new SeatSpaceVO();
		seatSpaceVO.setTheaterNum(num);
		System.out.println("tn : " + seatVO.getTheaterNum());
		
		List<SeatVO> rowList = seatService.rowCount(seatVO);
		int maxCol = seatService.colCount(seatVO);
		
		List<SeatSpaceVO> seatSpaceList = seatSpaceService.seatSpaceSelect(seatSpaceVO);
		
		List<SeatVO> seatList = seatService.seatSelect(seatVO);
		
		//복사해온것
		List<TheaterVO> list = new ArrayList<TheaterVO>();
		list.add(theaterVO);
		
		//가져온 theater list에 들어있는 filmType을 가져와서 리스트 생성
		List<Integer> values = new ArrayList<Integer>();
		for(TheaterVO i:list) {
			values.add(i.getFilmType());
		}
		
		//비트 플래그 이용하여 한자리수인 filmType을 쪼개어 list나 배열 형태로 가져와 jsp로 보내주기
		BitFilmType bitFilmType = new BitFilmType();
		List<List<Byte>> filmType = bitFilmType.getState(values);
		
		//중단된 좌석 목록..ㅎㅎ
		//theaterNum을 받아서 
		List<SeatVO> stopSeat = seatService.selectStopSeat(num);
		System.out.println("test : " + stopSeat.size());
		
		mv.addObject("stopSeat", stopSeat);
		mv.addObject("filmType", filmType);
		mv.addObject("rowList", rowList);
		mv.addObject("maxCol", maxCol);
		mv.addObject("seatSpaceList", seatSpaceList);
		mv.addObject("seatList", seatList);
		mv.addObject("theater", theaterVO);
		mv.addObject("cine", cinemaVO);
		mv.setViewName("admin/cinema/theaterSelect");
		return mv;
	}
	
	@GetMapping("cinema/theaterUpdate")
	public ModelAndView adminTheaterUpdate(int num, int cinemaNum) throws Exception {
		ModelAndView mv = new ModelAndView();
		TheaterVO theaterVO = theaterService.theaterSelect(num);
		SeatVO seatVO = new SeatVO();
		seatVO.setTheaterNum(num);
		SeatSpaceVO seatSpaceVO = new SeatSpaceVO();
		seatSpaceVO.setTheaterNum(num);

		List<SeatVO> rowList = seatService.rowCount(seatVO);
		int maxCol = seatService.colCount(seatVO);
		List<SeatSpaceVO> seatSpaceList = seatSpaceService.seatSpaceSelect(seatSpaceVO);
		List<SeatVO> seatList = seatService.seatSelect(seatVO);
		int seatListSize = seatList.size();
		
		String row = theaterService.selectRow(num); //int값으로
		char c = row.charAt(0);
		int k = c-64;
		int col = theaterService.selectCol(num);
		CinemaVO cinemaVO = new CinemaVO();
		cinemaVO.setNum(cinemaNum);
		cinemaVO = cinemaService.cinemaSelect(cinemaVO);
		
		
		
		
		List<TheaterVO> list = new ArrayList<TheaterVO>();
		list.add(theaterVO);
		
		//가져온 theater list에 들어있는 filmType을 가져와서 리스트 생성
		List<Integer> values = new ArrayList<Integer>();
		for(TheaterVO i:list) {
			values.add(i.getFilmType());
		}
		
		//비트 플래그 이용하여 한자리수인 filmType을 쪼개어 list나 배열 형태로 가져와 jsp로 보내주기
		BitFilmType bitFilmType = new BitFilmType();
		List<List<Byte>> filmType = bitFilmType.getState(values);
		
		
		
		//중단된 좌석 목록..ㅎㅎ
		//theaterNum을 받아서 
		List<SeatVO> stopSeat = seatService.selectStopSeat(num);
		System.out.println("test : " + stopSeat.size());
		
		mv.addObject("stopSeat", stopSeat);
		mv.addObject("filmType", filmType);
		mv.addObject("cine", cinemaVO);
		mv.addObject("rowList", rowList);
		mv.addObject("maxCol", maxCol);
		mv.addObject("seatSpaceList", seatSpaceList);
		mv.addObject("seatList", seatList);
		mv.addObject("theater", theaterVO); //상영과정보
		mv.addObject("rowIdx", k);
		mv.addObject("colIdx",col);
		mv.addObject("seatListSize", seatListSize);
		mv.addObject("board", "theater");
		mv.addObject("path", "Update");
		mv.setViewName("admin/cinema/theaterUpdate");
		return mv;
	}
	
	@PostMapping("cinema/theaterUpdate")
	public ModelAndView adminTheaterUpdate(TheaterVO theaterVO, int [] filmType, String [] row, String [] col, String [] grade, String [] row_space, String [] col_space, String [] stop_rc, String [] stop_idx, int cinemaNum) throws Exception {
		ModelAndView mv = new ModelAndView();
		theaterService.theaterUpdate(theaterVO, filmType, row, col, grade, row_space, col_space, stop_rc, stop_idx);
		
		mv.setViewName("redirect:./theaterSelect?num="+theaterVO.getNum()+"&cinemaNum="+cinemaNum);
		return mv;
	}
	

	@GetMapping("cinema/theaterDelete")
	public ModelAndView adminTheaterDelete(int num, int cinemaNum) throws Exception {
		ModelAndView mv = new ModelAndView();
		int result = theaterService.theaterDelete(num);
		
		mv.setViewName("redirect:./cinemaSelect?num="+cinemaNum);

		return mv;
	}
	
	//==============================
	// memberPart
	//==============================

	@GetMapping("member/memberList")
	public ModelAndView memberList(Pager pager) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		System.out.println("memberList");
		System.out.println(pager.getCurPage());
		System.out.println(pager.getKind());
		System.out.println(pager.getSearch());
		
		List<MemberBasicVO> list = memberService.memberList(pager);
		mv.addObject("list", list);
		mv.addObject("pager", pager);
		mv.setViewName("admin/member/memberList");
		return mv;
	}
	
	//==============================
	// movieTime part
	//==============================
	
	@GetMapping("movieTime/insert")
	public ModelAndView movieTimeInsert(Pager pager, TheaterVO theaterVO) throws Exception {
		
		ModelAndView mv = new ModelAndView();
		
		System.out.println("movieTimeInsert");
		System.out.println("theaterNum : "+theaterVO.getNum());
		
		pager.setPerPage(12);		// 12개씩 영화 보여주기 위함
		mv.addObject("perRow", 6);	// 6개마다 줄바꿈을 위함

		List<MovieInfoVO> movieInfoList = movieInfoService.forMovieTimeInsertList(pager);
		for (MovieInfoVO movieInfoVO : movieInfoList) {
			
			System.out.println("fileName : "+movieInfoVO.getFileName());
		}
		theaterVO = theaterService.theaterSelect(theaterVO.getNum());
		
		mv.addObject("movieInfoList", movieInfoList);
		mv.addObject("theaterVO", theaterVO);
		mv.setViewName("admin/movieTime/movieTimeInsert");
		return mv;
	}
	
	@PostMapping("movieTime/insert")
	@ResponseBody
	public int movieTimeInsert(MovieTimeVO movieTimeVO) throws Exception {
		
		System.out.println(movieTimeVO.getMovieNum());
		System.out.println(movieTimeVO.getTheaterNum());
		System.out.println(movieTimeVO.getScreenDate());
		System.out.println(movieTimeVO.getScreenTime());
		System.out.println(movieTimeVO.getRemainSeat());
		
		int result = movieTimeService.insert(movieTimeVO);
		return result;
	}
	
	

	//==============================
	// reservation 
	//==============================
	//예매내역 (조회/삭제)
	@GetMapping("reservation/selectList")
	public ModelAndView reservationSelectList(Pager pager) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		List<ReservationVO> reservationList = reservationService.reservationSelectList(pager);
		
		mv.addObject("reservationList", reservationList);
		mv.setViewName("admin/reservation/reservationList");
		
		return mv;
	}
	
//	@ResponseBody
//	@GetMapping("reservation/delete")
//	public int reservationDelete(ReservationVO reservationVO) throws Exception{
//		int result = 0;
//		result = reservationService.reservationDelete(reservationVO);
//		
//		return result;
//	}
	
	
	
	//==============================
	// payment  
	//==============================
	//결제내역 (조회)
	@ResponseBody
	@GetMapping("payment/SelectOne")
	public PaymentVO paymentSelectOne(PaymentVO paymentVO) throws Exception{
		paymentVO = paymentService.paymentSelectOne(paymentVO);

		return paymentVO; 
	}
	
	
	
	
	
	//==============================
	// coupon
	//==============================
	//쿠폰 정보 (조회/삭제/수정/삽입)
	
	@ResponseBody
	@GetMapping("admin/coupon/makeSerial")
	public ArrayList<String> makeSerial(String type) throws Exception{
		int typed = Integer.parseInt(type);
		MakeSerialCode serialCode = new MakeSerialCode();
		ArrayList<String> list = new ArrayList<String>(); 
		
		if(typed == 1) {
			//시리얼16+비번6
			String serial = serialCode.makeSerial(16);
			String pwd = serialCode.makeNumber()+"";
			list.add(serial);
			list.add(pwd);
		}else if(typed == 2) {
			//시리얼6
			String pwd = serialCode.makeNumber()+"";
			list.add(pwd);
		}
		
		return list;
	}
	
	@GetMapping("admin/coupon/couponDelete")
	public ModelAndView couponDelete(CouponInfoVO couponInfoVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		int result = couponInfoService.couponInfoDelete(couponInfoVO);
		if(result>0) {
			
		}else {
			System.out.println("삭제 실패");
		}
		
		mv.setViewName("redirect:./couponList");
		
		return mv;
	}
	
	@GetMapping("admin/coupon/couponUpdate")
	public ModelAndView couponUpdate(CouponInfoVO couponInfoVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		couponInfoVO = couponInfoService.couponInfoSelect(couponInfoVO);
		
		mv.addObject("couponInfoVO", couponInfoVO);
		mv.addObject("path", "couponUpdate");
		mv.setViewName("admin/coupon/couponForm");
		
		return mv;
	}
	
	@PostMapping("admin/coupon/couponUpdate")
	public ModelAndView couponUpdate2(CouponInfoVO couponInfoVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		int result = couponInfoService.couponInfoUpdate(couponInfoVO);
		if(result>0) {
			
		}else {
			System.out.println("수정 실패");
		}
		mv.setViewName("redirect:./couponList");

		return mv;
	}
	
	
	

	@PostMapping("admin/coupon/couponInsert")
	public ModelAndView couponInsert(CouponInfoVO couponInfoVO) throws Exception{
		ModelAndView mv = new ModelAndView();
		System.out.println("쿠폰 삽입 post");
		
		int result = couponInfoService.couponInfoInsert(couponInfoVO);
		if(result > 0) {
			
		}else {
			System.out.println("등록 실패");
		}
		
		mv.setViewName("redirect:./couponList");
		return mv;
	}
	
	@GetMapping("admin/coupon/couponInsert")
	public ModelAndView couponInsert() throws Exception{
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("path", "couponInsert");
		mv.setViewName("admin/coupon/couponForm");
		return mv;
	}
	
	
	@GetMapping("admin/coupon/couponList")
	public ModelAndView couponList(Pager pager) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		System.out.println("sDate : "+pager.getStartDate());
		
		List<CouponInfoVO> couponList = couponInfoService.couponInfoList(pager);
		
		mv.addObject("pager", pager);
		mv.addObject("couponList", couponList);
		mv.setViewName("admin/coupon/couponList");
		return mv;
	}

	
	
	//==============================
	// point
	//==============================
	//포인트 사용 내역 정보 (조회)
	
	@GetMapping("admin/point/pointHistoryList")
	public ModelAndView pointUsedList(Pager pager) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		//포인트 사용 내역 조회
		List<PointHistoryVO> pointHistoryList = pointHistoryService.pointHistoryList(pager);
		
		mv.addObject("pager", pager);
		mv.addObject("pointHistoryList", pointHistoryList);
		mv.setViewName("admin/point/pointList");

	

		
		return mv;
	}
	

	//포인트 적립 금액 변경 (redies사용)
	@GetMapping("admin/point/accumulateManagement")
	public ModelAndView pointAccumulateManagement() throws Exception{
		ModelAndView mv = new ModelAndView();

		Integer rate = (Integer)redisTemplate.opsForValue().get("cjDiscountRate");
		System.out.println(rate);
		
		if(rate == null) {
			redisTemplate.opsForValue().set("cjDiscountRate", 0);
			rate = 0;
		}

		mv.addObject("rate",rate);
		mv.setViewName("admin/point/pointForm");
		return mv;
	}

	@ResponseBody
	@PostMapping("admin/point/accumulateManagement")
	public int pointAccumulateManagement(int rate) throws Exception{
		int result = 0;
		redisTemplate.opsForValue().set("cjDiscountRate", rate);
		
		//변경 유무 확인
		Integer changeRate = (Integer)redisTemplate.opsForValue().get("cjDiscountRate");
		if (changeRate == rate && changeRate !=null){
			result = rate;
        }
		
		return result;
	}
			
	
	//==============================
	   // review
	   //==============================
	   @GetMapping("review/adminReview")
	   public ModelAndView adminReview(ModelAndView mv,Pager pager)throws Exception {
	      System.out.println("reviewAdminSearch");
	      System.out.println(pager.getCurPage());
	      System.out.println(pager.getKind());
	      System.out.println(pager.getSearch());
	      
	      List<ReviewVO> list = reviewService.adminReview(pager);
	      mv.addObject("list", list);
	      mv.addObject("pager", pager);
	      mv.setViewName("admin/review/adminReview");
	      return mv;
	   }
	   

	   @GetMapping("review/adminReviewDelete")
	   @ResponseBody
	   public int adminReviewDelete(ReviewVO reviewVO)throws Exception {
	      System.out.println("dddddddddddddddd");
	      System.out.println(reviewVO.getReservationNum());
	      int result = reviewService.adminReviewDelete(reviewVO);
	      return result;
	   }
	   
	   //전체삭제
	   @GetMapping("review/cancelDelete")
	   @ResponseBody
	   public int cancelDelete(Integer[] num)throws Exception {
	      ArrayList<Integer> ar = new ArrayList<>(Arrays.asList(num));
	      int result = 0;
	      for (Integer reservationNum : ar) {
	         result = reviewService.cancelDelete(reservationNum);
	      }
	      
	      return result;
	   }
	   
	   //부분삭제
	   @GetMapping("review/partDelete")
	   @ResponseBody
	   public int partDelete(Integer[] num)throws Exception {
	      //배열 > arraylist로 바꾸기
	      ArrayList<Integer> ar = new ArrayList<>(Arrays.asList(num));
	      int result = 0;
	      for (Integer reservationNum : ar) {
	         //System.out.println(integer);
	         result = reviewService.partDelete(reservationNum);
	      }
	      
	      return result;
	   }
	   
	   @GetMapping("review/adminReviewSearch")
	   public ModelAndView adminReviewSearch(ModelAndView mv)throws Exception {
	      
	      return mv;
	   }
	
	
	
	
	
	
	//==============================
	// event
	//==============================
	@GetMapping("event/eventList")
	public ModelAndView eventList(Pager_eventList pager) throws Exception {
		ModelAndView mv = new ModelAndView();
		pager.setkind("");
		List<EventVO> list = eventService.adminEventList(pager);
		if(list !=null) {
			mv.addObject("pager", pager);
			mv.addObject("list", list);
			mv.setViewName("admin/event/eventList");
		}
		
		return mv;
	}
	
	@PostMapping("event/selectKind")
	@ResponseBody
	public ModelAndView selectKind(String kind, Pager_eventList pager) throws Exception {
		ModelAndView mv = new ModelAndView();
		List<EventVO> list = eventService.eventList(pager);
		System.out.println(list.size() + " :: size");
		
		mv.addObject("pager", pager);
		mv.addObject("list", list);
		mv.setViewName("admin/event/ajax/selectKind");
		
		return mv;
	}
	

	@GetMapping("event/eventUpdate")
	public ModelAndView eventUpdate(int num) throws Exception {
		ModelAndView mv = new ModelAndView();
		EventVO eventVO = eventService.eventSelect(num);
		
		mv.addObject("vo", eventVO);
		mv.addObject("path", "Update");
		mv.setViewName("admin/event/eventInsert");
		return mv;
	}


	@GetMapping("event/eventInsert")
	public ModelAndView eventInsert(ModelAndView mv) throws Exception {
		mv.addObject("path", "Insert");
		mv.setViewName("admin/event/eventInsert");
		return mv;
	}
	
	@PostMapping("event/eventInsert")
	public ModelAndView eventInsert(EventVO eventVO, List<MultipartFile> files) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		int result = eventService.eventInsert(eventVO, files);
		
		mv.setViewName("redirect:./eventList");
		return mv;
	}
	
	@GetMapping("event/eventSelect")
	public ModelAndView eventSelect(int num) throws Exception {
		ModelAndView mv = new ModelAndView();
		EventVO eventVO = eventService.eventSelect(num);
		
		mv.addObject("vo", eventVO);
		mv.setViewName("admin/event/eventSelect");

		return mv;
	}


	@PostMapping("event/eventUpdate")
	public ModelAndView eventUpdate(EventVO eventVO, List<MultipartFile> files, String [] delNum) throws Exception {
		ModelAndView mv = new ModelAndView();
		eventService.eventUpdate(eventVO, files, delNum);
		
		mv.setViewName("redirect:./eventList");
		return mv;
	}
	
	@GetMapping("event/eventDelete")
	public ModelAndView eventDelete(int num) throws Exception {
		ModelAndView mv = new ModelAndView();
		System.out.println("num : " + num);
		int result = eventService.eventDelete(num);
		if(result>0) {
			mv.setViewName("redirect:./eventList");
		}
		return mv;
	}
	
	
	//==============================
	// banner
	//==============================
	@GetMapping("banner/sideBannerList")
	public ModelAndView bannerList(Pager pager) throws Exception {
		ModelAndView mv = new ModelAndView();

		List<BannerVO> movie = bannerService.sideMovieAdList();
		List<BannerVO> event = bannerService.sideEventAdList();
		
		mv.addObject("movie", movie);
		mv.addObject("event", event);
		
		mv.setViewName("admin/banner/sideBannerList");
		return mv;
	}
	
	@GetMapping("banner/bannerInsert")
	public ModelAndView bannerInsert() throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.addObject("path", "Insert");
		mv.setViewName("admin/banner/bannerInsert");
		return mv;
	}
	
	@PostMapping("banner/bannerInsert")
	public ModelAndView bannerInsert(BannerVO bannerVO, MultipartFile files) throws Exception {
		ModelAndView mv = new ModelAndView();
		System.out.println("adminController");
		int result = bannerService.bannerInsert(bannerVO, files);
		if(result>0) {
			System.out.println("성공");
		}
		mv.setViewName("redirect:./sideBannerList");
		return mv;
	}
	
	@GetMapping("banner/sideBannerUpdate")
	public ModelAndView sideBannerUpdate(int num) throws Exception{
		ModelAndView mv = new ModelAndView();
		BannerVO bannerVO = bannerService.selectBanner(num);
		
		mv.addObject("vo", bannerVO);
		mv.addObject("path", "Update");
		mv.setViewName("admin/banner/bannerInsert");
		return mv;
	}
	
	@PostMapping("banner/bannerUpdate")
	public ModelAndView sideBannerUpdate(BannerVO bannerVO, MultipartFile files) throws Exception{
		ModelAndView mv = new ModelAndView();
		System.out.println("title : " + bannerVO.getTitle());
		System.out.println("index : " + bannerVO.getIndex());
		if(files != null) {
			System.out.println(files.getSize());
		}
		System.out.println();
		
		bannerService.updateBanner(bannerVO, files);
		
		mv.setViewName("redirect:./sideBannerList");
		return mv;
	}
	
	@GetMapping("banner/bannerDelete")
	public ModelAndView bennerDelete(int num) throws Exception {
		ModelAndView mv = new ModelAndView();
		int result = bannerService.deleteBanner(num);
		if(result>0) {
			mv.setViewName("redirect:./sideBannerList");
		}
		return mv;
	}
	
	
	
	
}















