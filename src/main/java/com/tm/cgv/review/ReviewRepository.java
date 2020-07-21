package com.tm.cgv.review;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.tm.cgv.util.Pager;
import com.tm.cgv.util.Pager_reviewList;

@Mapper
public interface ReviewRepository {

   public List<ReviewVO> reviewList(HashMap<String, Object> pa);
   
   public int review_Write1(ReviewVO reviewVO);
   
   public int review_Write2(ReviewVO reviewVO);
   
   public ReviewVO reviewSelect(ReviewVO reviewVO);
   
   public int review_Delete(ReviewVO reviewVO);
   
   public int reservation_Delete(ReviewVO reviewVO);
   
   public List<ReviewVO> reviewLook(String uid);
   
   public int search_Count(String uid);
   
   public int review_Update1(ReviewVO reviewVO);
   
   public int review_Update2(ReviewVO reviewVO);
   
   public List<ReviewVO> movieSelect2(HashMap<String, Object> pa2);
   
   public List<ReviewVO> movieSelect3(HashMap<String, Object> pa2);
   
   
   
   public int reviewLike(ReviewVO reviewVO);
   public int checkLike(ReviewVO reviewVO);
   public Integer checkLike_Select(ReviewVO reviewVO);
   
   public int reviewSpoiler(ReviewVO reviewVO);
   public int checkSpoiler(ReviewVO reviewVO);
   public int checkSpoiler_Select(ReviewVO reviewVO);
   
   public int reviewSwearWord(ReviewVO reviewVO);
   public int checkSwearWord(ReviewVO reviewVO);
   public int checkSwearWord_Select(ReviewVO reviewVO);   
   
   
   
   //해당 영화의 리뷰 총 갯수
   public long reviewCount(int movieNum);
   
   //해당 영화 봤는지 체크
   public int reservationCheck(ReviewVO reviewVO);
   //리뷰 모달창 띄우기
   public int review_Modal(ReviewVO reviewVO);
   
   public ReviewVO movieSelect_reviewUpdate(ReviewVO reviewVO);
   
   public ReviewVO movieSelect_reviewWrite(ReviewVO reviewVO);
   
   public List<ReviewVO> adminReview(Pager pager);
   
   public int adminReviewDelete(ReviewVO reviewVO);
   
   public int allDelete();
   
   public int partDelete(int reservationNum);
   
   public long movieNumCount(Pager pager);
   
   public List<ReviewVO> reviewDiary(String uid);
   
   public int reviewDiary_Write(ReviewVO reviewVO);
   
   public int reviewDiary_Count(String uid);
   
   public List<ReviewVO> reviewDiary_List(String uid);
   
   public int reviewDiary_Delete(ReviewVO reviewVO);
}