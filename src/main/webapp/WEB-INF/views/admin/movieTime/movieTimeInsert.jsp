<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<c:import url="../template/head.jsp"></c:import>
	<c:import url="../template/datepicker.jsp"></c:import>
	<c:import url="../template/timepicker.jsp"></c:import>
	<link rel="stylesheet" href="/css/admin/cinema/timetablejs.css">
	<style type="text/css">
		.timetable_custom {
			max-width : 1444px;
		}
		
		.timetable>section>header {
			font-size: smaller;
		}
	
	</style>
	<script type="text/javascript" src="/js/template/timetable.js"></script>
	
	
    <link rel="stylesheet" href="/css/admin/movieTime/insert.css">
</head>
<body class="sb-nav-fixed">

	<c:import url="../template/header.jsp"></c:import>
	
	<!-- 사이드바 -->
	<div id="layoutSidenav">
		<c:import url="../template/sidenav.jsp"></c:import>
		
		<!-- 내용 -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid" style=" padding: 40px;">
					<h1>Movie Time Insert</h1>
					<p>영화 상영시간 등록</p>
					
					
					
					<!-- Tab -->
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#selectMovie">영화 선택</a></li>
						<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#selectDatetime">날짜 및 시간 선택</a></li>
					</ul>

					<!-- Tab 내부 내용 -->
					<div class="tab-content">
						<div class="tab-content">
							
							<!-- 영화 선택 -->
							<div id="selectMovie" class="container tab-pane active">
								
								<!-- 검색창 -->
								<div class="input-group">
									<select id="searchTag" name="searchTag">
									    <option value="title">영화명</option>
									</select>
									
									<input id="searchTxt" class="form-control" type="text" placeholder="검색어를 입력해주세요." aria-label="Search" aria-describedby="basic-addon2" />
									<div class="input-group-append">
										<button id="searchBtn" class="btn btn-primary" type="button">
											<i class="fas fa-search"></i>
										</button>
									</div>
								</div>
								
								<!-- 영화리스트 출력 -->
								<div id="movieListDiv" style="margin: 10px;">
								</div>
								
								<!-- pager -->
								<div class="pager">
									<ul class="pagination">
										<c:if test="${pager.curBlock gt 1}">
											<li class="page-item"><a class="page-link" href="./insert?num=${theaterVO.num}&cinemaNum=${theaterVO.cinemaNum}&curPage=${pager.startNum - 1}&kind=${pager.kind}&search=${pager.search}">이전</a></li>
										</c:if>
										<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="i">
											<li class="page-item"><a class="page-link" href="./insert?num=${theaterVO.num}&cinemaNum=${theaterVO.cinemaNum}&curPage=${i}&kind=${pager.kind}&search=${pager.search}">${i}</a></li>
										</c:forEach>
										<c:if test="${pager.curBlock lt pager.totalBlock}">
											<li class="page-item"><a class="page-link" href="./insert?num=${theaterVO.num}&cinemaNum=${theaterVO.cinemaNum}&curPage=${pager.lastNum + 1}&kind=${pager.kind}&search=${pager.search}">다음</a></li>
										</c:if>
									</ul>
								</div>
							</div>
							
							<!-- 날짜 및 시간 선택 -->
							<div id="selectDatetime" class="container tab-pane fade">
							
								<div class="container">
									
									<div id="movieTimeInsert">
										<input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<input id="cinemaNum" type="hidden" value="${theaterVO.cinemaNum}" disabled/> 
										<input id="movieNum" type="hidden" name="movieNum"/>
										<input id="theaterNum" type="hidden" name="theaterNum" value="${theaterVO.num}"/>
										<input id="remainSeat" type="hidden" name="remainSeat" value="${theaterVO.seatCount}"/>
										
										<div class="form-group">
											<label for="title">선택된 영화 :</label>
											<input id="movieTitle" class="form-control" type="text" disabled>
										</div>
										<div class="form-group">
											<label for="selectedFilm">상영 필름 종류 선택:</label>
											<select id=selectedFilm name="selectedFilm"></select>
										</div>
										<div class="form-group">
											<label for="screenDate">날짜 선택 :</label>
											<input id="datepicker" class="form-control" type="text" name="screenDate">
											<!-- <div class="input-group-text"><i class="fa fa-calendar"></i></div> -->
										</div>
										<div class="form-group">
											<label for="screenTime">시간 선택 :</label>
											<input id="timepicker" class="form-control" type="text" name="screenTime" />
										</div>
										<div class="text-center">
											<button id="submitBtn" type="button" class="btn btn-primary">영화 상영시간 등록</button>
										</div>
									</div>
								</div>
							</div>
							<div class="timetable timetable_custom"></div>
						</div>
					</div>
					<!-- Tab 내부 내용 끝-->
				</div>
			</main>
			<c:import url="../template/footer.jsp"></c:import>
		</div>
	</div>
	<c:import url="../template/scripts.jsp"></c:import>
	<script type="text/javascript">

		//console.log(`${movieInfoList}`);
	
		// 영화리스트 값 가져오기
		function getMovieInfoList() {
			var movieInfoList=[];
			<c:forEach items="${movieInfoList}" var="vo">
				
				var movieInfoVO = {
					num : `${vo.num}`,
					title : `${vo.title}`,
					titleEng : `${vo.titleEng}`,
					runtime : `${vo.runtime}`,
					director : `${vo.director}`,
					actor : `${vo.actor}`,
					ganre : `${vo.ganre}`,
					ageLimit : `${vo.ageLimit}`,
					country : `${vo.country}`,
					openDate : `${vo.openDate}`,
					contents : `${vo.contents}`,
					visitor : `${vo.visitor}`,
					rate : `${vo.rate}`,
					errRate : `${vo.errRate}`,
					fileName : `${vo.fileName}`
				}

				console.log(movieInfoVO.fileName);

				movieInfoList.push(movieInfoVO);
			</c:forEach>

			return movieInfoList;
		}

		// 영화리스트를 보여주기 위한 변수(perrow)값 가져오기 
		function getPerRow() {

			return ${perRow};
		}

		// 영화리스트와 변수값으로 영화리스트 보여주기
		function showMovieInfoList(movieInfoList, perRow) {

			var html = "";
			for(var i=0; i<movieInfoList.length; i++) {

 				var vo = movieInfoList[i];
 				if(i%perRow === 0) {
					html += `<div class="row">`;
				}

				html += `<div id="`+vo.num+`" class="col-sm-2 div-btn" data-title="`+vo.title+`">` +
							`<div class="card">`+
								`<img class="card-img-top" style="width:100%;" src="/images/movie/movieList/filmCover/`+vo.fileName+`"/>`+
								`<div class="card-header">` +
									`<p class="card-title"><strong>`+vo.title+`</strong></p>`+
									`<p class="card-text" style="font-size:small;">상영시간: `+vo.runtime+`분  <br> 예매율:`+vo.rate+`% </p>` +
								`</div>` +
							`</div>` +
						`</div>`
				
				if(i%perRow === perRow-1) {
					html += `</div>`;
				}
			}

			$("#movieListDiv").prepend(html);
		}

		// 각 영화div에 click event 추가 후, 선택된 movie정보 setting
		function addClickEventToMovieInfoList() {

			$("#movieListDiv").on("click", ".div-btn", function(event) { 
				event.preventDefault();
				console.log($(this).attr("id"));
				alert("영화 선택 완료 : "+$(this).data("title"));
				
				// movie정보 setting
				$("#movieNum").val($(this).attr("id"));
				$("#movieTitle").val($(this).data("title"));
				
				// 다음 페이지로 개행
				$('.nav-tabs a[href="#selectDatetime"]').tab('show');
			});
		}

		// 검색창에 click event 추가
		function addClickEventToMovieSearchBtn() {

			$("#searchBtn").click(function() {

				var searchTag = $("#searchTag").val();
				var searchTxt = $("#searchTxt").val();
				var theaterNum = $("#theaterNum").val();
				location.href = "./insert?theaterNum="+theaterNum+"curPage=&kind="+searchTag+"&search="+searchTxt;
			});
		}

		// 필름 종류 초기화
		function initSelectedFilm() {

			var filmType = ${theaterVO.filmType};

			if(filmType & 1) {
				$("#selectedFilm").append('<option value="1">2D</option>');
			}

			if(filmType & 2) {
				$("#selectedFilm").append('<option value="2">3D</option>');
			}
			
			if(filmType & 4) {
				$("#selectedFilm").append('<option value="4">4D</option>');
			}
		}
		
		// datepicker 초기화
		function initDatePicker() {

			var today = new Date();
			var year = today.getFullYear(); // 년도
			var month = today.getMonth() + 1;  // 월
			var date = today.getDate();  // 날짜

			if(month < 10) {
				month = "0" + month;
			}
			
			if(date < 10) {
				date = "0" + date;
			}

			<!-- 시작시 기본 날짜 설정은 value를 이용 -->
			$('#datepicker').val(year + '-' + month + '-' + date);
			
			$('#datepicker').datepicker({
			    format: "yyyy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
			    startDate: '0d',	//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
			    endDate: '+45d',	//달력에서 선택 할 수 있는 가장 느린 날짜. 이후로 선택 불가 ( d : 일 m : 달 y : 년 w : 주)
			    autoclose : true,	//사용자가 날짜를 클릭하면 자동 캘린더가 닫히는 옵션
			    calendarWeeks : false, //캘린더 옆에 몇 주차인지 보여주는 옵션 기본값 false 보여주려면 true
			    clearBtn : false, //날짜 선택한 값 초기화 해주는 버튼 보여주는 옵션 기본값 false 보여주려면 true
			    //datesDisabled : ['2019-06-24','2019-06-26'],//선택 불가능한 일 설정 하는 배열 위에 있는 format 과 형식이 같아야함.
			    //daysOfWeekDisabled : [0,6],	//선택 불가능한 요일 설정 0 : 일요일 ~ 6 : 토요일
			    //daysOfWeekHighlighted : [3], //강조 되어야 하는 요일 설정
			    disableTouchKeyboard : false,	//모바일에서 플러그인 작동 여부 기본값 false 가 작동 true가 작동 안함.
			    immediateUpdates: false,	//사용자가 보는 화면으로 바로바로 날짜를 변경할지 여부 기본값 :false 
			    multidate : false, //여러 날짜 선택할 수 있게 하는 옵션 기본값 :false 
			    multidateSeparator :",", //여러 날짜를 선택했을 때 사이에 나타나는 글짜 2019-05-01,2019-06-01
			    templates : {
			        leftArrow: '&laquo;',
			        rightArrow: '&raquo;'
			    }, //다음달 이전달로 넘어가는 화살표 모양 커스텀 마이징 
			    showWeekDays : true ,// 위에 요일 보여주는 옵션 기본값 : true
			    title: "영화 상영 날짜",	//캘린더 상단에 보여주는 타이틀
			    todayHighlight : true ,	//오늘 날짜에 하이라이팅 기능 기본값 :false 
			    toggleActive : true,	//이미 선택된 날짜 선택하면 기본값 : false인경우 그대로 유지 true인 경우 날짜 삭제
			    weekStart : 0 ,//달력 시작 요일 선택하는 것 기본값은 0인 일요일 
			    language : "ko"	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
			    
			});//datepicker end
		}

		// timepicker
		function initTimePicker() {
			$('#timepicker').wickedpicker({
		        now: "12:00", //hh:mm 24 hour format only, defaults to current time
		        twentyFour: true,  //Display 24 hour format, defaults to false
		        upArrow: 'wickedpicker__controls__control-up',  //The up arrow class selector to use, for custom CSS
		        downArrow: 'wickedpicker__controls__control-down', //The down arrow class selector to use, for custom CSS
		        close: 'wickedpicker__close', //The close class selector to use, for custom CSS
		        hoverState: 'hover-state', //The hover state class to use, for custom CSS
		        title: '영화 상영 시작 시간', //The Wickedpicker's title,
		        showSeconds: false, //Whether or not to show seconds,
		        timeSeparator: ':', // The string to put in between hours and minutes (and seconds)
		        secondsInterval: 1, //Change interval for seconds, defaults to 1,
		        minutesInterval: 5, //Change interval for minutes, defaults to 1
		        beforeShow: null, //A function to be called before the Wickedpicker is shown
		        afterShow: null, //A function to be called after the Wickedpicker is closed/hidden
		        show: null, //A function to be called when the Wickedpicker is shown
		        clearable: false, //Make the picker's input clearable (has clickable "x")
		    });
		}

		// timepicker addEventTimepicker
		function addEventTimepicker() {

			// 영화 겹치는 시간 있는지 확인
			
		}
		
		// submit 버튼 클릭시
		function addClickEventSubmitBtn() {

			$("#submitBtn").click(function() {

				if($("#movieTitle").val() == "") {
					alert("등록할 영화를 선택해주세요");
					$('.nav-tabs a[href="#selectMovie"]').tab('show');
					return;
				}

				var selectedFilm = $("#selectedFilm").val();
				switch(selectedFilm) {
				case "1": 
					selectedFilm = "2D";
					break;
				case "2":
					selectedFilm = "3D";
					break;
				case "4":
					selectedFilm = "4D";
					break;
				}
				
				var msg = "정말 등록하시겠습니까?\n\n" +
						"영화 이름 : " + $("#movieTitle").val() +"\n" +
						"필름 종류 : " + selectedFilm + "\n" +
						"상영 날짜 : " + $("#datepicker").val() +"\n" +
						"상영 시간 : " + $("#timepicker").val();

				var screenTimeSplit = $("#timepicker").val().split(" ");
				var screenTime = screenTimeSplit[0] + screenTimeSplit[1] + screenTimeSplit[2]

				if(!confirm(msg))
					return;

				// 보내기			
				$.post(
					"./insert", {
						_csrf : $("#_csrf").val(),
						movieNum : $("#movieNum").val(),
						theaterNum : $("#theaterNum").val(),
						screenDate : $("#datepicker").val(),
						screenTime : screenTime,
						remainSeat : $("#remainSeat").val(),
						selectedFilm : $("#selectedFilm").val()
					}, function(result) {
						if(result > 0) {
							alert("등록이 완료되었습니다");
							location.href = "admin/cinema/cinemaSelect?num="+$("#cinemaNum").val();
						} else {
							alert("등록 실패, 재등록해주세요");
						}
					});
			});
		}

		// timetable api
		function showTimetable() {

			var selectedDate = $("#datepicker").val();
			var timetable = new Timetable();
			timetable.setScope(6, 2); // optional, only whole hours between 0 and 23
			//timetable.useTwelveHour(); //optional, displays hours in 12 hour format (1:00PM)

			//timetable.addLocations(['Silent Disco', 'Nile', 'Len Room', 'Maas Room']);
			timetable.addLocations([selectedDate]);
			//timetable.addEvent('Frankadelic', 'Nile', new Date(2015,7,17,10,45), new Date(2015,7,17,12,30));

			var options = {
					  url: '#', // makes the event clickable
					  class: 'vip', // additional css class
					  data: { // each property will be added to the data-* attributes of the DOM node for this event
					    id: 4,
					    ticketType: 'VIP'
					  },
					  onClick: function(event, timetable, clickEvent) {} // custom click handler, which is passed the event object and full timetable as context  
					};

			//timetable.addEvent('Jam Session', 'Nile', new Date(2015,7,17,21,15), new Date(2015,7,17,23,30), options);
			console.log(timetable);
			
			var renderer = new Timetable.Renderer(timetable);
			renderer.draw('.timetable'); // any css selector
		}

		// main()
		$(function() {

			// 영화 등록 단계 관련
			var movieInfoList = getMovieInfoList();
			var perRow = getPerRow();
			showMovieInfoList(movieInfoList, perRow);
			addClickEventToMovieInfoList();
			addClickEventToMovieSearchBtn();
			
			// 날짜 시간 등록 단계 관련
			initSelectedFilm();
			initDatePicker();
			initTimePicker();

			// 등록 단계 관련
			addClickEventSubmitBtn();

			// 시간표 관련
			showTimetable();
		});
		
	</script>
</body>
</html>