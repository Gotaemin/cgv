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

<link href="../css/review/reviewDiary.css" rel="stylesheet" type="text/css">

<!-- member/memberReivew -->
<title>내가 본 영화 < 무비로그 | 영화 목록</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
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
					
						<div>
							<div class="snb_box">
								<img alt="프로필 사진" src="/images/profile.gif">
								<div class="myinfo">
									<strong>${memberVO.username}</strong>
									<a href="" alt="수정버튼"></a>
									<em>아이디</em>
								</div>
							</div>
							<div class="snb_box snb_box1">
								<a href="" class="snb_menu">
									<em>0</em>
									<strong>기대되는 영화</strong>
								</a>
							</div>
							<div class="snb_box snb_box2">
								<a href="" class="snb_menu" style="background-color: #e60000; color: white;">
									 <span class="snb_menu2">${m_count}</span>
									<strong>내가 본 영화</strong>
								</a>
							</div>
							<div class="snb_box snb_box3">
								<a href="http://localhost/review/reviewDiary" class="snb_menu">
									<span class="snb_menu2">${d_count}</span>
									<strong>무비 다이어리</strong>
								</a>
							</div>						
						</div>
						
					</div>

               <!------contents detail -->
               <div class="col_detail">

                  <!-- Modal -->
                  <div class="container">
                     <!-- top bar -->
                     <div class="top-bar" style="margin-bottom: 10px;">
                        <h4>내가 본 영화</h4>
                        <div class="td1" id="total" title="${m_count}">
                           <c:out value="${m_count}" />
                            건
                        </div>
                        <!-- el태그 -->
                        <button id="look">내 평점 보기</button>
                     </div>

                     <!-- Write Modal 1,2 -->
                     <c:import url="../template/modal.jsp"></c:import>

                     <!-- 읽기 전용 OnlyRead Modal -->
                     <div class="modal" id="myModal3" style="display: none;">
                        <div class="modal-dialog">
                           <div class="modal-content">

                              <!-- Modal Header -->
                              <div class="modal-header" style="background-color: #333;">
                                 <h4 class="modal-title" style="color: #F2F0E5; font-size: X-large;">평점 보기</h4>
                                 <button id="exit3" type="button" class="close" data-dismiss="modal"></button>
                              </div>

                              <!-- Modal body 시작-->
                              <div class="modal-contents3">
                                 <div class="modal-body" style="position: relative;">

                                    <div id="photo" class="list_p_photo11">
                                       <!-- reviewSubmit.js에서 ajax로 review_Select에서 json형태의 데이터값을 $("#read").html()형태로 가져온다. (아이디값이 read라서 이 div밑으로 값이 꾸려진다.)-->
                                    </div>

                                    <div class="list_p_contents11" style="position: absolute; left: 130px;">
                                       <div id="title1"></div>
                                       <div id="egg1">
                                          <!-- c:set의 value값이 1,0(int값넣기) -->
                                       </div>
                                       <div id="contents"></div>
                                       <br> <span id="uid"></span> | <span id="createAt"></span>
                                       |
                                       <button id="delete1"
                                          style="border: 0; outline: 0; background-color: transparent !important;"> X 삭제</button>
                                    </div>
                                 </div>
                              </div>
                            <!-- Modal body 끝-->  
                           </div>
                        </div>
                     </div>


                     <!-- 더보기란 10개씩 노출-------------------------------------------------------------------------------------->
                     <!-- getList.jsp -->
                     <div id="result">
                     
                     </div>
                     
                     <!-- 더보기 -->
                     <button id="more">
                        <img alt=""
                           src="${pageContext.request.contextPath}/images/more.JPG">
                        <span id="more-plus">더보기</span> <span id="l_count1"></span>
                        <!-- 가져오는 정보의 갯수 -->
                     </button>
                  </div>
               </div>
            </div>
         </div>
      </div>

      <!-- 푸터 -->
      <c:import url="../template/footer.jsp"></c:import>

      <!-- 사이드바 -->
      <c:import url="../template/sidebar.jsp"></c:import>
   </div>

   <!-- 스크립트 -->
   <script type="text/javascript" src="../js/review/checkByte.js"></script>
   <script type="text/javascript" src="../js/review/reviewSubmit.js"></script>

	<script type="text/javascript">
	$(".snb_box1").click(function(){
		alert("준비 중 입니다.");
	});

/* 	$(".snb_box3").click(function(){
		window.location.href = 'http://localhost/review/reviewDiary';
	}); */
	</script>
</body>
</html>