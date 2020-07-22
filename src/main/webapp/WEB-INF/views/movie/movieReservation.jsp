<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/css/layout.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie/movieReservation.css" rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath}/css/movie/movieSeatReservation.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie/moviePayment.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie/movieReservationResult.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie/movieCGVcoupon.css" rel="stylesheet" type="text/css">

<!-- payment -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript" src="/js/template/common.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<title>Insert title here</title>
</head>
<body>

	<div class="root">
		<c:import url="../template/header.jsp"></c:import>
		<div class="c_nav">
				<div class="nav_linemap">
					<ul>
						<li>
							<a href="../">
								<img alt="go to Home" src="../images/login/btn_home.png">					
							</a>
						</li>
						<li>
							<a href="">예매</a>
						</li>
						<li>
							<a href="">빠른예매</a>
						</li>
						<li class="last">
							무비차트
						</li>
					</ul>
				</div>
			</div>

		<div id="container">
			<div class="blackscreen" style="display: none;" id="blackscreen"></div>
			<div id="ticket">
			
				<!-- navigation -->
				<div class="navi">
					<span class="right">
						<a href="#" class="button btn-guide" onclick="return false;">
							<span>예매가이드</span>
						</a>
						<a href="javascript:location.reload();" class="button btn-reservation-restart" >
							<span>예매 다시하기</span>
						</a>
					</span>
				</div>
				
				
				
				
				<!-- container selector -->
				<div class="steps">
					<div class="step step1" style="height: 595px; display: block;">
					
						<!-- 영화선택 -->
						<div class="section section-movie">
							<div class="col-head">
								<h3 class="sreader">영화</h3>
							</div>
							<div class="col-body">
								<div class="movie-select">
									
									<!-- 탭 메뉴 -->
									<div class="tabmenu">
										<span class="side on"></span>
										<a href="#" class="button menu1 selected">전체</a>
										<span class="side on"></span>
										<div class="button menu2">
											<div class="underline"></div>
										</div>
									</div>
									
									<!-- 메뉴 (정렬방법 선택) -->
									<div class="sortmenu">
										<a class="button btn-rank selected">예매율순</a>
										<a class="button btn-abc">가나다순</a>
									</div>
									
									
									<!-- 리스트 출력부분 -->
									<div class="movie-list nano">
										<ul id="movie-list-content" class="content scroll-y" style="right: -21px;">
											<c:forEach var="list" items="${list}">
												<li class="rating-${list.ageLimit}" data-index="${list.num}" data-age_limit="${list.ageLimit}" data-title="${list.title}" data-image="${list.movieImageVO.fileName}">
													<a title="제목" >
														<span class="icon">&nbsp;</span>
														<span class="text">${list.title}</span>
														<span class="sreader"></span>
													</a>
												</li>
											</c:forEach>
										</ul>
										
										<!-- <div class="pane pane-y" style="display: block; opacity: 1; visibility: visible;">
											<div class="slider slider-y" style="height: 50px; top: 0px;"></div>
										</div> -->
									</div>
								</div>
							</div>
						</div>
						
				<!-- 극장선택 -->
						<div class="section section-theater">
							<div class="col-head">
								<h3 class="sreader">극장</h3>
							</div>
							<div class="col-body">
								<div class="theater-select">
									<div class="tabmenu">
										<span class="side on"></span>
										<a href="#" class="button menu1 selected">전체</a>
										<span class="side on"></span>
										<div class="button menu2">
											<div class="underline"></div>
										</div>
									</div>
									<div class="theater-list nano has-scrollbar has-scrollbar-y">
										<div class="theater-area-list">
											<ul>
												<li class="selected" data-index="0" data-local="서울">
													<a>
														<span class="name">서울</span>
														<span class="count">(0)</span>
													</a>
													
													<div id="cinema_ajax" class="area_theater_list nano has-scrollbar has-scrollbar-y" style="width: 109px">
														<ul class="content scroll-y" >
																
																<!-- 여기에 극장값 추가 li append -->
																
														</ul>
														<!-- <div class="pane pane-y">
															<div class="slider slider-y"></div>
														</div> -->
													</div>		
												</li>
												<li class="" data-index="0" data-local="경기">
													<a>
														<span class="name">경기</span>
														<span class="count">(0)</span>
													</a>
													<div id="cinema_ajax" class="area_theater_list nano has-scrollbar has-scrollbar-y" style="width: 109px">
														<ul class="content scroll-y" >
																
																<!-- 여기에 극장값 추가 li append -->
																
														</ul>
														<!-- <div class="pane pane-y">
															<div class="slider slider-y"></div>
														</div> -->	
													</div>		
												</li>
												<li class="" data-index="0" data-local="인천">
													<a>
														<span class="name">인천</span>
														<span class="count">(0)</span>
													</a>
													<div id="cinema_ajax" class="area_theater_list nano has-scrollbar has-scrollbar-y" style="width: 109px">
														<ul class="content scroll-y" >
																
																<!-- 여기에 극장값 추가 li append -->
																
														</ul>
														<!-- <div class="pane pane-y">
															<div class="slider slider-y"></div>
														</div> -->
													</div>		
												</li>
												<li class="" data-index="0" data-local="강원">
													<a>
														<span class="name">강원</span>
														<span class="count">(0)</span>
													</a>
													<div id="cinema_ajax" class="area_theater_list nano has-scrollbar has-scrollbar-y" style="width: 109px">
														<ul class="content scroll-y" >
																
																<!-- 여기에 극장값 추가 li append -->
																
														</ul>
														<!-- <div class="pane pane-y">
															<div class="slider slider-y"></div>
														</div> -->
													</div>		
												</li>
												<li class="" data-index="0" data-local="대전/충청">
													<a>
														<span class="name">대전/충청</span>
														<span class="count">(0)</span>
													</a>
													<div id="cinema_ajax" class="area_theater_list nano has-scrollbar has-scrollbar-y" style="width: 109px">
														<ul class="content scroll-y" >
																
																<!-- 여기에 극장값 추가 li append -->
																
														</ul>
														<!-- <div class="pane pane-y">
															<div class="slider slider-y"></div>
														</div>	 -->
													</div>		
												</li>
												<li class="" data-index="0" data-local="대구">
													<a>
														<span class="name">대구</span>
														<span class="count">(0)</span>
													</a>
													<div id="cinema_ajax" class="area_theater_list nano has-scrollbar has-scrollbar-y" style="width: 109px">
														<ul class="content scroll-y" >
																
																<!-- 여기에 극장값 추가 li append -->
																
														</ul>
														<!-- <div class="pane pane-y">
															<div class="slider slider-y"></div>
														</div> -->	
													</div>		
												</li>
												<li class="" data-index="0" data-local="부산/울산">
													<a>
														<span class="name">부산/울산</span>
														<span class="count">(0)</span>
													</a>
													<div id="cinema_ajax" class="area_theater_list nano has-scrollbar has-scrollbar-y" style="width: 109px">
														<ul class="content scroll-y" >
																
																<!-- 여기에 극장값 추가 li append -->
																
														</ul>
														<!-- <div class="pane pane-y">
															<div class="slider slider-y"></div>
														</div> -->	
													</div>		
												</li>
												<li class="" data-index="0" data-local="경상">
													<a>
														<span class="name">경상</span>
														<span class="count">(0)</span>
													</a>
													<div id="cinema_ajax" class="area_theater_list nano has-scrollbar has-scrollbar-y" style="width: 109px">
														<ul class="content scroll-y" >
																
																<!-- 여기에 극장값 추가 li append -->
																
														</ul>
														<div class="pane pane-y">
															<div class="slider slider-y"></div>
														</div>	
													</div>		
												</li>
												<li class="" data-index="0" data-local="광주/전라/제주">
													<a>
														<span class="name">광주/전라/제주</span>
														<span class="count">(0)</span>
													</a>
													<div id="cinema_ajax" class="area_theater_list nano has-scrollbar has-scrollbar-y" style="width: 109px">
														<ul class="content scroll-y" >
																
																<!-- 여기에 극장값 추가 li append -->
																
														</ul>
														<div class="pane pane-y">
															<div class="slider slider-y"></div>
														</div>	
													</div>		
												</li>
												<li class="" data-index="0" data-local="">
													<a>
														<span class="name"></span>
														<span class="count">&nbsp;</span>
													</a>
												</li>
												<li class="" data-index="0" data-local="">
													<a>
														<span class="name"></span>
														<span class="count">&nbsp;</span>
													</a>
												</li>
											</ul>
											<div class="pane pane-y" style="display: block; opacity: 1; visibility: visible;">
												<div class="slider slider-y" style="height: 50px; top: 0px;"></div>
											</div>
										</div>

									</div>
									
								</div>
							</div>
						</div>
						
						
						<!-- 날짜선택 -->
						<div class="section section-date">
							<div class="col-head"></div>
							<div class="col-body" style="height: 560px;">
								<div class="date-list nano has-scrollbar has-scrollbar-y" id="date_list">
									<ul class="content scroll-y" tabindex="-1" style="right: -21px;">
										<c:if test="${calendarList[0].date != 1}">
											<li class="month dimmed ">
												<span class="year">${calendarList[0].year}</span>
												<span class="month" data-month="">${calendarList[0].month}</span>
											</li>
										</c:if>
										
										
										<c:forEach var="calendarVO" items="${calendarList}" varStatus="i">
											<c:if test="${calendarVO.date eq 1}">
												<li class="month dimmed">
													<span class="year">${calendarVO.year}</span>
													<span class="month" data-month="${calendarVO.month}">${calendarVO.month}</span>
												</li>
											</c:if>
																						
											<li data-index="0" class="day" data-index="0" data-week="${calendarVO.week}" data-date="${calendarVO.date}" data-month="${calendarVO.month}" data-year="${calendarVO.year}">
												<a href="#" onclick="return false;">
													<span class="dayweek">${calendarVO.week}</span>
													<span class="day">${calendarVO.date}</span>
													<span class="sreader"></span>
												</a>
											</li>
											
										</c:forEach>
										
									</ul>
									<!-- <div class="pane pane-y" style="display: block; opacity: 1; visibility: visible;">
										<div class="slider slider-y" style="height: 50px; top: 0px;"></div>
									</div> -->
								</div>
							</div>
						</div>
						
						
						<!-- 시간선택 -->
						<div class="section section-time">
							<div class="col-head"></div>
							<div class="col-body" style="height: 560px;">
								<div class="time-option">
									<span class="morning">조조</span>
									<span class="night">심야</span>
								</div>
								<!-- 영화,극장,날짜선택 안했을때 -->
								<div class="placeholder">영화, 극장, 날짜를 선택해주세요.</div>
								
								<!-- 영화,극장,날짜선택 되었을때 -->
								<div class="time-list nano has-scrollbar">
									<div class="content scroll-y" tabindex="-1" style="right: -21px;">
									
										<!-- js로 추가 -->
										
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					<div class="step step2" style="display: none;">
					</div>
					
					<div class="step step3" style="display: none;">
					</div>
					
					<div class="step step4" style="display: none;">
					</div>
				</div>			
			</div>
		</div>
		
		
		<!-- 로그인 폼 -->
		<div class="ft_layer_popup popup_login ko" style="top: 231px; position: absolute; display: none;" name="popup_login">
			<div class="hd">
				<div class="title_area">
					<h4>CGV회원 로그인</h4>
