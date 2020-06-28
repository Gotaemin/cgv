package com.tm.cgv.reservation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReservationService {

	@Autowired
	private ReservationRepository reservationRepository;
	
	public int reservationInsert(ReservationVO reservationVO) throws Exception{
		return reservationRepository.reservationInsert(reservationVO);
	}
}