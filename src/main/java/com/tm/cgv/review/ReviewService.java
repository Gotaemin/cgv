package com.tm.cgv.review;

import java.io.Console;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tm.cgv.movieInfo.MovieInfoRepository;
import com.tm.cgv.util.Pager;
import com.tm.cgv.util.Pager_movieSelect;
import com.tm.cgv.util.Pager_reviewList;

@Service
public class ReviewService {

   @Autowired
   private ReviewRepository reviewRepository;
   
   public List<ReviewVO> reviewList(String uid, Pager_reviewList pager)throws Exception {
      pager.makeRow();
      HashMap<String, Object> pa = new HashMap<String, Object>(); //HashMap<String, Object> //<key,value>
      pa.put("uid", uid);
      pa.put("pager", pager);

      return reviewRepository.reviewList(pa);
      
   }
   
   public int review_Write1(ReviewVO reviewVO)throws Exception {
      
      return reviewRepository.review_Write1(reviewVO);
   }
   
   public int review_Write2(ReviewVO reviewVO)throws Exception {
      
      return reviewRepository.review_Write2(reviewVO);
   }

   public ReviewVO reviewSelect(ReviewVO reviewVO)throws Exception {
      
      return reviewRepository.reviewSelect(reviewVO);
   }
   
   public int review_Delete(ReviewVO reviewVO)throws Exception {
      return reviewRepository.review_Delete(reviewVO);
   }
   
   public int reservation_Delete(ReviewVO reviewVO)throws Exception {
      return reviewRepository.reservation_Delete(reviewVO);
   }
   
   
   public List<ReviewVO> reviewLook(String uid)throws Exception {
      return reviewRepository.reviewLook(uid);
   }
   
   public int search_Count(String uid)throws Exception {
      return reviewRepository.search_Count(uid);
   }
   
   public int review_Update1(ReviewVO reviewVO)throws Exception {
      return reviewRepository.review_Update1(reviewVO);
   }
   
   public int review_Update2(ReviewVO reviewVO)throws Exception {
      return reviewRepository.review_Update2(reviewVO);
   }
   
   public List<ReviewVO> movieSelect2(int movieNum, Pager_movieSelect pager)throws Exception {
      pager.makeRow();
      
      long totalCount = reviewRepository.reviewCount(movieNum);
      
      System.out.println("totalCount: "+totalCount);
      System.out.println("CurPage: "+pager.getCurPage());
      pager.makeBlock(totalCount); 
      System.out.println("StartRow: "+pager.getStartRow());
      
      HashMap<String, Object> pa2 = new HashMap<String, Object>(); //HashMap<String, Object> //<key,value>
      pa2.put("movieNum", movieNum);
      pa2.put("pager", pager);
      return reviewRepository.movieSelect2(pa2);
   }
   
   public List<ReviewVO> movieSelect3(int movieNum, Pager_movieSelect pager)throws Exception {
      pager.makeRow();
      
      long totalCount = reviewRepository.reviewCount(movieNum);
      
      System.out.println("totalCount: "+totalCount);
      System.out.println("CurPage: "+pager.getCurPage());
      pager.makeBlock(totalCount); 
      System.out.println("StartRow: "+pager.getStartRow());
      
      HashMap<String, Object> pa2 = new HashMap<String, Object>(); //HashMap<String, Object> //<key,value>
      pa2.put("movieNum", movieNum);
      pa2.put("pager", pager);
      return reviewRepository.movieSelect3(pa2);
   }
   
   public int reviewLike(ReviewVO reviewVO)throws Exception {
      
      // checkLike_Select (이미 쓴 리뷰인지 조회)
      int result = reviewRepository.checkLike_Select(reviewVO);
      
      System.out.println("result : "+result);
      if(result > 0)
         return 0; //이미 쓴 리뷰면 0 > 여기서 멈춤
   
      //아이디, 영화번호, 예약번호 넣기(:1출력)
      int a = reviewRepository.checkLike(reviewVO); //checkLike에 정보추가
      return reviewRepository.reviewLike(reviewVO); //좋아요 +1추가
   }
   
   
   public int reviewSpoiler(ReviewVO reviewVO)throws Exception {
      
      int result = reviewRepository.checkSpoiler_Select(reviewVO);
      if(result > 0)
         return 0;
      
      int a = reviewRepository.checkSpoiler(reviewVO);
      return reviewRepository.reviewSpoiler(reviewVO);
   }
   
   public int reviewSwearWord(ReviewVO reviewVO)throws Exception {
      
      int result = reviewRepository.checkSwearWord_Select(reviewVO);
      if(result > 0)
         return 0;
      
      int a = reviewRepository.checkSwearWord(reviewVO);   
      return reviewRepository.reviewSwearWord(reviewVO);
   }
   
   
   public int review_Modal(ReviewVO reviewVO)throws Exception {
      //해당영화 봤는지 체크
      int result = reviewRepository.reservationCheck(reviewVO);
      if(result == 0) //해당 영화를 안봤다면
         return 1000000;
      //봤다면
      return reviewRepository.review_Modal(reviewVO);
   }
   
   public ReviewVO movieSelect_reviewUpdate(ReviewVO reviewVO)throws Exception {
      
      return reviewRepository.movieSelect_reviewUpdate(reviewVO);
   }
   
   public ReviewVO movieSelect_reviewWrite(ReviewVO reviewVO)throws Exception {
      
      return reviewRepository.movieSelect_reviewWrite(reviewVO);
   }
   
//   admin - review Search
   public List<ReviewVO> adminReview(Pager pager)throws Exception {
      pager.makeRow();
      long totalCount = reviewRepository.movieNumCount(pager);
      pager.makeBlock(totalCount);
      return reviewRepository.adminReview(pager);
   }
   
   public int adminReviewDelete(ReviewVO reviewVO)throws Exception {
      return reviewRepository.adminReviewDelete(reviewVO);
   }
   
   public int cancelDelete(int reservationNum)throws Exception {
      return reviewRepository.cancelDelete(reservationNum);
   }
   
   public int partDelete(int reservationNum)throws Exception {
      return reviewRepository.partDelete(reservationNum);
   }
   
   public List<ReviewVO> reviewDiary(String uid)throws Exception {
	   return reviewRepository.reviewDiary(uid);
   }
   
   public int reviewDiary_Write(ReviewVO reviewVO)throws Exception {
	   return reviewRepository.reviewDiary_Write(reviewVO);
   }
   
   public int reviewDiary_Count(String uid)throws Exception {
	   return reviewRepository.reviewDiary_Count(uid);
   }
   
   public List<ReviewVO> reviewDiary_List(String uid)throws Exception {
	   return reviewRepository.reviewDiary_List(uid);
   }
   
   public int reviewDiary_Delete(ReviewVO reviewVO)throws Exception {
	   return reviewRepository.reviewDiary_Delete(reviewVO);
   }
}