<!-- 					<span class="sreader">빠른예매는 레이어로 서비스 되기 때문에 가상커서를 해지(Ctrl+Shift+F12)한 후 사용합니다.</span> -->
				</div>
					<a href="#" class="layer_close">닫기</a>
			</div>
			<div class="bd">
				<div class="login_form">
				<form action="../member/login" method="post">
					<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<input type="hidden"  id="location" name="loc" value="/" />
					<div class="input_wrap id">
						<label for="txtUserId" class="blind">아이디</label>
						<input name="username" id="txtUserId" maxlength="25">
					</div>
					<div class="input_wrap password">
						<label for="txtPassword" class="blind">비밀번호</label>
						<input name="password" id="txtPassword" maxlength="25" type="password">
					</div>
					<button type="submit" title="Login" class="btn_login">
						<span>로그인</span>
					</button>
				</form>
			
				</div>
				<div class="linkbar">
					<a href="../member/memberTerms" class="join_member">회원가입</a>
					<a href="../guest/guestReservation" class="join_guest">비회원 예매</a>
					<a href="#" class="id_find">아이디찾기</a>
					<a href="#" class="pw_find">비밀번호찾기</a>
				</div>
			</div>
		</div>
				
		<!-- CGV 할인쿠폰 카드 등록 -->
		<div id="layer_popup_coupon" class="ft_layer_popup f_popup" style="display: none;">
			<div class="hd">
				<div class="title_area"><h4>CGV 할인쿠폰 등록하기</h4></div>
			</div>
			<div class="bd">
				<p class="notice">소지하고 계신 CGV 할인쿠폰 번호 6자리를 입력해 주세요.</p>
				<div class="f_coupon" style="display: block;">
					<label for="cgvCoupon_input">CGV 할인쿠폰 번호 : </label>
					<input type="text" class="input_txt wht" maxlength="15" id="cgvCoupon_input" style="width: 250px;">
				</div>
				<div style="text-align: center; margin-bottom: 10px;">
					<a href="#" onclick="cgvCouponEnrollment(); return false;" class="btn btn_regist btn_size2" title="등록하기">
						<span>등록하기</span>
					</a>
					<a href="#none" onclick="window_close(); return false;" class="btn btn_white btn_close" title="닫기">
						<span>닫기</span>
					</a>
				</div>
			
			</div>
			<a href="#none" onclick="window_close(); return false;" class="pop_close" title="닫기"></a>
		</div>
		<!-- CGV 할인쿠폰 카드 등록 END -->
		
		<!-- CGV 기프트 카드 등록 -->
		<div id="layer_popup_giftcon" class="ft_layer_popup f_popup" style="display: none;">
			<div class="hd">
				<div class="title_area"><h4>CGV 기프트카드 등록하기</h4></div>
			</div>
			<div class="bd">
				<p class="notice">CGV 기프트카드를 등록하시면 온/오프라인에서 모두 편리하게 이용 하실수 있습니다.</p>
				<div class="f_card innerCon" style="display: block;">
					<p class="inputCon cardNum">
						<label for="f_cardNo">카드번호</label>
						<input id="f_cardNo" type="text" class="input_txt" maxlength="4"> -
						<input type="password" class="input_txt" maxlength="4" > -
						<input type="password" class="input_txt" maxlength="4" > -
						<input type="text" class="input_txt" maxlength="4" > 
					</p>
					<p class="inputCon cardPw">
						<label for="f_cardPw">비밀번호</label>
						<input id="f_cardPw" type="password" class="input_txt" maxlength="6" placeholder="스크래치번호">
					</p>
				</div>
		
				<div id="movieMoneyNT" style="margin-bottom: 20px; display: block;">
					<img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/popup/image_cgvticket.png" alt="CGV영화관람권 비밀번호 스크래치 부분을 동전 등으로 긁으면 비밀번호가 나타납니다.">
						
					<ul class="info">
						<li>
							<div class="title">이용안내</div>
							<div class="text">
								CGV 영화관람권 <em>비밀번호</em>를 입력해주세요.<br>
								CGV GOLD CLASS 이용권 <em>비밀번호</em>를 등록해주세요.<br>
								CGV온라인(홈페이지/모바일)에서 등록하신 관람권은 홈페이지/모바일예매에<br>
								한하여 사용할 수 있으며, CGV 현장 매표소에서는 사용할 수 없습니다.<br> 
								CGV 영화 관람권은 일반 인터넷 사이트를 포함한 시중에서 임의로 매매될 수<br>
								없으며 반드시 CGV를 통해서만 구입하실 수 있습니다.
							</div>
								
						</li>
					</ul>
				</div>
				<div style="text-align: center; margin-bottom: 10px;">
					<a href="#none" onclick="giftCardEnrollment(); return false;" class="btn btn_regist btn_size2" title="등록하기">
						<span>등록하기</span>
					</a>
					<a href="#none" onclick="window_close(); return false;" class="btn btn_white btn_close" title="닫기">
						<span>닫기</span>
					</a>
				</div>
			
			</div>
			<a href="#none" onclick="window_close(); return false;" class="pop_close" title="닫기"></a>
		</div>
		<!-- End CGV 기프트 카드 등록  -->
		
		
		
		<!-- url : ../reservation/seatReservation -->
		<form action="" id="data-from" method="post">
			<input type="hidden" id="movieNum" name="movieNum" value="">
			<input type="hidden" id="movieTimeNum" name="movieTimeNum" value="">
			<input type="hidden" id="cinemaName" name="cinemaName" value="">
			<input type="hidden" id="theaterName" name="theaterName" value="">
			<input type="hidden" id="filmType" name="filmType" value="">
			
			<input type="hidden" id="seatCount" name="seatCount" value="">
			<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" id="cinemaNum" value="" />
			
			<input type="hidden" id="sDate" value="">
		</form>
		
		
		
		<!-- 선택내용 출력,좌선선택 페이지로 이동버튼 출력부분 -->
		<div class="ticket_tnb">
			<div id="ticket_tnb" class="tnb_container ">    
				<div class="tnb step1">  
					<a class="btn-left" href="#" onclick="return false;" title="영화선택" style="display: none;">이전단계로 이동</a>
				
					<div class="info movie">
						<span class="movie_poster">
							<img id="select_image" src="" alt="포스터" style="display: none;"> 			<!-- display: inline; -->
						</span>
						<div class="row movie_title colspan2" style="display: none;">		 <!-- style="display: block;" -->
							<span class="data letter-spacing-min ellipsis-line2">
								<a id="select_title" href="#" target="_blank" title=""></a>
							</span>
						</div>
						<div class="row movie_type" style="display: none;"> 						<!-- style="display: block;" -->
							<span id="select_movieType" class="data ellipsis-line1" title="2D"></span>
						</div>
						<div class="row movie_rating" style="display: none;"> 					<!-- style="display: block;" -->
							<span id="select_ageLimit" class="data" title="12세 관람가">12세 관람가</span>
						</div>
						<div class="placeholder" title="영화선택"></div> <!-- style="display: none;" -->
					</div>
					
					
					
					<div class="info theater">
						<div class="row name" style="display: none;"> <!-- style="display: block;" -->
							<span class="header">극장</span>
							<span class="data letter-spacing-min ellipsis-line1"><a id="select_cinema" href="#" target="_blank" title=""> </a></span>
						</div>
						<div class="row date" style="display: none;" > <!-- style="display: block;" -->
 							<span class="header">일시</span>
							<span id="select_day" class="data" title=""></span>
						</div>
						<div class="row screen" style="display: none;"> <!-- style="display: block;" -->
							<span class="header">상영관</span>
							<span id="select_theater" class="data" title=""></span>
						</div>
						<div class="row number" style="display: none;"> <!-- style="display: block;" -->
							<span class="header">인원</span>
							<span class="data"></span>
						</div>
						<div class="placeholder" title="극장선택" ></div> <!-- style="display: none;" -->
					</div>
					
					
					<div class="info seat" style="display: none;">
						<div class="row seat_name" style="height: 20px;">
							<span class="header">좌석명</span>
							<span id="select_seat_grade" class="data" title=""></span>
						</div>
						<div class="row seat_no colspan3">
							<span class="header">좌석번호</span>
							<span id="select_Seat" class="data ellipsis-line3" title=""></span>
						</div>
						<div class="placeholder" title="좌석선택" style="display: none;"></div>
					</div>
					
					
					<div class="info payment-ticket" style="width: 155px; display: none;">
						<div class="row payment-adult" style="display: none;">
							<span class="header">일반</span>
							<span class="data"><span class="price"></span></span>
						</div>
						<div class="row payment-youth" style="display: none;">
							<span class="header">청소년</span>
							<span class="data"><span class="price"></span></span>
						</div>
						<div class="row payment-special" style="display: none;">
							<span class="header">우대</span>
							<span class="data"><span class="price"></span></span>
						</div>
						<div class="row payment-final" style="display: none;">
							<span class="header">총금액</span>
							<span class="data"><span class="price" title=""></span><span class="won">원</span></span>
						<span id="priceMapInfoIco" style="position: absolute; right: -17px; margin-top: 3px; cursor: pointer;"><img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/step2/ico_circle_14.png" height="14" width="14" alt="mappingIco"></span><div id="priceMappingContainer" style="display: none; position: absolute; right: -80px; z-index: 100; width: 150px; height: auto; padding: 10px; background: rgb(51, 51, 51); bottom: 115px;"><span class="typeNm" style="display:inline-block; width:40px;">일반</span> : PRIME X 2<br></div></div>
					</div>
					
					
					
					<div class="info path">
						<div class="row colspan4">
							<span class="path-step2" title="좌석선택">&nbsp;</span>
							<span class="path-step3" title="결제">&nbsp;</span>
						</div>
					</div>
					<a class="btn-right" id="tnb_step_btn_right" title="좌석선택"></a>
				</div>
			</div>
		</div>
		
		
		


		<c:import url="../template/footer.jsp"></c:import>
		<c:import url="../template/sidebar.jsp"></c:import>
	</div>


