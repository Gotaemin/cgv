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

					<h1>Movie Update</h1>
					<p>-영화 정보 수정 페이지-</p>
					

					<div>
						<div class="contents">
							<div>
								<div class="col_content">
									<div class="col_detail">


										<form action="./movieUpdate" method="post" enctype="multipart/form-data" id="fo">
										<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />

											<fieldset>
												<div class="tbl_write">
												
												<input type="hidden" id="trailerCount" value="0" name="trailerCount"><!-- 카운트 값이 들어옴 -->
												<input type="hidden" id="steelCutCount" value="0" name="steelCutCount">
												
											
												<input type="hidden" value="${vo.num}" id="num" name="num">
												<input type="hidden" value="${vo.movieImageVOs[0].num}" id="num1" > <!-- imgaeVO의 AI인 num -->
												<input type="hidden" value="${vo.movieImageVOs[0].fileName}" id="fileName1">
												
												<c:forEach var="ar" items="${ar}" >
													<c:if test="${ar.type eq 2 }">
													<input type="hidden" value="${ar.num}" id="numT" > <!-- type 2 imageNum -->
													<input type="hidden" value="${ar.fileName}" id="fileNameT"> 
													</c:if>
												</c:forEach>
												<c:forEach var="ar" items="${ar}" >
													<c:if test="${ar.type eq 3 }">
													<input type="hidden" value="${ar.num}" id="numS" > <!-- type 3 imageNum -->
													<input type="hidden" value="${ar.fileName}" id="fileNameS"> 
													</c:if>
												</c:forEach>
												
												
													<table class="tbl_bbs_write">
														<tbody>
															<div class="form-group">
																<label for="files">타이틀 이미지:</label>
																<c:if test="${path  eq 'Update'}">
																	<p style="display: inline;" class="pp">
																		<%-- <i id="${vo.num}" class=" fileDelete"></i> --%>
																		<i class="fileDelete fdt" data-type="1" name="${vo.movieImageVOs[0].fileName}" id="${vo.movieImageVOs[0].num}">
																		<img alt="" src="../../images/movie/movieList/x.png"
																			style="width: 20px; height: 20px;" 
																			id="${vo.movieImageVOs[0].num}">
																		</i>
																		<!-- 썸네일 num -->
																	</p>
																</c:if>

																<input type="text" class="form-control files check stt"
																	id="files" placeholder="타이틀 이미지 선택" name="files" value="${vo.movieImageVOs[0].originName}"  readonly="readonly"
																	style="width: 67.5%;"
																	>

																
															</div>
															<!-- ============== -->
															
															<div id="tra">
															<div class="form-group" id="1d">
																<label for="files" style="width: 155px;">트레일러 썸네일&링크:</label>
																<input type="button" id="addI" value="추가">
																
																	<c:forEach var="ar" items="${ar}" varStatus="i">
																		<c:if test="${ar.type eq 2 }">
																			<div class="form-group" style="display: flex;">
																				<input type="text" class="form-control files check trail"
																					id="files${i.index}" placeholder="예고편 이미지 선택"
																					name="files" value="${ar.originName}" readonly="readonly"> <input type="text"
																					class="form-control videolink check "
																					id="videolink${i.index}" placeholder="예고편 영상 링크"
																					name="videolink"
																					value="${ar.movieVideoVOs[0].videolink}" readonly="readonly">
																				<p class="mv-p">
																					<img alt=""
																						src="../../images/movie/movieList/x.png"
																						data-imgpath="${ar.fileName}"
																						style="width: 20px; height: 20px;"
																						data-imagenum="${ar.num}" 
																						data-index="${i.index}"class="fileDeleteT"/>
																					<!-- 트레일러  num -->
																				</p>
																			</div>
																		</c:if>
																	</c:forEach>
																	
																	<!-- 비디오 링크 -->
																	<c:forEach var="ar" items="${ar}" varStatus="i" >
																		<c:if test="${ar.type eq 2 }">
																		
																		</c:if>	
																	</c:forEach>
																	<!--  추가   -->
															</div>
																<div class="form-group"  id="f"></div>
															</div>
															
															
															
															
															<!-- ============== -->
															
															
															<div class="form-group" style="clear: both;">
																<label for="title">제목:</label> 
																<input type="text" class="form-control check" id="title" name="title" value="${vo.title}">
																<p id="tdc"></p>
															</div>
															<div class="form-group">
																<label for="titleEng">영문제목:</label> <input type="text" 
																	class="form-control check" id="titleEng" name="titleEng" value="${vo.titleEng}">
																<p id="tEdc"></p>
															</div>
															<div class="form-group">
																<label for="runtime">러닝타임:</label> <input type="text"
																	class="form-control check" id="runtime" name="runtime" value="${vo.runtime}">
															</div>
															<div class="form-group">
																<label for="director">감독:</label> <input type="text"
																	class="form-control check" id="director" name="director" value="${vo.director}">
															</div>
															<div class="form-group">
																<label for="actor">출연 배우:</label> <input type="text"
																	class="form-control check" id="actor" name="actor" value="${vo.actor}">
															</div>
															<div class="form-group">
																<label for="ganre">장르:</label> <input type="text"
																	class="form-control check" id="ganre" name="ganre" value="${vo.ganre}">
															</div>
															<div class="form-group">
																<label for="ageLimit">연령제한:</label> <input type="text"
																	class="form-control check" id="ageLimit" name="ageLimit" value="${vo.ageLimit}">
															</div>
															<div class="form-group">
																<label for="country">국가:</label> <input type="text"
																	class="form-control check" id="country" name="country" value="${vo.country}">
															</div>
															
															
															<div class="form-group" >
																<label for="files" style="width: 50px;">스틸컷:</label>
																<input type="button" id="addS" value="추가">
																	<c:forEach var="ar" items="${ar}" varStatus="i">
																		<c:if test="${ar.type eq 3 }">
																		<div style="display: flex; margin-bottom: 10px;">
																		<input type="text"
																			class="form-control files check stcc" id="files"
																			placeholder="타이틀 이미지 선택" name="steel" value="${ar.originName}" readonly="readonly" style="width: 190%;">
																		<p class="mv-p">
																			<img alt="" src="../../images/movie/movieList/x.png"
																			data-imgpaths ="${ar.fileName}"
																			style="width: 20px; height: 20px;" class="fileDeleteS stc" data-imagenums="${ar.num}"> <!-- 삭제할 id를 뭘로 주지... -->
																		</p>
																		</div>
																		</c:if>
																	</c:forEach>
																	<div class="form-group" id="st">
																
																</div>
															</div>
															
															
															<div class="form-group">
																<label for="openDate">개봉일:</label> <input type="date"
																	class="form-control check" id="openDate" name="openDate" value="${vo.openDate}">
															</div>

															<c:set var="now" value="<%=new java.util.Date()%>" />
															<c:set var="sysYear">
																<fmt:formatDate value="${now}" pattern="yyyy" />
															</c:set>
															<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"
																var="i" />

															<c:if test="${path eq 'Write' }">
																<div class="form-group">
																	<label for="createAt">생성일:</label> <input type="date"
																		class="form-control" id="createAt" name="createAt"
																		value="${i}" readonly="readonly">
																</div>
															</c:if>

															<div class="form-group">
																<label for="contents">줄거리:</label>
																<textarea rows="" cols="" class="form-control check"
																	id="contents" name="contents">${vo.contents}</textarea>

															</div>

														</tbody>

													</table>

												</div>
												<div class="btn_s">
													<a href="./movieSelect?num=${vo.num}" class="round gray" id="cancle"> 
														<span style="font-size: 15px;">취소</span>
													</a>
													<button id="btn" type="submit" class="round inred">
														<span style="font-size: 15px;">등록하기</span>
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

	
<c:import url="../template/scripts.jsp"></c:import>

<script type="text/javascript" src="../../js/movie/movieWrite.js"></script>
<script type="text/javascript" src="../../js/movie/movieUpdate.js"></script>	

<c:import url="../template/scripts.jsp"></c:import>
<!-- <script type="text/javascript" src="/js/admin/movie/movieUpdate.js"></script> -->
<script type="text/javascript" src="/js/template/bootstrap-datepicker.js"></script>
<script type="text/javascript" src="/js/template/bootstrap-datepicker.ko.min.js"></script>
<script type="text/javascript">
//datepicker
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


</script>	
</body>
</html>