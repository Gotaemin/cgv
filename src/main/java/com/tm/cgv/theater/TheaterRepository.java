package com.tm.cgv.theater;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.tm.cgv.cinema.CinemaVO;
import com.tm.cgv.movieTime.MovieTimeVO;
import com.tm.cgv.seat.SeatVO;
import com.tm.cgv.seatSpace.SeatSpaceVO;

@Mapper
public interface TheaterRepository {
	
	public List<TheaterVO> theaterList() throws Exception;
	
	public int theaterInsert(TheaterVO theaterVO) throws Exception;
	
	public TheaterVO theaterNameCheck(TheaterVO theaterVO) throws Exception;
	
	public List<CinemaVO> cinemaList() throws Exception;
	
	public TheaterVO theaterSelect(int num) throws Exception;
	
	public List<SeatVO> theaterSeat(int num) throws Exception;
	
	public List<SeatSpaceVO> theaterSpace(int num) throws Exception;
	
	public String selectRow(int num) throws Exception;
	
	public int selectCol(int num) throws Exception;
	
	public int theaterUpdate(TheaterVO theaterVO) throws  Exception;
	
	public int theaterDelete(int num) throws Exception;
	
	public int theaterNum() throws Exception;
	
	public List<MovieTimeVO> theaterMovieTime(Map<String, Object> d) throws Exception;

}
