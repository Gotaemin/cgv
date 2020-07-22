<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" /><!-- 보안 -->

<c:forEach items="${list}" var="vo">

      <div class="list_p" style="position: relative;">

         <div class="list_p_content">
            <div class="list_p_photo" style="position: relative; top: 10px;">
            	<img alt="" src="${pageContext.request.contextPath}/images/movie/movieList/filmCover/${vo.fileName}" width="110px" height="154.6px"> 
            </div>
            <div class="list_p_contents1">
               <div><!-- 제목,삭제버튼 -->
                  <div class="list_p_contents2 td1" style="font-weight: bold; font-size: x-large; ">${vo.title}</div>
                  <span class="titleEng">${vo.num}&ensp; ${vo.titleEng}</span> <!-- reservationNum & titleEng-->
                  <div class="td1 hd">
                     <button class="hd_btn" data-num="${vo.num}">
                        <img alt="" src="${pageContext.request.contextPath}/images/btn_del.gif">
                     </button>
                  </div>
               </div>
               
               <div class="br">
               <div><span>${vo.screenDate} ${vo.screenTime}</span></div>
               <div><span>${vo.cinemaName} ${vo.theaterName} / ${vo.people}명 </span></div>
               </div>
               <div>
               
                  <!-- Modal 1 Button + 조건-->
               
                     <div id="r${vo.num}" style="display: inline-block;">
                        <c:if test="${empty vo.createAt}">                         
                            <button class="popupBtn1" id="${vo.num}" data-toggle="modal" data-target="#myModal" data-num="${vo.num}" data-title="${vo.title}" style="border: 0; background-color: transparent !important;">
                               <img alt="" src="${pageContext.request.contextPath}/images/before.JPG">
                            </button>                                                     
                        </c:if>
                        
                        <c:if test="${not empty vo.createAt}">            
                           <c:if test="${vo.egg eq 1}">                              
                              <button class="popupOnlyRead" data-num2="${vo.num}" title="${vo.num}" style="border: 0; height: 27px;">
                                 <img alt="" src="${pageContext.request.contextPath}/images/good.JPG">
                              </button>
                              <div class="sss" id="sss${vo.num}"  data-toggle="modal" data-target="#myModal3" data-num2="${vo.num}">좋았어요</div>
                            </c:if>
                            <c:if test="${vo.egg eq 0}">                               
                              <button class="popupOnlyRead"  data-num2="${vo.num}" title="${vo.num}" style="border: 0; height: 27px;">
                                 <img alt="" src="${pageContext.request.contextPath}/images/bad.JPG">
                              </button>
                              <div class="sss" id="sss${vo.num}"  data-toggle="modal" data-target="#myModal3" data-num2="${vo.num}">별로예요</div>
                            </c:if>

                        </c:if>
                     </div>
                     <div style="display: inline-block; position: absolute; right:11px; top:121px;" >
						<a href="./reviewDiary" class="round inblack diaryBtn">
							<span class="diary">&ensp;무비다이어리 쓰기&ensp;</span>
						</a>
					 </div>
                  
                  <!-- Modal 2 Button-->
                  <button type="button" class="popupBtn2" data-toggle="modal" data-target="#myModal2" style="display: none;" data-num="${vo.num}"></button>
               </div>
               
            </div>
         </div>
      </div>
      
      
   <br>
   
</c:forEach>