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
<title>비회원 비밀번호찾기 &lt; 비회원예매 | 영화 그 이상의 감동. CGV</title>
</head>
<body>

	<div class="root">
		<!-- 헤더 -------------------------------------------------------------------------------------->
		<c:import url="../../template/header.jsp"></c:import>
		<!-- 컨테이너 -------------------------------------------------------------------------------------->
		<div class="container" style="height: 1000px;">
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
						<li><a class="lo" href="./reservationInfo">비회원 예매확인</a></li>
					</ul>


					<div class="guest_guide">
						<div class="guest_guide-box">
							<h3>개인정보(휴대폰번호,법정생년월일,비밀번호) 입력</h3>
							<p>개인정보를 잘못 입력하시면 예매내역 확인/취소 및 티켓 발권이 어려울 수 있으니, 입력하신 정보를 다시 한번 확인해주시기 바랍니다.</p>
							<div class="guest-box">
								<div class="guest-chk">
									<strong class="g-title">개인정보 입력</strong>
									
									
									
									<form action="./guestSession" method="post" enctype="" class="guest-form"	style="width: 858px; height: 380px;">
										<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<table style="width: 100%;">
											<caption>모든 항목은 필수 입력사항입니다.</caption>
											
											<tr class="tr-box">
												<th style="border-top: none;">법정생년월일</th>
												<td style="border-top: none;">
													<input type="text" name="birth" class="input-box birthday" maxlength="6"
														onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
													<span style="font-size: 20px;">
													- 
													<input type="text" class="input-box birth" maxlength="1" style="width: 10px;"
														onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">******
													</span>
												</td>
											</tr>
											
											
											<tr class="tr-box phone">
												<th>휴대폰번호</th>
												<td>
													<input type="hidden" id="phone" name="phone" value="">
													
													<select class="input-box" id="phone1">
														<option>010</option>
														<option>011</option>
														<option>016</option>
														<option>017</option>
														<option>018</option>
														<option>019</option>
													</select> 
													- 
													<input type="text" id="phone2" class="input-box phone-front" style="width: 75px;" maxlength="4"
														onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
													- 
													<input type="text" id="phone3" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
														class="input-box phone-back" style="width: 75px;" maxlength="4">
													<button type="button" id="btnCertification" class="num-chk">인증번호 받기</button>
												</td>
												<div class="countdown">카운트다운</div>
											</tr>
											
											
											<tr class="tr-box">
												<th>인증번호(6자리)</th>
												<td>
													<input type="text" id="certificationNum" class="input-box chk-num" maxlength="6"
														onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
													<input type="button" id="btnCertificationCheck" value="인증확인" class="num-chk">
												</td>
											</tr>
											
											
											<tr class="tr-box">
												<th>비밀번호(4자리)</th>
												<td>
													<input type="password" class="input-box pwd" maxlength="4"
														onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
												</td>
											</tr>
											<tr class="tr-box">
												<th>비밀번호확인</th>
												<td>
													<input type="password" name="pwd" class="input-box pwd-chk" maxlength="4"
														onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
												</td>
											</tr>
										</table>
										<div style="display: flex; justify-content: center;">
											<button type="submit" class="red-btn">비회원 예매하기</button>
										</div>
									</form>
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
		//남은시간 띄우기
		var time = "<span></span>";
		var notice = "<span>인증번호 유효기간이 초과되었습니다. 인증번호를 다시 요청해주세요.</span>";


		
		//받은 인증번호를 담을 변수
		var certificationNum = "";
		var check = false;
		console.log("certificationNum : "+certificationNum);


		
		//인증번호 전송하기
		$("#btnCertification").click(function(){
			var phone1 = $("#phone1").val();
			var phone2 = $("#phone2").val();
			var phone3 = $("#phone3").val();

			if(phone2 == "" || phone3 ==""){
				alert("휴대폰 번호를 입력해 주세요");
			}else{
				var phoneNumber = phone1+""+phone2+""+phone3;
				$.ajax({
					url : './guestCertification',
					type : 'post',
					data : {
						phoneNumber : phoneNumber,
						_csrf : $("#_csrf").val()
					},
					success : function(result){
						if(result>0){
							alert("인증 메일이 전송되었습니다.");
							certificationNum = result;
							$("#phone").val(phoneNumber);
							
							console.log(certificationNum);
						}else{
							alert("인증 메일 전송 실패");
						}
					}
				});
			}
			
		});

		//인증 번호 체크
		$("#btnCertificationCheck").click(function(){
			if(certificationNum == ''){
				alert("인증이 필요합니다.");
			}else{
				if($("#certificationNum").val() == certificationNum){
					check = true;
					alert("인증되었습니다.");
				}else{
					alert("인증 번호가 다릅니다.");
				}
			}
			
		});
		




		
		//유효성 검사
		$(".red-btn").click(function(e) {
			if ($(".birthday").val() == '') {
				alert("법정생년월일(6자리)를 입력해주세요!");
				e.preventDefault();
			} else if ($(".bitrh").val() == '') {
				alert("생년월일을 똑바로 입력해주세요!");
				e.preventDefault();
				
			} else if ($(".phone-front").val() == '') {
				alert("핸드폰번호 앞자리를 입력해주세요!");
				e.preventDefault();

			} else if ($(".phone-back").val() == '') {
				alert("핸드폰번호 뒷자리를 입력해주세요!");
				e.preventDefault();

			} else if ($(".chk-num").val() == '') {
				alert("인증번호를 입력해주세요!");
				e.preventDefault();
				
			} else if ($(".pwd").val() == '') {
				alert("비밀번호를 입력해주세요!");
				e.preventDefault();
				
			} else if ($(".pwd-chk").val() == '') {
				alert("비밀번호확인을 입력해주세요!");
				e.preventDefault();
				
			} else if ($(".pwd").val() != $(".pwd-chk").val()) {
				alert("비밀번호확인이 일치하지 않습니다!");
				e.preventDefault();
			} else if(!check){
				alert("휴대폰 인증이 필요합니다.");
				e.preventDefault();
			}
		});
	</script>

</body>
</html>