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
	href="${pageContext.request.contextPath}/css/cinema/cinemaList.css"
	rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

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
						<li><a href="./cinemaList">극장</a></li>
						<li class="last">극장별 관람가격</li>
					</ul>
				</div>
			</div>

			<div class="contents">
				<h3>관람가격 안내</h3>

				<div class="movie-price">
					<!-- 검색 -->					
					<div class="search-div">
						<form action="./" method="get" enctype="">
							<!-- 지역 -->
							<select id="search-local">
								<option value="서울" selected="selected">서울</option>
								<option value="경기">경기</option>
								<option value="인천">인천</option>
								<option value="강원">강원</option>
							</select>
							<!-- 영화관 -->
							<select id="search-cinema">
								<!-- Ajax 결과 출력 -->
							</select>
						</form>
					</div>
					
					
					
					<div class="mp-section">
						<!-- 안내문 -->		
						<div id="div_infotit_box" class="mp_info" style="display: block;">
		                    <strong><span style="color:#008000"><span style="font-size:1.25em">Standard Zone 가격안내</span></span></strong><br>
							<br>
								모닝 시간대는 Zone별 관람가격 동일<br>
							<br>
							<span style="color:#b22222">Prime Zone</span>:Standard Zone 가격 + 1,000원<br>
							<span style="color:#ffd700">Economy Zone</span><span style="color:#ffff00">:</span>Standard Zone 가격 - 1,000원
		                </div>
		
						<div id="div_TheaterPrice_box">
							<!-- 테이블 생성 반복 -->
							<div class="mp_tablebox" style="display: flex;">
							
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


	<script type="text/javascript" src="../js/movie/movieList.js"></script>
	<script type="text/javascript" src="/js/template/common.js"></script>
	<script type="text/javascript">

		//초기 selectBox의 값 설정
		localSearchAjax('서울');
		
		//지역 클릭시 ajax호출
		$("#search-local").change(function(){
			var local = $(this).val();
			localSearchAjax(local);
		});
		
		//지역선택시 해당 지역의 영화관들 출력
		function localSearchAjax(local){
			$("#search-cinema").empty();
			$.ajax({
				url: './selectLocalCinemaNameList',
				type: 'get',
				data : {
					local : local
				},
				success : function(result){
					//console.log(result);
					for(i=0;i<result.length;i++){
						$("#search-cinema").append('<option class="cinemaOpt" value="'+ result[i].num +'">'+ result[i].name +'</option>');
					}
					//영화관에 맞는 TimePrice리스트 자동 설정
					var cinema = $("#search-cinema option:selected").val();
					cinemaTimePrieListAjax(cinema);
				} 
			});
		}

		//선택된 영화관에따른 TimePrice리스트 호출
		$("#search-cinema").change(function(){
			var cinema = $(this).val();
			cinemaTimePrieListAjax(cinema);
		});

		//TimePrice리스트 호출
		function cinemaTimePrieListAjax(cinema){
			//기존 리스트 초기화
			$(".mp_tablebox").empty();
			checkFilmType = 0;
			
			$.ajax({
				url: '../timePrice/timePriceCinemaList',
				type: 'get',
				data: {
					cinemaNum : cinema
				},
				success : function(result){
					sTimeList = [];
					makeTimePriceTable(result);
				}
				
			});

		}

		var checkFilmType = 0;
		var sTime = '';
		//timePrice테이블 생성
		function makeTimePriceTable(result){
			
			for(i=0;i<result.length;i++){
				var filmType = result[i].filmType;
				var time = result[i].etime;
				
				var commonPrice = addComma(result[i].commonPrice);
				var teenagerPrice = addComma(result[i].teenagerPrice);

				if(checkFilmType != filmType){
					checkFilmType = filmType;
					sTime = '06:00';
					//film 변경시 첫줄에 class추가
					
					var fir = "fir";
					
					var trHTML = makeTr(sTime,commonPrice,teenagerPrice,fir);
					
					var str = filmTypeForm(filmType);
					var tableHTML = makeTable(str,trHTML);
					$(".mp_tablebox").append(tableHTML);
				}else{
					var fir = "";
					var trHTML = makeTr(sTime,commonPrice,teenagerPrice,fir);
					$(".timePriceTable:last tbody").append(trHTML);
				}

				//앞에 값으로 sTime 설정후 다음에 넣은 sTime값 계산
				sTime = sTimeMake(time);

			}
		}

		//sTime생성
		function sTimeMake(eTime){
			var nextsTimeArr = eTime.split(":");
			var nextsTime = new Date(0,0,0,nextsTimeArr[0],nextsTimeArr[1],0);
			nextsTime.setMinutes(nextsTime.getMinutes()+1);
			
			var minute = nextsTime.getMinutes()+"";
			var hour = nextsTime.getHours()+"";

			if(nextsTimeArr[0] > 24){
				nextsTimeArr[0] = "0"+(nextsTimeArr[0]-24);
			}
			if(minute.length < 2){
				minute = "0"+minute;
			}
			if(hour.length < 2){
				if(hour == 0){
					hour = '24';
				}else{
					hour = "0"+hour;
				}
			}
			
			nextsTime = hour+":"+minute;
			
			return nextsTime;
		}
		

		

		//필름 타입 폼 변경
		function filmTypeForm(filmType){
			var filmTypeForm = "";
			switch(filmType){
			case 1 :
				filmTypeForm = '2D';
				break;
			case 2 :
				filmTypeForm = '3D'; 
				break;
			case 4 : 
				filmTypeForm = '4D';
				break;
			}
			return filmTypeForm;
		}



		function makeTr(time,commonPrice,teenagerPrice,fir){
			var trHTML = '	<tr class="'+fir+'">'
			+'		<td>' + time +'~</td>'
			+'		<td>'+ commonPrice +'</td>'		
			+'		<td>'+ teenagerPrice +'</td>';
			+'	</tr>'
			return trHTML;
		}
		
		function makeTable(str,trHTML){
// 			var tableHTML = '<div class="time-table">' 
// 				+'<strong>&nbsp;&nbsp;&nbsp;■ 일반('+ str +')</strong>'
// 				+'<table class="timePriceTable">'
// 				+'	<colgroup>'
// 				+'		<col style="width: 300px;">'
// 				+'		<col style="width: 85px;">'
// 				+'		<col style="width: 85px;">'
// 				+'	</colgroup>'
// 				+'	<tr class="time-tr">'
// 				+'		<th scope="row">시간대</th>'
// 				+'		<th scope="row">일반</th>'
// 				+'		<th scope="row">청소년</th>'
// 				+'	</tr>'	
// 				+ trHTML		
// 				+'</table>'
// 				+'</div>';

			var tableHTML = 
				'<div class="mp_table_item">'
				+'	<div class="mp_tit cls_price_class" style="float: left;">일반('+str+')</div>'
				+'	<div class="mp_table cls_price_class">'
				+'		<table class="timePriceTable" summary="일반(2D) 관람가격 정보 입니다.">'
				+'          <colgroup>'
				+'    			<col style="width:49%">'
				+'    			<col style="width:18%">'
				+'    			<col style="width:18%">'
				+'    		</colgroup>'
				+'			<thead>'
				+'				<tr>'
				+'					<th scope="row">시간대</th>'
				+'					<th scope="row">일반</th>'
				+'					<th scope="row">청소년</th>'
				+'				</tr>'
				+'			</thead>'
				+'			<tbody>'
				+ trHTML
				+'			</tbody>'
				+'		</table>'
				+'	</div>'
				+'</div>';

			return tableHTML;
		}
		

	</script>


</body>
</html>












