<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<c:import url="../template/head.jsp"></c:import> 
	<c:import url="../template/datepicker.jsp"></c:import>
	
	<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
	<link rel="stylesheet" href="/css/admin/cinema/timetablejs.css">
	<link rel="stylesheet" href="/css/admin/cinema/demo.css">
	<title>관리자 페이지</title>
	<style type="text/css">
	.btn-mo {
	    border: none;
	    background-color: #e71a0f;
	    color: #fff;
	    font-weight: 500;
	    font-size: 16px;
	    line-height: 24px;
	    text-align: center;
	    border: 1px solid #e71a0f;
	    padding: .375rem .75rem;
	    border-radius: .25rem;
	}
	</style>
</head>

<body class="sb-nav-fixed">
	<c:import url="../template/header.jsp"></c:import>
	
	<!-- 사이드바 -->
	<div id="layoutSidenav">
		<c:import url="../template/sidenav.jsp"></c:import>

		<!-- 내용 -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid">
					<div id="cinemaNum" style="display: none;" data-num="${cine.num}"></div>					
					<h1 class="cine_title">${cine.name}CGV</h1>
					<div class="btn_group">
						<span id="de" class="btn btn-danger">삭제</span>

                  	<a href="./cinemaUpdate?num=${cine.num}" id="up" class="btn btn-mo">수정</a>

					</div>
				
					<div class="card mb-4">
						<div class="card-body">
							<p class="mb-0">
								<code>Cinema Info</code>
								<br> 
								<span>영화관 이름: ${cine.name} CGV</span><br> 
								<span>지역: ${cine.local}</span><br>
								<span>번호: ${cine.tel}</span><br> 
								<span>총 관수: ${cine.totalTheater}개</span><br>
								<span>총 좌석: ${cine.totalSeat}개</span><br> 
								<span>교톻안내: ${cine.trafficInfo}</span><br>
								<span>주차안내: ${cine.parkingInfo}</span><br> 
								<span>영화관 소개: ${cine.intro}</span><br>
							</p>
							<!-- <div class="calendar">
								<div class="form-group">
									<label for="screenDate">날짜 선택 :</label>
									<input id="datepicker" class="form-control" type="text" name="screenDate">
									<div class="input-group-text"><i class="fa fa-calendar"></i></div>
								</div>
							</div> -->
						</div>
					</div>
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
							<thead>
								<tr>
									<th>번호</th>
									<!-- <th>CinemaNum</th> -->
									<th>이름</th>
									<th>총 좌석수</th>
									<th>필름 타입</th>
									<th>시간표</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th>번호</th>
									<!-- <th>CinemaNum</th> -->
									<th>이름</th>
									<th>총 좌석수</th>
									<th>필름 타입</th>
									<th>시간표</th>
								</tr>
							</tfoot>
							<tbody id="accordion">
								<c:forEach items="${theaterList}" var="vo" varStatus="i">
									<tr class="theaterList-c">
										<td><a href="./theaterSelect?num=${vo.num}&cinemaNum=${cinemaNum}" id="td${i.index}">${vo.num}</a></td>
										<%-- <td>${vo.cinemaNum}</td> --%>
										<td>${vo.name}</td>
										<td>${vo.seatCount}</td>
										<td>
										 	<c:forEach items="${filmType}" begin="${i.index}" end="${i.index}" var="f">
												<c:forEach items="${f}" var="m">
													<c:if test="${m eq 1}">
														2D
													</c:if>
													<c:if test="${m eq 2}">
														3D
													</c:if>
													<c:if test="${m eq 4}">
														4D
													</c:if>
												</c:forEach>
											</c:forEach>
										</td>
										<td>
											<a class="collapsed card-link" id="table${i.index}" data-toggle="collapse" href="#tb${i.index}">▼</a>
										</td>
									</tr>
									<tr id="tb${i.index}"  class="collapse" data-parent="#accordion">
										<td colspan="5">
											<div class="filmInfo">
										  		<span class="film_title">2D</span><span class="film_color film_2d"></span>
										  		<span class="film_title">3D</span><span class="film_color film_3d"></span>
										  		<span class="film_title">4D</span><span class="film_color film_4d"></span>
										  	</div>
										  	<div class="calendar" style="height: 36px;">
												<div class="form-group">
													<label for="screenDate" style="width: 70px;">날짜 선택 :</label>
													<input id="datepicker${i.index}" class="datepicker"  type="text" name="screenDate"
													style="border: 1px solid #6c757d">
													<span id="submitBtn${i.index}" name="${vo.num}" class="submitBtn btn btn-primary">검색</span>
												</div>
											</div>
											
											<div class="movieTime" style="margin-left:1310px;">
												<input type="button" value="상영 시간 등록" class="btn btn-primary movieTimeInsert" data-num="${vo.num}"
												style="font-size: 15px;">
											</div>
														  	
										  	<div class="timetable" id="timetable${i.index}" name="${i.index}"></div>
										</td>
									</tr>
								</c:forEach>
						</table>
					</div>
					<div class="">


						<a href="./theaterInsert?cinemaNum=${cine.num}" id="up" class="btn btn-mo">상영관 등록</a>


                    	<c:if test="${empty timePriceList}">
                    		<a href="./admissionPrice/write?num=${cine.num}" id="admissionPrice" class="btn btn-info">관람가격 등록</a>
                    	</c:if>
                    	<c:if test="${not empty timePriceList}">
                    		<a href="./admissionPrice/selectList?num=${cine.num}" id="admissionPrice" class="btn btn-info">관람가격 조회</a>
                    	</c:if>

                    </div>
				</div>
			</main>
            <c:import url="../template/footer.jsp"></c:import>
            </div>
    </div>
    <c:import url="../template/scripts.jsp"></c:import>
    <script type="text/javascript">
		//delete submit
		$("#de").click(function(){
			//정말 삭제할 거냐고 묻는 alert창
			var check = confirm("삭제하시겠습니까?");
			if(check){
				location.href="./cinemaDelete?num="+${cine.num};
			}
		});


		//time block 스르륵

    </script>
        
    <script src="/js/theater/timetable.js"></script>

    <script>
		$(".timetable").each(function(){

			var tid = $(this).attr("id");
			var name = $(this).attr("name");

		   	$("#table"+name).click(function(){

				var theaterNum = $("#td"+name).html();
				console.log(theaterNum);
			 	$.get("./theaterTime",{"theaterNum":theaterNum, "_csrf": $("#_csrf").val()},function(data){
			 		//$(".test123").html(data);
					
			  		  var timetable = new Timetable();

			  	      timetable.setScope(6,2)

			  	      
			  	      timetable.addLocations(['월', '화', '수', '목', '금', '토', '일']);
					
				  	    $(data).each(function(){
				  	    	var date = $(this)[2] + '년 ' + $(this)[3] + '월 ' + $(this)[4] + '일 / ';
						  	
					  	    if($(this)[12]=='4'){
					  	    	timetable.addEvent(
							  	    	$(this)[0], $(this)[1], new Date($(this)[2],$(this)[3],$(this)[4],$(this)[5],$(this)[6]),
							  	    	new Date($(this)[7],$(this)[8],$(this)[9],$(this)[10],$(this)[11]) ,  { class: 'only-4d', onClick: function(event) { timeAlert(event, date); } });
								
					  	    	
					  	    }else if($(this)[12]=='2'){
					  	    	timetable.addEvent(
							  	    	$(this)[0], $(this)[1], new Date($(this)[2],$(this)[3],$(this)[4],$(this)[5],$(this)[6]),
							  	    	new Date($(this)[7],$(this)[8],$(this)[9],$(this)[10],$(this)[11]) , { class: 'only-3d', onClick: function(event) { timeAlert(event, date); } });
						  	}else if($(this)[12]=='1'){
						  		timetable.addEvent(
							  	    	$(this)[0], $(this)[1], new Date($(this)[2],$(this)[3],$(this)[4],$(this)[5],$(this)[6]),
							  	    	new Date($(this)[7],$(this)[8],$(this)[9],$(this)[10],$(this)[11]),  { onClick: function(event) { timeAlert(event, date); }}    
							  	);
							}
							
						    
					  	});


			  	   /*    timetable.addEvent('Lasergaming', '목', new Date(2015,7,17,17,45), new Date(2015,7,17,19,30), { class: 'vip-only', data: { maxPlayers: 14, gameType: 'Capture the flag' } });
			  	      timetable.addEvent('All-you-can-eat grill', '금', new Date(2015,7,17,21), new Date(2015,7,18,1,30), { url: '#' });
			  	      timetable.addEvent('Hackathon', '일', new Date(2015,7,17,11,30), new Date(2015,7,17,20)); // options attribute is not used for this event
			  	      timetable.addEvent('Hackathon Livestream', '수', new Date(2015,7,17,12,30), new Date(2015,7,17,16,15)); // options attribute is not used for this event
			  	      timetable.addEvent('Lunch', '토', new Date(2015,7,17,9,30), new Date(2015,7,17,11,45), { onClick: function(event) {
			  	        window.alert('You clicked on the ' + event.name + ' event in ' + event.location + '. This is an example of a click handler');
			  	      }}); */
			  	      

			  	      var renderer = new Timetable.Renderer(timetable);
			  	      renderer.draw('#'+tid);
			  	      $(".room-timeline").css("width","100%");
			  	     
			  	    //alert($(".time-entry").css("left"));
			  	    
					$(".time-entry").each(function(){ 
					    var oriLeft = $(this).css("left");
				  	    var test = (oriLeft.slice(0, oriLeft.length-2));
						var cgLeft = (test*0.95)+'px';
						$(this).css("left",cgLeft);

						var oriWidth = $(this).css("width");
				  	    var wtest = (oriWidth.slice(0, oriWidth.length-2));
						var cgWidth = (wtest*0.957)+'px';
						$(this).css("width",cgWidth);
					});
			  	    
			  	 
				}); 


				$(".submitBtn").each(function(index){	//0, 1
					$("#submitBtn"+index).click(function(){
						var ckDate = $("#datepicker"+index).val();
						$.get(
								"./theaterTime", {
									_csrf : $("#_csrf").val(),
									theaterNum : $(this).attr("name"),
									checkDate : ckDate
								}, function(data) {
									
									var timetable = new Timetable();

							  	    timetable.setScope(6,2)

							  	    timetable.addLocations(['월', '화', '수', '목', '금', '토', '일']);
							  	 
							  		
							  	    $(data).each(function(){
							  	    	var date = $(this)[2] + '년 ' + $(this)[3] + '월 ' + $(this)[4] + '일 / ';
							  	    	
								  	    if($(this)[12]=='4'){
								  	    	timetable.addEvent(
										  	    	$(this)[0], $(this)[1], new Date($(this)[2],$(this)[3],$(this)[4],$(this)[5],$(this)[6]),
										  	    	new Date($(this)[7],$(this)[8],$(this)[9],$(this)[10],$(this)[11]) ,  { class: 'only-4d', onClick: function(event) { timeAlert(event, date); }  });
											
								  	    	
								  	    }else if($(this)[12]=='2'){
								  	    	timetable.addEvent(
										  	    	$(this)[0], $(this)[1], new Date($(this)[2],$(this)[3],$(this)[4],$(this)[5],$(this)[6]),
										  	    	new Date($(this)[7],$(this)[8],$(this)[9],$(this)[10],$(this)[11]) , { class: 'only-3d', onClick: function(event) { timeAlert(event, date); }  });
									  	}else if($(this)[12]=='1'){
									  		timetable.addEvent(
										  	    	$(this)[0], $(this)[1], new Date($(this)[2],$(this)[3],$(this)[4],$(this)[5],$(this)[6]),
										  	    	new Date($(this)[7],$(this)[8],$(this)[9],$(this)[10],$(this)[11]),  { onClick: function(event) { timeAlert(event, date);
											  	    	
											  	        
											  	    }});
										}
								  	});

							  	    var renderer = new Timetable.Renderer(timetable);
							  	    renderer.draw('#'+tid);
							  	    $(".room-timeline").css("width","100%");

							  	 
							  		$(".time-entry").each(function(){ 
									    var oriLeft = $(this).css("left");
								  	    var test = (oriLeft.slice(0, oriLeft.length-2));
										var cgLeft = (test*0.95)+'px';
										$(this).css("left",cgLeft);

										var oriWidth = $(this).css("width");
								  	    var wtest = (oriWidth.slice(0, oriWidth.length-2));
										var cgWidth = (wtest*0.957)+'px';
										$(this).css("width",cgWidth);
									});
							        
							});
					});

				});
				
		      });
			
		    
		});





	//movie tile click alert
	function timeAlert(event, date){
		var s = event.startDate.toString();
    	var startTime = s.substring(16,21);
    	var e = event.endDate.toString();
    	var endTime = e.substring(17,21);
        window.alert(date + event.name + ' / ' + startTime  +' (' +event.location+ ')' + ' ~ ' + endTime +' (' +event.location+ ')');
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
			$('.datepicker').val(year + '-' + month + '-' + date);
			
			$('.datepicker').datepicker({
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
		
		initDatePicker();
		
 
 	// submit 버튼 클릭시
	
	// movieTimeInsert button 클릭시
	$(".movieTimeInsert").each(function() {

		$(this).click(function() {

			var theaterNum = $(this).data("num");
			var cinemaNum = $("#cinemaNum").data("num");
			console.log("movieTimeInsert : "+theaterNum);

			location.href = "/admin/movieTime/insert?num="+theaterNum+"&cinemaNum="+cinemaNum;
		});
	})
	
	$(".time-entry").style("position","relative");

    </script>

    <!-- Google Analytics: change UA-XXXXX-X to be your site's ID. -->
    <script>
      (function(b,o,i,l,e,r){b.GoogleAnalyticsObject=l;b[l]||(b[l]=
      function(){(b[l].q=b[l].q||[]).push(arguments)});b[l].l=+new Date;
      e=o.createElement(i);r=o.getElementsByTagName(i)[0];
      e.src='//www.google-analytics.com/analytics.js';
      r.parentNode.insertBefore(e,r)}(window,document,'script','ga'));
      ga('create','UA-171485633-1');ga('send','pageview');

      $(".room-timeline").css("width","100%");

  
      
    </script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
	<script src="assets/demo/datatables-demo.js"></script>
</body>
</html>

