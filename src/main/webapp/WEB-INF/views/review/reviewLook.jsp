<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link href="../css/bbsLayout.css" rel="stylesheet" type="text/css">
<link href="../css/layout.css" rel="stylesheet" type="text/css">
<link href="../css/myPage.css" rel="stylesheet" type="text/css">
<link href="../css/review/reviewList.css" rel="stylesheet" type="text/css">
<link href="../css/template/modal.css" rel="stylesheet" type="text/css">
<title>내가 쓴 평점 < 무비로그 | 무비 다이어리</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"> -->

<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

</head>
<body>

   <div class="root">
      <!-- 헤더 -->
      <c:import url="../template/header.jsp"></c:import>

      <!-- 컨테이너 -->
      <div class="container">
         <div class="c_nav">
            <div class="nav_linemap">
               <ul>
                  <li><a href="../"> <img alt="go to Home"
                        src="../images/login/btn_home.png">
                  </a></li>
                  <li><a href="">MY CGV</a></li>
                  <li class="last">MY CGV HOME</li>
               </ul>
            </div>
         </div>

         <div class="contents">
            <div class="col_content">
               <!----------------- contents aside -->
               <div class="col_aside">
                  <div class="snb">
                     <ul>

                        <li class="on"><a href="">MY CGV HOME<i></i></a></li>
                        <li><a href="../member/memberUpdate?id=${memberVO.username}">회원정보 수정<i></i>
                        </a></li>
                        <li><a href="#" id="memberDelete">회원 탈퇴<i></i></a></li>
                        <li><a href="">예매 영화 관리<i></i></a></li>
                        <li><a href="../review/reviewList">내가 본 영화<i></i></a></li>

                     </ul>

                  </div>
                  <div class="ad_area">
                     <div class="ad_panner_1">
                        <a href=""> <img alt=""
                           src="../images/bbsList/200313_160x300.jpg">
                        </a>
                     </div>
                     <div class="ad_panner_2">
                        <a href=""> <img alt=""
                           src="../images/bbsList/0325_160x35.png">
                        </a>
                     </div>
                  </div>
               </div>

               <!------contents detail -->
               <div class="col_detail">
                  <!-- 내 평점 모아보기 -->
                  <h1>내가 쓴 평점</h1>
                  <div id="result">
                     <c:forEach items="${look}" var="vo">
                        <div class="list_p2">
                           <!-- dd -->
                           <div class="list_p_content">
                              <!-- 이미지 주소부분 나중에 수정해야함 -->
                              <div class="list_p_photo">
                                 <img alt=""
                                    src="${pageContext.request.contextPath}/images/movie/movieList/filmCover/${vo.fileName}">
                              </div>
                              <div class="list_p_contents1">
                                 <!-- 타이틀(제목)/리뷰삭제 -->
                                 <div>
                                    <div class="td1">${vo.title}</div>
                                    <!-- 제목 -->
                                    <button class="td1 td2 delete2"
                                       data-num3="${vo.reservationNum}">
                                       <!-- x 표시 -->
                                       <div class="td_image"
                                          style="background: url('../images/movie/movieList/sprite_icon.png') no-repeat -195px -40px"></div>
                                    </button>
                                    <!-- 예약번호 -->
                                    <span class="check" style="display: none;">${vo.reservationNum}</span>
                                 </div>

                                 <!-- egg/uid/날짜 -->
                                 <c:if test="${vo.egg eq 1}">
                                    <div class="egg3 egg4"
                                       style="background: url('../images/movie/movieList/sprite_egg.png') no-repeat -20px -47px"></div>
                                 </c:if>
                                 <c:if test="${vo.egg eq 0}">
                                    <div class="egg3 egg4"
                                       style="background: url('../images/movie/movieList/sprite_egg.png') no-repeat -0px -45px"></div>
                                 </c:if>
                                 <div class="egg4">${vo.uid}</div>
                                 <div class="egg4">| ${vo.createAt}</div>

                                 <!-- 컨텐츠(내용) -->
                                 <div class="review-contents">${vo.contents}</div>

                                 <!-- 수정하기/like -->
                                 <!-- data-toggle="modal" data-target="#myModal" -->

                                 <button id="review_update" data-num3="${vo.reservationNum}"
                                    data-title="${vo.title}" data-contents="${vo.contents}"
                                    data-egg="${vo.egg}" class="ud update Up_popupBtn1">수정하기</button>
                                 <span class="ud"> ㆍ </span> <img class="ud" alt=""
                                    src="${pageContext.request.contextPath}/images/like.png">
                                 <span class="ud">&nbsp; ${vo.like1}</span>

                                 <!-- Modal 2 Button-->
                                 <!-- data-toggle="modal" data-target="#myModal2"  -->
                                 <button type="button" class="Up_popupBtn2"
                                    data-toggle="modal" data-target="#myModal2"
                                    style="display: none;" data-num3="${vo.reservationNum}"></button>
                              </div>
                           </div>
                        </div>
                     </c:forEach>
                     <c:import url="../template/modal.jsp"></c:import>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>

   <!-- Modal ------------------------------------------------------------------------------------->

   <!-- 푸터 -------------------------------------------------------------------------------------->
   <c:import url="../template/footer.jsp"></c:import>

   <!-- 사이드바 ---------------------------------------------------------------------------------------------->
   <c:import url="../template/sidebar.jsp"></c:import>


   <!-- 스크립트 ------------------------------------------------------------------------->

   <!-- 리뷰 삭제 -->
   <script type="text/javascript">
      var g_num = 0;

      $(".delete2")
            .click(
                  function() {
                     g_num = $(this).data("num3");
                     console.log(g_num);

                     if (confirm("작성한 관람평을 삭제하시겠습니까?") == true) {
                        $.ajax({
                                 type : "GET",
                                 url : "./review_Delete",
                                 data : {
                                    reservationNum : g_num,
                                 },
                                 success : function(data) {
                                    if (data != null) {
                                       if (confirm("삭제가 완료되었습니다.\n새로 작성하시겠습니까?") == true) {
                                          window.location.href = '${pageContext.request.contextPath}/review/reviewList';
                                       } else {
                                          location.reload();
                                       }
                                    }
                                 },
                                 error : function() {
                                    alert("삭제권한이 없습니다.")
                                 }

                              })

                     }
                  });
   </script>


   <!-- 리뷰수정 -->
   <script type="text/javascript" src="../js/review/reviewUpdate.js"></script>

   <!-- 글자 byte 체크 -->
   <script type="text/javascript" src="../js/review/checkByte.js"></script>


</body>
</html>