package com.tm.cgv.timePrice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TimePriceService {

	@Autowired
	private TimePriceRepository timePriceRepository;
	
	public TimePriceVO timePriceSelect(TimePriceVO timePriceVO) throws Exception{
		return timePriceRepository.timePriceSelect(timePriceVO);
	}
	
	public List<TimePriceVO> searchLimit(TimePriceVO timePriceVO) throws Exception{
		return timePriceRepository.searchLimit(timePriceVO);
	}
	
}