package com.tm.cgv.movieInfo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.tm.cgv.movieImage.MovieImageVO;
import com.tm.cgv.reservation.ReservationVO;
import com.tm.cgv.util.Pager;

@Mapper
public interface MovieInfoRepository {
	
	
	public long movieNumCount(Pager pager) throws Exception;
	
	public List<MovieInfoVO> movieList(Pager pager) throws Exception;
	
	public List<MovieInfoVO> movieListAll(MovieInfoVO movieVO) throws Exception;
	
	public long movieWrite(MovieInfoVO movieInfoVO) throws Exception;
	
	public MovieInfoVO movieSelect (MovieInfoVO movieInfoVO) throws Exception;
	public MovieInfoVO mSelect(MovieInfoVO movieInfoVO) throws Exception;
	public List<MovieImageVO> mSelect2(MovieImageVO movieImageVO) throws Exception;
	
	public Map<String, Object> tco(MovieImageVO movieImageVO) throws Exception;//트레일러 카운트 값 가져오기
	public Map<String, Object> sco(MovieImageVO movieImageVO) throws Exception;//스틸컷 카운트 값 가져오기
	
	public long movieUpdate(MovieInfoVO movieInfoVO) throws Exception;
	
	public long movieDelete(MovieInfoVO movieInfoVO) throws Exception;
	
	
	public MovieInfoVO movieSelectOne(int num) throws Exception;
	
	public Map<String, Object> errRate2(ReservationVO reservationVO) throws Exception;
	public long errUpdate(MovieInfoVO movieInfoVO) throws Exception;
	//insert, update , delete는 리턴타입이 무조건 넘버타입이어야함. int, long 등등
	//그래서 xml 파일에 따로 리턴 타입을 적어주지 않는 것	
	public Map<String, Object> rate(ReservationVO reservationVO) throws Exception;	
	public long rateUpdate(MovieInfoVO movieInfoVO) throws Exception;
	
	public Map<String, Object> gender2(ReservationVO reservationVO) throws Exception;
	public Map<String, Object> gTotal(ReservationVO reservationVO) throws Exception;
	public Map<String, Object> age(ReservationVO reservationVO) throws Exception;
	public List<Integer> charmPoint(ReservationVO reservationVO) throws Exception;
	public List<Integer> emotionPoint(ReservationVO reservationVO) throws Exception;
	
	public Map<String, Object> visitor2(ReservationVO reservationVO) throws Exception;
	public int visiUpdate(MovieInfoVO movieInfoVO) throws  Exception;
	
	public List<MovieInfoVO> forMovieTimeInsertList(Pager pager) throws Exception;
	public int forMovieTimeInsertCount(Pager pager) throws Exception;
	
	public MovieInfoVO titleCheck(MovieInfoVO movieInfoVO) throws Exception;
	public MovieInfoVO titleEngCheck(MovieInfoVO movieInfoVO) throws Exception;
	
	public int visitorUpdate(MovieInfoVO movieInfoVO) throws Exception;
 }
