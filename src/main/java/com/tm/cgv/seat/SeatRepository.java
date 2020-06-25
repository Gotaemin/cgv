package com.tm.cgv.seat;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SeatRepository {
	
	public List<SeatVO> seatSelectOne(SeatVO seatVO) throws Exception;
	
	public int rowCount(SeatVO seatVO) throws Exception;
	
	public int colCount(SeatVO seatVO) throws Exception;
	

}
