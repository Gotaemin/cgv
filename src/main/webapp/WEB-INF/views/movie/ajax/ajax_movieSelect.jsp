<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



 <div class="container1" >
<div class="row" style="width: 800px; height: 630px;">

   <c:forEach items="${review}" var="vo2">
   <div class="col-sm-6" style="width:400px; height:210px; border-bottom: 1px solid #999999;">
      <ul id="movie_point_list_container" class="point_col2">
         <li class="liCommentFirst" data-spoilercnt="0" data-reportcnt="0">
            <a href="" class="screen_spoiler">&nbsp;</a>
            
            <!-- 리뷰 이미지 (movieSelect2.css참고)-->
            <div class="box-image2">
            
            </div>
                  
            <!-- 계란,아이디 -->                        
            <ul class="writer-name" style="position: relative;">                               
                  <c:if test="${vo2.egg eq 1}">
                  <li class="id id_image" style="background: url('../images/movie/movieList/sprite_egg.png') no-repeat -20px -45px;"></li>   
                  </c:if>
                  <c:if test="${vo2.egg eq 0}">
                  <li class="id id_image" style="background: url('../images/movie/movieList/sprite_egg.png') no-repeat -0px -45px;"></li>   
                  </c:if>
                  
                  <li class="id id_name">${vo2.uid}</li>
                  <!-- 신고 -->
                  
                  <li style="position: absolute; left: 322px; top:-74px;">
                 
	                     <a href="javascript:void(0);" class="ico btn_notify" data-reservation="${vo2.reservationNum}" style="background: url('../images/ico_btn_edit.png') no-repeat 50% 50%;">스포일러, 욕설/비방 신고</a>
	                     
	                     <div class="notify_wrap" id="btn${vo2.reservationNum}" style="background: url('../images/br_bg_l.png'); no-repeat -2px 0;">
	                        <ul>
	                           <li class="lii1" data-reservation="${vo2.reservationNum}">
	                              <a href="javascript:return false;" class="ico ico_spoiler" data-commentidx="30178866" data-ismyspoiler="false" data-spoilercnt="0" 
	                              style="background: url('../images/accusation/ico_spoiler.png') no-repeat 2px 0px;">
	                                 <span style="font-size: small; padding-left: 22px;">스포일러 신고</span>
	                              </a>
	                           </li>
	                           <li class="lii2" data-reservation="${vo2.reservationNum}">
	                              <a href="javascript:return false;" class="ico ico_swearword" data-commentidx="30178866" data-ismyspoiler="false" data-spoilercnt="0" 
	                              style="background: url('../images/accusation/ico_swearword.png') no-repeat 15px 1px;">
	                                 <span style="padding-left: 35px; font-size: small;">욕설/비방 신고</span>
	                              </a>
	                           </li>
	                        </ul>
	                     </div>

                  </li>
            </ul>
            
            <!-- 리뷰 컨텐츠 -->   
            <div class="box-comment" style="padding-top: 20px; ">
               <p>${vo2.contents}</p>
            </div>
            
            <!-- 날짜, 좋아요 -->
               <div class="box-contentss">                            
               <ul class="writerinfoo">                                 
                  <li class="writer-etcc">
                     <span class="dayy">
                        <span class="datee"> ${vo2.createAt}</span> &ensp;|&ensp; 
                        <a class="date" data-reservation="${vo2.reservationNum}"><img alt="" src="../../images/like.png"></a>
                     </span>
                     <span class="like11">${vo2.like1}</span>
                  </li>
               </ul>
            </div> 
            
         </li>
      </ul>
   </div>
<!-- Modal2 Update Button-->
<button type="button" class="Up_popupBtn2" data-toggle="modal" data-target="#myModal2" style="display: none;" data-num3="${vo2.reservationNum}"></button>

   </c:forEach>
</div>
</div> 

<input type="hidden" id="totalCount" value="${pager.totalCount}"/>
<!-- pager -->
 <ul class="paging">

 <c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
    <li class="page1" id="page1${i}" name="${i}" data-page1="${i}"><a href="javascript:void(0);" style="color: #333333;">${i}</a></li>
 </c:forEach>

 </ul>
 
 <!-- Modal2 Write Button-->
<button type="button" id="popupBtn2" data-toggle="modal" data-target="#myModall2" style="display: none;"></button>
 
 
 