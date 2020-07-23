package com.tm.cgv.cinema;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.tm.cgv.theater.TheaterVO;
import com.tm.cgv.util.Pager;
import com.tm.cgv.util.Pager_cinemaList;

@Mapper
public interface CinemaRepository {
	
	//Insert
	public int cinemaInsert(CinemaVO cinemaVO) throws Exception;
	
	public CinemaVO cinemaNameCheck(String name) throws Exception;
	
	//Select
	public CinemaVO cinemaSelect(CinemaVO cinemaVO) throws Exception;
	
	public List<TheaterVO> selectTheaterList(int num) throws Exception;
	
	
	//Update
	public int cinemaUpdate(CinemaVO cinemaVO) throws Exception;
	
	public void totalUpdate(CinemaVO cinemaVO) throws Exception;
	
	
	//Delete
	public int cinemaDelete(int num) throws Exception;
	
	public int theaterDelete(TheaterVO theaterVO) throws Exception;
	
	//List 지역별로 정렬하기 위해 
	public List<String> selectLocal() throws Exception;


	//지역 조회
	public List<CinemaVO> cinemaLocalList() throws Exception;
	
	//지역별 극장 조회
	public List<CinemaVO> cinemaList() throws Exception;
	
	//지역당 극장 조회
	public List<CinemaVO> selectLocalCinemaNameList(String local) throws Exception;
	
	
	
	public int cinemaWrite() throws Exception;
	
	
	public List<CinemaVO> adminCinemaList(Pager_cinemaList pager) throws Exception;
	
	public int adminCinemaCount(Pager_cinemaList pager) throws Exception;

	
	
}
