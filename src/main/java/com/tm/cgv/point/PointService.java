package com.tm.cgv.point;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tm.cgv.pointHistory.PointHistoryService;
import com.tm.cgv.pointHistory.PointHistoryVO;

@Service
public class PointService {

	@Autowired
	private PointRepository pointRepository;
	@Autowired
	private PointHistoryService pointHistoryService;
	
	public List<PointVO> pointSelectList(String memberNum) throws Exception{
		return pointRepository.pointSelectList(memberNum);
	}
	
	public Integer getCjPoint(PointVO pointVO) throws Exception{
		return pointRepository.getCjPoint(pointVO);
	}

	//포인트 사용 or 적립 
	public int pointDiscountUpdate(PointVO pointVO) throws Exception{
		
		//포인트 내역 저장 - pointHistoryTable
		PointHistoryVO pointHistoryVO = new PointHistoryVO();
		pointHistoryVO.setUsername(pointVO.getUsername());
		
		if(pointVO.getKind().equals("sum")) {
			pointHistoryVO.setInputPrice(pointVO.getPrice());
		}else {
			pointHistoryVO.setOutputPrice(pointVO.getPrice());
		}
		pointHistoryVO.setType(pointVO.getType());
		pointHistoryService.pointHistortInsert(pointHistoryVO);
		
		
		return pointRepository.pointDiscountUpdate(pointVO);
	}
	
	public int pointInsert(PointVO pointVO) throws Exception{
		return pointRepository.pointInsert(pointVO);
	}
	
	public PointVO pointExistCheck(PointVO pointVO) throws Exception{
		return pointRepository.pointExistCheck(pointVO);
	}
	
}
