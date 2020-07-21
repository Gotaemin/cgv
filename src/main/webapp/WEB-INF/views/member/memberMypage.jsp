<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/bbs/bbsLayout.css" rel="stylesheet" type="text/css">
<link href="../css/layout.css" rel="stylesheet" type="text/css">
<link href="../css/member/memberMyPage.css" rel="stylesheet"
	type="text/css">
<script src="/js/template/common.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>

	<div class="root">
		<!-- 헤더 -------------------------------------------------------------------------------------->
		<c:import url="../template/header.jsp"></c:import>

		<!-- 컨테이너 -------------------------------------------------------------------------------------->

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
				<div class="sect-common">
					<div class="mycgv-info-wrap">
						<div class="sect-person-info">
							<div class="box-image">
								<span class="thumb-image"> <img alt=""
									src="/images/member/${memberVO.fileName}"> <span
									class="profile-mask"></span>
								</span>
							</div>
							<div class="box-contents">
								<div class="person-info1">
									<strong>${memberVO.name}님</strong> <em>&nbsp${memberVO.username}&nbsp</em>
									<span>&nbsp닉네임: ${memberVO.nick}&nbsp</span>
									<button id="go_edit_page" type="button" title="새창열림">수정</button>
								</div>
								<div class="person-info2">
									<p>전화번호 : ${memberVO.phone}</p>
									<p>생년월일 : ${memberVO.birth}</p>
									<p>E-mail : ${memberVO.email}</p>
								</div>
							</div>
						</div>


						<div class="sect-movie-info">
							<div class="col-my-coupon">
								<h3>MY COUPON</h3>
								<ul>
									<li><strong>CGV VIP에 도전하세요!</strong> <span></span></li>
									<li><strong>CGV 할인쿠폰</strong> <span><em>${couponNum}</em>
											개</span></li>
									<li><strong>영화관람권</strong> <span><em>0</em> 개</span></li>
								</ul>
							</div>
							<div class="col-my-movie">

								<div class="col-my-coupon">
									<h4>CJ ONE POINT</h4>
									<ul>
										<li><strong>CJ ONR 사용가능 포인트</strong> <span id="cjPoint"></span></li>
										<li><strong>VIP 선정 포인트</strong> <span><em>0</em> 점</span></li>
										<li><strong>VIP 까지</strong> <span><em>100</em> 점</span></li>
									</ul>
								</div>
							</div>
							<div class="col-favorite-theater">
								<div class="sect-favorite">
									<ul>
										<li><a href=""><span>1</span>CGV불광</a></li>
										<li><a href=""><span>2</span>CGV상봉</a></li>
										<li><a href=""><span>3</span>CGV홍대</a></li>
										<li><a href=""><span>4</span></a></li>
										<li><a href=""><span>5</span></a></li>
									</ul>
									<button class="setting">
										자주가는 CGV<br>설정하기
									</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div>
					<div class="col_content">
						<!----------------- contents aside -->
						<div class="col_aside">
							<div class="snb">
								<ul>
									<li class="on"><a href="#">MY CGV HOME<i></i></a></li>
									<li>
										<a href="./memberUpdate?username=${sessionScope.memberVO.username}">회원정보 수정<i></i></a>
									</li>
									<li><a href="#" id="memberDelete">회원 탈퇴<i></i></a></li>
									<li><a href="">예매 영화 관리<i></i></a></li>
									<li><a href="../review/reviewList"
										style="background-color: black; color: white;">내가 본 영화<i></i></a></li>
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
							<div class="box-polaroid">
								<div class="inner-box"
									style="background: url(../images/myPage/polaroid/icon_preegg.png) no-repeat 50% 16px;">
									<a href="" class="inner-box-a">
										<h3>기대되는 영화</h3> <span>보고싶은 영화들을 미리<br>담아두고 싶다면?
									</span>
									</a>
								</div>
								<p></p>
								<div class="inner-box"
									style="background: url(../images/myPage/polaroid/icon_watched.png) no-repeat 50% 16px;">
									<a href="../review/reviewList" class="inner-box-a">
										<h3>내가 본 영화</h3> <span>관람한 영화들을 한번에<br>모아보고 싶다면?
									</span>
									</a>
								</div>
								<p></p>
								<div class="inner-box"
									style="background: url(../images/myPage/polaroid/icon_mvdiary.png) no-repeat 50% 16px;">
									<a href="../review/reviewDiary" class="inner-box-a">
										<h3>무비 다이어리</h3> <span>관람 후 내 감상평을 적어<br>추억하고 싶다면?
									</span>
									</a>
								</div>
								<p></p>
								<div class="inner-box"
									style="background: url(../images/myPage/polaroid/icon_photi.png) no-repeat 50% 16px;">
									<a href="javascript:void(0);" class="inner-box-a ticket11">
										<h3>포토티켓</h3> <span>단 하나뿐인 나만의<br>티켓을 간직하고 싶다면?
									</span>
									</a>
								</div>
							</div>
							<div>
								<div class="my-reserve-bar">
									<div>
										<h3>MY 예매내역</h3>
										<span>&nbsp1건</span> <a href="#" class="plus-btn">예매내역 더보기</a>
									</div>
									<span>예매번호로만 티켓을 찾을 수 있으니 반드시 확인 부탁드립니다.</span>
								</div>
								<div class="my-movie-reserve">
									<div class="reserve-ticket">
									<!-- 반복 -->
									
									<c:forEach var="reservationVO" items="${myReservationList}">
										<div class="el-box">
												<div class="rt-info1">
													<em>예매번호</em><br>
													<strong style="color:red; font-weight: blod;">${reservationVO.num}</strong><br> 
													<span class="reservationDate">(${reservationVO.createAt})</span><br>
												</div>
												<div class="rt-info2">
													<div class="rt-info2-div1">
														<img alt="영화 포스터" src="/images/movie/movieList/filmCover/${reservationVO.movieImageVO.fileName}" class="poster">

														<ul class="rt-ul">
															<li style="padding-bottom: 10px;"><strong>${reservationVO.movieInfoVO.title}</strong></li>
															<li>관람극장 <strong>CGV ${reservationVO.cinemaName}</strong><a href="">[극장정보]</a></li>
															<li>관람일시 <strong class="runningDate">${reservationVO.movieTimeVO.screenDate}</strong><strong> ${reservationVO.movieTimeVO.screenTime}</strong></li>
															<li>관람좌석 <strong>${reservationVO.seats}</strong></li>
														</ul>
													</div>
													<div class="rt-info2-div2">
														<dl>
															<dd>총 결제금액&nbsp</dd>
															<dt>${reservationVO.totalPrice}</dt>
														</dl>
														<div>
															<button class="message-reserve" type="button">
																<span>문자보내기</span>
															</button>
															<button data-cancle="${reservationVO.num}" class="cancle-reserve" type="button">
																<span>예매취소</span>
															</button>
														</div>
													</div>
												</div>
											</div>
									</c:forEach>
									</div>

								</div>

							</div>
						</div>

					</div>
				</div>
			</div>
		</div>


		<!-- 푸터 -------------------------------------------------------------------------------------->
		<c:import url="../template/footer.jsp"></c:import>

		<!-- 사이드바 ---------------------------------------------------------------------------------------------->
		<c:import url="../template/sidebar.jsp"></c:import>
	</div>
	<script type="text/javascript" src="/js/template/common.js"></script>
	<script type="text/javascript">
		
		$("#cjPoint").html(addComma("<em>${cjPoint}</em> 점"));
		
		//금액에 콤마 적용
		$(".rt-info2-div2 dl dt").each(function(){
			$(this).text(addComma($(this).text())+"원");
		});

		//해당 날짜 formData 변경 및 요일 추가 
		$(".reservationDate").each(function(){
			var str = $(this).text();
			str = str.replace(/-/gi, ".");

			$(this).text(str);
		});

		$(".runningDate").each(function(){
			var str = $(this).text();
			var week = weekFind(str);
			str = str.replace(/-/gi, ".");

			$(this).text(str+"("+ week +")");
		});


	
		//회원 탈퇴 알림창
		$("#memberDelete").click(function() {
			var check = confirm("회원 탈퇴하시겠습니까?");
			if (check) {
				location.href = "./memberDelete?username=${memberVO.username}";
			}
		});

		//정보 수정 팝업창
		$("#go_edit_page").click(function() {
			window.open("./edit", "마이페이지 - 정보수정",	"width = 700, height = 565, top=100, left 200, locations = no");
		});

		//정보 수정 팝업창 callback (redirect 위함)
		function editCallback(result) {
			if (result > 0) {
				location.href = "./myPage";
			}
		}

		//자주가는 CGV 팝업창
		/* $("#go_edit_page").click(function() {
				window .open("memberPopUpEdit.jsp", "마이페이지 - 정보수정", "width = 700, height = 565, top=100, left 200, locations = no");
			}); */

		//안됨빡친다
		$(".cancle-reserve").click(function() {
			if (confirm("예매를 취소하시겠습니까? \n\n※인터넷 예매 취소는 상영시간 20분 전까지 가능하며, \n예매 가능은 상영시간 30분 전까지 가능합니다.")) {
				//console.log($(this).data("cancle"));
				var reservationNum = $(this).data("cancle");
				//reservationCancle
				$.ajax({
					url : '../reservation/reservationCancle',
					type : 'get',
					data : {
						num : reservationNum
					},
					success :function(result){
						console.log(result);
						if(result>0){
							alert("예매가 취소 되었습니다.");
							location.reload();
						}else{
							alert("예매 취소 실패");
						}
					} 
				});
			}
		});

		$(".ticket11").click(function(){
			alert("준비중 입니다.");
		});
	</script>



</body>
</html>