package com.tm.cgv.point;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PointRepository {

	public List<PointVO> pointSelectList(String memberNum) throws Exception;
	
	public Integer getCjPoint(PointVO pointVO) throws Exception;

	public int pointInsert(PointVO pointVO) throws Exception;
	
	public int pointDiscountUpdate(PointVO pointVO) throws Exception;
	
	public PointVO pointExistCheck(PointVO pointVO) throws Exception;

}
