package com.tm.cgv.movieInfo;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.tm.cgv.member.MemberVO;
import com.tm.cgv.movieImage.MovieImageRepository;
import com.tm.cgv.movieImage.MovieImageVO;
import com.tm.cgv.movieVideo.MovieVideoRepository;
import com.tm.cgv.movieVideo.MovieVideoVO;
import com.tm.cgv.reservation.ReservationVO;
import com.tm.cgv.util.BitFuction;
import com.tm.cgv.util.BitFuction2;
import com.tm.cgv.util.FileManager;
import com.tm.cgv.util.FilePathGenerator;
import com.tm.cgv.util.Pager;

@Service
public class MovieInfoService {

	@Autowired
	private MovieInfoRepository movieInfoRepository;
	
	@Autowired
	private MovieImageRepository  movieImageRepository;
	
	@Autowired 
	private MovieVideoRepository  movieVideoRepository;
	
	@Autowired
	private FilePathGenerator filePathGenerator;
	
	@Autowired
	private FileManager fileManager;
	
	@Value("${board.movieInfo.filePath}")
	private String filePath;
		
	public MovieInfoVO movieSelectOne(int num) throws Exception{
		return movieInfoRepository.movieSelectOne(num);
	}	
	
	public List<MovieInfoVO> movieListAll(MovieInfoVO movieVO) throws Exception{
		return movieInfoRepository.movieListAll(movieVO);
	}
	
	public List<MovieInfoVO> movieListMore(Pager pager) throws Exception{
		Integer count = (int)movieInfoRepository.movieNumCount(pager);
		pager.setPerPage(count);
		
		return movieInfoRepository.movieList(pager);
	}
	
	public List<MovieInfoVO> movieList(Pager pager) throws Exception{
			
		pager.makeRow();
		System.out.println(pager.getStartRow()+"StartRow");
		long totalCount = movieInfoRepository.movieNumCount(pager);
		pager.makeBlock(totalCount);
		
		return movieInfoRepository.movieList(pager);
	}
	
	public List<MovieInfoVO> forMovieTimeInsertList(Pager pager) throws Exception{
		
		pager.makeRow();
		System.out.println(pager.getStartRow()+"StartRow");
		long totalCount = movieInfoRepository.forMovieTimeInsertCount(pager);
		pager.makeBlock(totalCount);
		
		return movieInfoRepository.forMovieTimeInsertList(pager);
	}
	public long movieWrite(MovieInfoVO movieInfoVO,List<MultipartFile> files,String[] videolink,int trailerCount,int steelCutCount) throws Exception{
		
		String path = FilePathGenerator.addTimePath("");
	    System.out.println(path+"path!!!!");
	    String extendPath = FilePathGenerator.addTimePath(filePath);
	    System.out.println(extendPath + " extendPath ");
	    File file = filePathGenerator.getUseClassPathResource(extendPath);
	    

		long result = movieInfoRepository.movieWrite(movieInfoVO);
		// 포스터 이미지, 트레일러 영상 이미지들
		System.out.println("======================================");
		System.out.println("size : "+files.size());
		
		if(files.size()==0)
			return 0;
		
		// ======공통작업=====
		MovieImageVO movieImageVO = new MovieImageVO();
		movieImageVO.setMovieNum(movieInfoVO.getNum());

		// ========썸네일 관련 작업========
		MultipartFile tmp = files.remove(0);
		System.out.println(tmp.getOriginalFilename()+"썸네일");
		
		fileManager.onResizeFunction(200);   // 이미지 resize를 하려면 해당 함수를 사용하면 됨 (이미지 파일일때만 실행됨)
		System.out.println("ddkddkdkddkdkkdk");
		
		String fileName = fileManager.saveTransfer(tmp, file);//이미지 파일, 경로
		System.out.println("resiziong filname : " +fileName );
		
		movieImageVO.setType(1);//썸네일1개는 무조건 1
		movieImageVO.setFileName(path+fileName);
		movieImageVO.setOriginName(tmp.getOriginalFilename());
		
		System.out.println("리사이징 끝");
		result = movieImageRepository.movieImageInsert(movieImageVO);
		
		System.out.println("tCnt : "+trailerCount);
		
		// =======트레일러========
		for(int i=0; i<trailerCount; i++) {
			
			tmp = files.remove(0);
			System.out.println(tmp.getOriginalFilename()+"트레일러");

			fileName = fileManager.saveTransfer(tmp, file);//이미지 파일, 경로
			movieImageVO.setType(2);//트레일러는 2번
			movieImageVO.setFileName(path+fileName);
			movieImageVO.setOriginName(tmp.getOriginalFilename());
			result = movieImageRepository.movieImageInsert(movieImageVO);
			
			MovieVideoVO movieVideoVO = new MovieVideoVO();
			
			movieVideoVO.setMovieImageNum(movieImageVO.getNum()); //이미지의 num이 들어와야함
			movieVideoVO.setVideolink(videolink[i]);
			result = movieVideoRepository.movieVideoInsert(movieVideoVO);
		}
		
		
		// ==========스틸컷=========
		for(int i=0; i<steelCutCount; i++) {
			
			tmp = files.remove(0);
			System.out.println(tmp.getOriginalFilename()+"스틸컷");
			
			fileName = fileManager.saveTransfer(tmp, file);//이미지 파일, 경로
			movieImageVO.setType(3);//스틸컷은 3번
			movieImageVO.setFileName(path+fileName);
			movieImageVO.setOriginName(tmp.getOriginalFilename());
			result = movieImageRepository.movieImageInsert(movieImageVO);
		}
		System.out.println("======================================");
		return result;
	}
	