<script type="text/javascript" src="../js/movie/movieReservation.js"></script>
<script type="text/javascript">


    var list = [];
    <c:forEach items="${cinemaList}" var="vo">
       var cinemaVO = {
    	     num : `${vo.num}`,
             name: `${vo.name}`,
             local:	`${vo.local}`
               
       };
       
       list.push(cinemaVO);   
    </c:forEach>

	for(i=0;i<list.length;i++){
		$(".theater-area-list > ul > li").each(function(){
			if(list[i].local == $(this).data("local")){
				$(this).find(".content").append('<li class="" data-theater="'+ list[i].name+'" data-num="'+ list[i].num+'">'
						+ '<a href="#" onclick="return false;">'
						+ list[i].name
						+ '<span class="sreader"></span></a></li>');

				//지역마다 극장 개수  출력
				var pre = $(this).data("index");
				pre += 1;
				$(this).data("index",pre);
				
				var next = $(this).data("index");
				$(this).find(".count").text("("+$(this).data("index")+")");
			}
			
		});
	}

	var selectedMovieNum = `${selectedMovieNum}`;
	if(selectedMovieNum != 0){
		movieNum = selectedMovieNum;
		//선택한 영화에 대한 나머지 정보값들 조회
		ajaxLoad();

		//선택한 영화에 대해 css적용
		movieSort(movieNum);
	}

	
	var data;
	var memberId = `${memberVO.username}`;
	var beMemberVO = `${beMemberVO}`;
	
	var guestVO = {
		reservationNum : `${beMemberVO.reservationNum}`,
		birth : `${beMemberVO.birth}`,
		phone : `${beMemberVO.phone}`,
		pwd : `${beMemberVO.pwd}`,
		_csrf : $("#_csrf").val()
	}

	//결제완료 페이지로 이동
	$(".tnb_container").on("click",".tnb.step3 .btn-right",function(){
		//결제 작업을 위한 값 - 이니시스 
		
		if(memberId != ''){
			data = {
				tel : `${memberVO.phone}`,
				email : `${memberVO.email}`,
				name : `${memberVO.username}`,
				//amount : lastPrice
				amount : '100'
			}
		}else if(beMemberVO != ''){
			data = {
				tel : `${beMemberVO.phone}`,
				email : 'cgv@naver.com',
				name : '비회원',
				//amount : lastPrice
				amount : '100'
			}
		}
		

		if(lastPrice != 0){
			//이니시스 실행
			payment_inicis(data);
		}else{
			//결제 없이 바로 예매 - 좌석예매 진행
			reservation_save(1);
		}
		
	});


</script>
</body>
</html>





















 