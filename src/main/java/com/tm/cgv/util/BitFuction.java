package com.tm.cgv.util;

import java.util.ArrayList;
import java.util.List;

public class BitFuction {

	private byte a = 0x10;//16
	private byte b = 0x08;//8
	private byte c = 0x04;//4
	private byte d = 0x02;//2
	private byte e = 0x01;//1
	
	//====================================
	// param
	// 
	// charm point의 배열
	// ex) [32, 20, 1, ...]
	//====================================
	public List<Integer> getState(List<Integer> values) {
		
		List<Integer> list = new ArrayList<Integer>();
		
		int resultA = 0;
		int resultB = 0;
		int resultC = 0;
		int resultD = 0;
		int resultE = 0;
		
		byte tmp = 0;
		for (Integer i : values) {
		
			tmp = (byte)(i & a);
			if(tmp == this.a)
				resultA++;
			
			tmp = (byte)(i & b);
			if(tmp == this.b)
				resultB++;
			
			tmp = (byte)(i & c);
			if(tmp == this.c)
				resultC++;
			
			tmp = (byte)(i & d);
			if(tmp == this.d)
				resultD++;
			
			tmp = (byte)(i & e);
			if(tmp == this.e)
				resultE++;
		}
		
		list.add(resultA);
		list.add(resultB);
		list.add(resultC);
		list.add(resultD);
		list.add(resultE);
		
		/*
		 * System.out.println(list.get(0)+"비트플래그..?");//ost
		 * System.out.println(list.get(1)+"비트플래그..?");//배우
		 * System.out.println(list.get(2)+"비트플래그..?");//영상미
		 * System.out.println(list.get(3)+"비트플래그..?");//스토리
		 * System.out.println(list.get(4)+"비트플래그..?");//감독
		 */		
		
		
		return list;
	}
}