	public Map<String, Object> movieSelect(MovieInfoVO movieInfoVO,ReservationVO reservationVO,MovieImageVO movieImageVO) throws Exception{
		
		System.out.println(reservationVO.getMovieNum()+"uuuu");
		
		//vo에  total과 good을 받아줄 변수명이 없으므로 map으로 받아서 가지고 옴
		
		//===eggRate계산//리뷰====
		Map< String , Object> map=null;
		long total = 0;
		long good=0;
		
		if (movieInfoVO.getErrRate()!=100.0) {
			map = movieInfoRepository.errRate2(reservationVO);
			Iterator<String> mm = map.keySet().iterator();
			
			 total = (long)map.get("total");
			 good = (long)map.get("good");
			
		}
		
		double total2 = Double.valueOf(total);//==null?0.0:Double.valueOf(total)
		double good2 = Double.valueOf(good);//==null?0.0:Double.valueOf(good);
		
		
		if(total2>0) { //작성된 리뷰가 1개 이상일 경우 계산해서 errRate를 업데이트
			double errRate =(double)(good2/total2)*100;				
			System.out.println(errRate + " : errRate");
			
			movieInfoVO.setErrRate(errRate);
			
			movieInfoRepository.errUpdate(movieInfoVO);
		
		}
		
		//===예매율 계산====
		Map<String, Object> map2 = movieInfoRepository.rate(reservationVO);
		//Iterator<String> mm2 = map2.keySet().iterator();
		
		if(map2!=null) {
			
		
		float totalTicket = ((BigDecimal)map2.get("totalTicket")).floatValue();
		float movieOne = (BigDecimal)map2.get("movieOne")==null?0.0f:((BigDecimal)map2.get("movieOne")).floatValue();

		if(movieOne>0) { //예매된 표가 1개 이상일 때 업데이트
			double rate = (double)(movieOne/totalTicket)*100;
			double rate2 = Double.parseDouble(String.format("%.1f", rate));			
			System.out.println(rate2 + " : rate");
			
			movieInfoVO.setRate(rate2);
			
			movieInfoRepository.rateUpdate(movieInfoVO);
		
		}
		}
		//=====성별 계산 =====
		Map<String, Object> map3 = movieInfoRepository.gender2(reservationVO);
		//Iterator<String> mm3 = map3.keySet().iterator();
		
		Map<String, Object> map4 =movieInfoRepository.gTotal(reservationVO);
		Iterator<String> mm4 =map4.keySet().iterator();
		/* 확인용
		while(mm3.hasNext()) {
			String key3 = mm3.next();
			System.out.println(key3+"tttttttt");
		}*/
		
		long gender =(long)map3.get("cgender");//gender=4
		System.out.println(gender+"cgender");
		long gTotal =(long)map4.get("gTotal");
		System.out.println(gTotal+"gTotal");
		
		//====연령대 계산=====
		Map<String, Object> mapAge = movieInfoRepository.age(reservationVO);
		Iterator<String> mmAge = mapAge.keySet().iterator();
			
		long ageTotal =(long)mapAge.get("total");
		long age10 =(long)mapAge.get("age10");
		long age20=(long)mapAge.get("age20");
		long age30 =(long)mapAge.get("age30");
		long age40 =(long)mapAge.get("age40");
		long age50=(long)mapAge.get("age50");
		
		double ageTotal2 = Double.valueOf(ageTotal);
		double age10_2 = Double.valueOf(age10);
		double age20_2 = Double.valueOf(age20);
		double age30_2 = Double.valueOf(age30);
		double age40_2 = Double.valueOf(age40);
		double age50_2 = Double.valueOf(age50);
		
		//=====매력포인트=====
		List<Integer> values = movieInfoRepository.charmPoint(reservationVO);
		for(int i=0;i<values.size();i++) {
			System.out.println(values.get(i)+" :  번 charm");
		}
		
		BitFuction bb =new BitFuction();
		List<Integer> charm = bb.getState(values);
		
		System.out.println("----------");
		System.out.println(charm.get(0)+"숫자1");
		System.out.println(charm.get(1)+"숫자2");
		
		
		//===감정 포인트====
		List<Integer> values2 = movieInfoRepository.emotionPoint(reservationVO);
		for(int i=0;i<values2.size();i++) {
			System.out.println(values2.get(i)+" :  번 emotion");
		}
		
		BitFuction2 bb2 = new BitFuction2();
		List<Integer> emotion = bb2.getState2(values2);
 				
		//===관객수======
		 Map<String, Object> mapV=null;
		 int visitor=0;
		if(movieInfoVO.getVisitor()!=0 ) {
			mapV = movieInfoRepository.visitor2(reservationVO);
			visitor = ((BigDecimal)mapV.get("visitor")).intValue();
		}
		
		  System.out.println(visitor+"명");

		  if(visitor>0) {
			  movieInfoVO.setVisitor(visitor);
			  movieInfoRepository.visiUpdate(movieInfoVO);
		  }
		// ====트레일러 카운트 값======
		  Map<String, Object> mapt=movieInfoRepository.tco(movieImageVO);
		  Iterator<String> mmt=mapt.keySet().iterator();
			
		  while(mmt.hasNext()) {
				String key = mmt.next();
				System.out.println(key+" : key");//o
		 }
		  
			long tco = (long)mapt.get("cc");
			System.out.println(tco +" : tco");
			
		// ====스틸컷 카운트 값======
			 Map<String, Object> maps=movieInfoRepository.sco(movieImageVO);
			 Iterator<String> mms=maps.keySet().iterator();
				
			 while(mms.hasNext()) {
				String key = mms.next();
				System.out.println(key+" : key");//o
			 }
			  
			long sco = (long)maps.get("cs");
			System.out.println(sco +" : sco");	
			
		//=====================
		Map<String, Object> g = new HashMap<>();
		
		movieInfoVO=movieInfoRepository.mSelect(movieInfoVO);
		List<MovieImageVO> ar = movieInfoRepository.mSelect2(movieImageVO);
		
		g.put("vo", movieInfoVO);
		g.put("ar", ar);
		
		g.put("tco", tco);
		g.put("sco", sco);
		g.put("gender", gender);
		g.put("gTotal",gTotal);
		g.put("ageTotal", ageTotal2);
		g.put("age10", age10_2);
		g.put("age20", age20_2);
		g.put("age30", age30_2);
		g.put("age40", age40_2);
		g.put("age50", age50_2);
		
		g.put("cost", charm.get(0));
		g.put("cactor", charm.get(1));
		g.put("cvisual", charm.get(2));
		g.put("cstory", charm.get(3));
		g.put("cdirector", charm.get(4));
		g.put("cten", emotion.get(0));//긴장감
		g.put("cfun", emotion.get(1));//즐거움
		g.put("cstr", emotion.get(2));//스트레스
		g.put("cimp", emotion.get(3));//감동
		g.put("cimm", emotion.get(4));//몰입감
		
		return g ;
		
	}
	
