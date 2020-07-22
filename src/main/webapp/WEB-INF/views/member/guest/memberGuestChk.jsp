<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/css/layout.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/css/member/memberGuest.css"
	rel="stylesheet" type="text/css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<!-- 비회원 예매확인 -->
<title>비회원예매확인 &lt;  회원서비스 | 영화 그 이상의 감동. CGV</title>
</head>
<body>

	<div class="root">
		<!-- 헤더 -------------------------------------------------------------------------------------->
		<c:import url="../../template/header.jsp"></c:import>
		<!-- 컨테이너 -------------------------------------------------------------------------------------->
		<div class="container" style="height: 900px;">
			<div class="c_nav">
				<div class="nav_linemap">
					<ul>
						<li><a href="../"> <img alt="go to Home"
								src="../images/login/btn_home.png">
						</a></li>
						<li><a href="../member/login">회원 서비스</a></li>
						<li class="last">로그인</li>
					</ul>
				</div>
			</div>

			<div class="contents">
				<div class="wrap_login">
					<ul class="tab_menu_round">
						<li><a class="lo" href="../member/login">로그인</a></li>
						<li><a href="./reservationInfo">비회원 예매확인</a></li>
					</ul>


					<div class="guest_guide">
						<div class="guest_guide-box">
							<h3>비회원 예매 확인</h3>
							<p>비회원으로 예매하신 고객님은 개인정보(법정생년월일, 휴대폰 번호, 비밀번호(4자리)를 입력해 주세요.</p>
							<div class="guest-box">
								<div class="guest-chk">
									<strong class="g-title">비회원 예매확인</strong>
									<form class="guest-form" id="form-Data">
										<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<table>
											<caption>모든 항목은 필수 입력사항입니다.</caption>
											<tr class="tr-box">
												<th>법정생년월일<br>(6자리)
												</th>
												<td><input name="birth" id="birth" type="text" class="input-box birthday"
													maxlength="6"
													onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
													<span style="font-size: 20px;">- ******</span></td>
											</tr>
											<tr class="tr-box phone">
												<th>휴대폰번호</th>
												<td>
													<select id="phone1" class="input-box">
														<option selected="selected">010</option>
														<option>011</option>
														<option>016</option>
														<option>017</option>
														<option>018</option>
														<option>019</option>
													</select> 
													- 
													<input id="phone2" type="text" class="input-box phone-front" style="width: 75px;" maxlength="4"
														onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
													- 
													<input id="phone3" type="text" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
														class="input-box phone-back" style="width: 75px;" maxlength="4">
												</td>
											</tr>
											<tr class="tr-box">
												<th>비밀번호(4자리)</th>
												<td>
													<input name="pwd" id="pwd" type="password" class="input-box pwd" maxlength="4"
														onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
												</td>
											</tr>
										</table>
										<div style="display: flex; justify-content: center;">
											<button id="btnSubmit" type="button" class="red-btn">비회원 예매확인</button>
										</div>
									</form>
								</div>


								<div class="guest-msg" style="border-left: 1px solid #e8e8dd;">
									<strong class="g-title">비회원예매 비밀번호 찾기</strong>
									<div class="guest-form">
										<p>비회원 예매 시, 입력한 휴대폰번호로 SMS인증을 하면 비회원 예매 비밀번호를 찾으실수 있습니다.</p>
										<button onclick="location.href='./memberGuestPwd'" class="">휴대폰 SMS인증으로 찾기</button>
									</div>
								</div>
							</div>
						</div>

						<div class="coupon-notice">
							<div style="background-color: #f9f7ec;">
								<em class="coupon-em">비회원 예매 시 참고하세요!</em>
								<div>
									<ul class="coupon-notice-ul">
										<li>1. 상기 정보 수집에 동의하지 않을 경우, 비회원 예매 서비스를 이용하실 수 없습니다.</li>
										<li>2. 비회원 예매 시 청소년 관람불가 영화는 예매가 제한됩니다.</li>
										<li>3. 비회원 에매 결제수단은 신용카드만 가능하며 모든 제휴상품권, 쿠폰, 영화예매권 등의 사용은
											회원 예매 서비스 이용 시 가능합니다.</li>
										<li>4. 모바일과 ARS에서는 취소가 불가능하며, 홈페이지를 이용하여 입력하신 로그인 정보로 취소
											처리하실 수 있습니다.</li>
										<li>5. 비회원 예매 및 비회원 예매 확인/취소 메뉴만 이용 가능합니다. 이 외에 커뮤니티, 댓글,
											인정 등의 서비스는 회원 가입 후 이용 가능합니다.</li>
										<li>6. 문의사항은 CGV 고객센터(1544-1122)로 문의해 주시기 바랍니다.</li>
										<li>- 운영시간 : 월~금 09:00 ~ 18:00 (이 외 시간은 자동 응답 안내 가능)</li>
									</ul>
								</div>
							</div>
						</div>

					</div>



				</div>
			</div>

		</div>



		<!-- 푸터 -------------------------------------------------------------------------------------->
		<c:import url="../../template/footer.jsp"></c:import>



		<!-- 사이드바 ---------------------------------------------------------------------------------------------->
		<c:import url="../../template/sidebar.jsp"></c:import>
	</div>

	<!-- 스크립트 -->
	<script type="text/javascript">

		//비회원 예매 확인버튼 클릭
		function btnSubmit(){
			//전화번호 합치기 
			var phoneStr = $("#phone1").val()+""+$("#phone2").val()+""+$("#phone3").val();
			
			var formData = {
				birth : $("#birth").val(),
				phone : phoneStr,
				pwd : $("#pwd").val(),
				_csrf : $("#_csrf").val()
			}

			$.ajax({
				url: './guestCheck',
				type : 'post',
				data : formData,
				success : function(reservationNum){
					if(reservationNum > 0){
						location.href="./reservationSelect?reservationNum="+reservationNum;
					}else{
						alert("일치하는 정보가 없습니다.");
					}
				}
			});
		};





	
		//유효성 검사
		$(".red-btn").click(function(e) {
			if ($(".birthday").val() == '') {
				alert("법정생년월일(6자리)를 입력해주세요!");
				e.preventDefault();
			} else if ($(".phone-front").val() == '') {
				alert("핸드폰번호 앞자리를 입력해주세요!");
				e.preventDefault();
			} else if ($(".phone-back").val() == '') {
				alert("핸드폰번호 뒷자리를 입력해주세요!");
				e.preventDefault();
			} else if ($(".pwd").val() == '') {
				alert("비밀번호를 입력해주세요!");
				e.preventDefault();
			}else{
				btnSubmit();
			}
		});
	</script>

</body>
</html>