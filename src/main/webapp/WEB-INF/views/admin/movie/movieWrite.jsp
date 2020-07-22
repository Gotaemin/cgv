<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../template/head.jsp"></c:import>
<c:import url="../template/datepicker.jsp"></c:import>
<link rel="stylesheet" href="/css/admin/movie/movie.css" />
<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
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

					<h1>Movie ${path}</h1>

					<div>

						<div class="contents">
							<div>

								<div class="col_content">

									<!----------------------------------------------------------------------------------------------------- contents detail -->

									<div class="col_detail">

										<!----------------------------------------------------------------------------------------------------- contents detail box_bbslist-->
										<form action="./movie${path}" method="post" enctype="multipart/form-data">
										<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
											<fieldset>
												<input type="hidden" id="trailerCount" value="1" name="trailerCount"><!-- 카운트 값이 들어옴 -->
												<input type="hidden" id="steelCutCount" value="1" name="steelCutCount">
												<div class="tbl_write">

													<input type="hidden" value="${vo.movieImageVOs.num}"
														id="num1">
													<!-- imgaeVO의 AI인 num -->
													<input type="hidden" value="${vo.num}" name="num"> 
													<input
														type="hidden" value="${vo.movieImageVOs.fileName}"
														id="fileName">

													<table class="tbl_bbs_write">
														<colgroup>
															<col style="width: 100px;">
															<col style="width: 320px;">
														</colgroup>
														<tbody>
															
					
															<div class="form-group" >
																<label for="files">타이틀 이미지:</label> <input type="file"
																	class="form-control files check" id="files"
																	placeholder="타이틀 이미지 선택" name="files" style="width: 34%">
															</div>

															<div class="form-group" id="d1" style="position: relative;">
																<label for="files">트레일러</label> <img alt=""
																	src="../../images/theater/plus.png"
																	style="width: 20px; height: 20px; cursor:pointer;
																	 top: 1px; left: 60px; position: absolute;"
																	 id="addI">
																	 
																 <div class="group1" style="margin-bottom:5px;">
																	<input type="file" multiple="multiple" style="width:16.5%!important; float:left;"
																	 class="form-control files check form-control2" id="files"placeholder="트레일러 이미지 선택" name="files">
																	<input type="text" class="form-control videolink check form-control2" 
																	id="videolink" placeholder="예고편 영상 링크" name="videolink"
																	style="padding: 12px; width: 16.7%!important;display: inline-block;">
																</div> 
																<div id="tt">
																	<div class="form-group" id="f" style="float: left;">
																	</div>
																</div>
															</div>

															
														
															<div class="form-group"  style="clear: both;">
																<label for="title" >제목:</label> <input type="text"
																	class="form-control check" id="title" name="title"
																	value="${vo.title }">
																<p id="tdc"></p>
															</div>
															<div class="form-group">
																<label for="titleEng">영문제목:</label> 
																<input
																	type="text" class="form-control check"  id="titleEng"
																	name="titleEng" value="${vo.titleEng }">
																<p id="tEdc"></p>
															</div>
															<div class="form-group">
																<label for="runtime">러닝타임:</label> <input type="text"
																	class="form-control check" id="runtime" name="runtime"
																	value="${vo.runtime }">
															</div>
															<div class="form-group">
																<label for="director">감독:</label> <input type="text"
																	class="form-control check" id="director" name="director"
																	value="${vo.director }">
															</div>
															<div class="form-group">
																<label for="actor">출연 배우:</label> <input type="text"
																	class="form-control check" id="actor" name="actor"
																	value="${vo.actor }">
															</div>
															<div class="form-group">
																<label for="ganre">장르:</label> <input type="text"
																	class="form-control check" id="ganre" name="ganre"
																	value="${vo.ganre }">
															</div>
															<div class="form-group">
																<label for="ageLimit">연령제한:</label> <input type="text"
																	class="form-control check" id="ageLimit" name="ageLimit"
																	value="${vo.ageLimit }">
															</div>
															<div class="form-group">
																<label for="country">국가:</label> <input type="text"
																	class="form-control check" id="country" name="country"
																	value="${vo.country }">
															</div>
															
															<div class="form-group" style="position: relative;" >
																<label for="files">스틸컷</label>
																<img alt="" src="../../images/theater/plus.png" 
																style="width: 20px; height: 20px; width: 20px; height: 20px; 
																top: 2px; left: 50px; position: absolute; cursor: pointer;" id="addS"> 
																 <div style="display:flex;"><input type="file" class="form-control steelCut check form-control2" 
																	id="steelCut" placeholder="스틸컷 이미지 " name="files"
																		style="margin-bottom:5px; width: 34%">
																</div> 
																
																<div class="form-group" id="st">
																
																</div>
															</div>
															
															<div class="form-group">
																<label for="openDate">개봉일:</label> 
																<input type="text"
																	class="form-control check" id="openDate" name="openDate"
																	value="${vo.openDate}">
																<!-- 	<input id="openDate" class="datepicker"  type="text" name="openDate"> -->
															</div>

															<c:set var="now" value="<%=new java.util.Date()%>" />
															<c:set var="sysYear">
																<fmt:formatDate value="${now}" pattern="yyyy" />
															</c:set>
															<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="i" />

															<c:if test="${path eq 'Write' }">
																<div class="form-group">
																	<label for="createAt">생성일:</label> <input type="date"
																		class="form-control" id="createAt" name="createAt"
																		value="${i}" readonly="readonly">
																</div>
															</c:if>

															<div class="form-group">
																<label for="contents" >Contents:</label>
																<textarea rows="" cols="" class="form-control check"
																	id="contents" name="contents">${vo.contents }</textarea>
															</div>
															
															
															  
															

														</tbody>

													</table>

												</div>
												<div class="btn_s">
													<a href="./movieList" class="round gray" id="cancle"> 
														<span>취소</span>
													</a>
													<button id="btn" type="submit" class="round inred">
														<span>등록하기</span>
													</button>
												</div>
											</fieldset>
										</form>

									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
			<c:import url="../template/footer.jsp"></c:import>
		</div>
	</div>

	<!-- 스크립트 -->

	<script src="js/scripts.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/datatables-demo.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script type="text/javascript" src="../../js/movie/movieWrite.js"></script>
	
	
	<script type="text/javascript" src="/js/template/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="/js/template/bootstrap-datepicker.ko.min.js"></script>
	

	
	
	<script type="text/javascript">
	
	var num=0; // 트레일러 이미지
	var trailerCount = $("#trailerCount").val();
	
	var num2=0; //비디오 링크
	var count2=1;

	var numS =0; // 스틸컷
	var steelCutCount = $("#steelCutCount").val();
	//트레일러 이미지
	$("#addI").click(function(){
		
		if(num<2){
			//이미지
			$("#f").append(
					'<div class="group1" style="margin-bottom:5px;">'+
					'<input type="file" multiple="multiple" style="width:45%!important; float:left;"'+
					' class="form-control files check form-control2" id="files"placeholder="트레일러 이미지 선택" name="files">'+
					'<input type="text" class="form-control videolink check form-control2" '+
					'id="videolink" placeholder="예고편 영상 링크" name="videolink"'+
					'style="padding: 12px; width: 45%!important;display: inline-block;">'+
					'<span class="x" style="width: 10%!important;">X</span>'+
					'</div>');
		
			num++;		
			trailerCount++;
			
			$("#trailerCount").val(trailerCount);
			console.log(trailerCount);
			
			
			}else{
				alert("최대 3개까지 가능합니다.")
			}
		
		});	
	

	// 스틸컷 이미지
	$("#addS").click(function(){
		if(numS<4){
			$("#st").append('<div style="display:flex;"><input type="file" class="form-control steelCut check form-control2" '+
					'id="steelCut" placeholder="스틸컷 이미지 " name="files"'+
					'style="margin-bottom:5px;width: 34%"> <span class="xS">X</span></div>');
			
			numS++;
			steelCutCount++;
			$("#steelCutCount").val(steelCutCount);
			
			}else{
				alert("최대 5개까지 가능합니다.")
				}
		
		});

	
 	$("#f").on("click",".x",function(){ //추가된 파일 필요없을 시 삭제
		$(this).parent().remove();
 		num--;
 		trailerCount--;
 		$("#trailerCount").val(trailerCount);
		});

   $("#f2").on("click",".x",function(){ //추가된 비디오링크 필요없을 시 삭제
		$(this).parent().remove();
		num2--;

		});   
	$("#st").on("click",".xS",function(){
		$(this).parent().remove();
		numS--;
		steelCutCount--;
		$("#steelCutCount").val(steelCutCount);
		});

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
		$('#openDate').val(year + '-' + month + '-' + date);
		
		$('#openDate').datepicker({
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


	//titleCheck
	$("#title").blur(function() {

		var tit = $("#title").val();

		$.get("./titleCheck",{
				title:tit
			},function(result){
			if(result == 1){
				$("#tdc").html('<p style="color:red;"> - 중복되는 영화 제목입니다 - </p>');
				/* alert("이미 존재하는 제목 입니다."); */
				$("#title").val("");
			}else{
				$("#tdc").html('<p style="color:blue;"> - 등록 가능합니다 - </p>');
			}
			
			if(tit==""){
				$("#tdc").remove();
			}
		});
	});


	//titleEngCheck
	$("#titleEng").blur(function() {

		var titE = $("#titleEng").val();

		$.get("./titleEngCheck",{
			titleEng:titE
			},function(result){
			if(result == 1){
				$("#tEdc").html('<p style="color:red;"> - 중복되는 영화 영문 제목입니다 - </p>');
				/* alert("이미 존재하는 제목 입니다."); */
				$("#titleEng").val("");
			}else{
				$("#tEdc").html('<p style="color:blue;"> - 등록 가능합니다 - </p>');
			}

			if(titE==""){
				$("#tEdc").remove();
			}
		});
	});
	
	
	</script>
	
</body>
</html>