	public long movieUpdate(MovieInfoVO movieInfoVO,List<MultipartFile> files, String[] videolink,int trailerCount,int steelCutCount,String[] delNum)throws Exception{
		String path = FilePathGenerator.addTimePath("")+"\\";
		System.out.println(path+"path!!!!");
		String extendPath = FilePathGenerator.addTimePath(filePath);
	    File file = filePathGenerator.getUseClassPathResource(extendPath);
		
		long result = movieInfoRepository.movieUpdate(movieInfoVO);
		
		System.out.println("Update getNum : " + movieInfoVO.getNum());
		
		if(files.size()==0) {
			return 0;
		}
		
		//공통작업
		MovieImageVO movieImageVO = new MovieImageVO();
		movieImageVO.setMovieNum(movieInfoVO.getNum());
		MultipartFile tmp=null;
		String fileName="";
		
		//썸네일 관련 작업
		if(delNum!=null) {
			MovieImageVO vo = this.selectImage(Integer.parseInt(delNum[0]));
			this.fileDelete(vo);
			
			tmp = files.remove(0);
			fileManager.onResizeFunction(200);  // 이미지 resize를 하려면 해당 함수를 사용하면 됨 (이미지 파일일때만 실행됨)
			fileName = fileManager.saveTransfer(tmp, file);
			movieImageVO.setNum(Integer.parseInt(delNum[0]));
			movieImageVO.setType(1);
			movieImageVO.setFileName(path+fileName);
			movieImageVO.setOriginName(tmp.getOriginalFilename());
			
			result = movieImageRepository.movieImageUpdate(movieImageVO);
		}
		
		//트레일러
		
		System.out.println(trailerCount+"tcount");
		
		for(int i=0;i<trailerCount;i++) {
			tmp = files.remove(0);
			
			fileName = fileManager.saveTransfer(tmp, file);
			movieImageVO.setType(2);
			movieImageVO.setFileName(path+fileName);
			movieImageVO.setOriginName(tmp.getOriginalFilename());
			result = movieImageRepository.movieImageInsert(movieImageVO);
			
			MovieVideoVO movieVideoVO = new MovieVideoVO();
			movieVideoVO.setMovieImageNum(movieImageVO.getNum());
			movieVideoVO.setVideolink(videolink[i]);
			result = movieVideoRepository.movieVideoInsert(movieVideoVO);
			
		}
		
		//스틸컷
		
		System.out.println(steelCutCount+"scount");
		
		System.out.println(files.size());
		for(int  i=0;i<steelCutCount;i++) {
				
			tmp = files.remove(0);
		
			fileName = fileManager.saveTransfer(tmp, file);
			movieImageVO.setType(3);
			movieImageVO.setFileName(path+fileName);
			movieImageVO.setOriginName(tmp.getOriginalFilename());
			result = movieImageRepository.movieImageInsert(movieImageVO);
		}
				
		return result;
		
	}
	public MovieImageVO selectImage(int num) throws Exception{
		return movieImageRepository.movieImageSelect(num);
	}
	
	public long movieDelete(MovieInfoVO movieInfoVO)throws Exception{
		long result= movieInfoRepository.movieDelete(movieInfoVO);
		return result;
	}
	public int fileDelete(MovieImageVO movieImageVO) throws Exception{
		FileManager fileManager = new FileManager();
		File dest = filePathGenerator.getUseClassPathResource(filePath);
		int result = fileManager.deleteFile(movieImageVO.getFileName(), dest);
		return result;
	}
	//제목 중복 체크
	public MovieInfoVO titleCheck(MovieInfoVO movieInfoVO) throws Exception{
		return movieInfoRepository.titleCheck(movieInfoVO);
	}
	// 영문 제목 중복 체크
	public MovieInfoVO titleEngCheck(MovieInfoVO movieInfoVO) throws Exception{
		return movieInfoRepository.titleEngCheck(movieInfoVO);
	}
	
	public int visitorUpdate(MovieInfoVO movieInfoVO) throws Exception{
		return movieInfoRepository.visitorUpdate(movieInfoVO);
	}
	
}
