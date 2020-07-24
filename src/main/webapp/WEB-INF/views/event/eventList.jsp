<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/css/layout.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie/movieList.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/event/eventList.css" rel="stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
	.b-round	{
		border-radius:4px;
	}
</style>
</head>
<body>

<div class="root">
	<!-- 헤더 -------------------------------------------------------------------------------------->
	<c:import url="../template/header.jsp"></c:import>
	
	<!-- 컨테이너 -------------------------------------------------------------------------------------->
	<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="container">
		<div class="c_nav">
			<div class="nav_linemap">
				<ul>
					<li>
						<a href="../">
							<img alt="go to Home" src="../images/login/btn_home.png">					
						</a>
					</li>
					<li>
						<a href="./eventList">이벤트</a>
					</li>
					<li>
						<a href="./eventList">이벤트리스트</a>
					</li>
				</ul>
			</div>
		</div>
		
		<div class="contents">
			<div class="movie-chart">
<!-- 			헤더 제목부분+ 차트종류(서브) -->
				<div class="sect-movie-title">
					<h3>EVENT</h3>
				</div>
				<div class="evt-nav-area">
					<ul class="evt-tab-manu">
						<li>
							<a href="#" title="" class="kind on" id="special">SPECIAL</a>
						</li>
						<li>
							<a href="#" title="" class="kind" id="movie">영화/예매</a>
						</li>
						<li>
							<a href="#" title="" class="kind" id="membership">멤버십/CLUB</a>
						</li>
						<li>
							<a href="#" title="" class="kind" id="discount">제휴/할인</a>
						</li>
						<li>
							<a href="#" title="" class="kind" id="pub">PUB이벤트</a>
						</li>
					</ul>
					<div class="submenu">
						<a href="" class="round red on b-round"><i>당첨자 발표</i></a>
						<a href="./endEventList" class="round red on b-round"><i>종료된 이벤트</i></a>
					</div>
				</div>
				<div class="evt-select-area"></div>
				<div class="cols-content" style=" display: flex;">
					<div class="cols-detail event">
						<div class="sect-evt-item-list">
							<ul class="cf"  id="tb">
								<c:forEach items="${list}" var="vo" varStatus="i">
									<input type="hidden" class="date" value="${vo.endDate}">
									<li>
										<a id="title_${i.index}" href="./eventSelect?num=${vo.num}">
											<div class="evt-thumb">
												
												<c:forEach var="eventImageVO" items="${vo.eventImageVOs}">
													
													<img alt="" src="../images/event/eventList/eventImage/${eventImageVO.fileName}">
													
												</c:forEach>
												
											</div>
											<div class="evt-desc">
												<p class="txt1">${vo.title}</p>
												<p class="txt2">
													"${vo.startDate}~${vo.endDate}"
													<!-- <span> . </span> -->
													<!-- <em class="d-day">D-5</em> -->
												</p>
											</div>
										</a>
								</li>
								</c:forEach>
							</ul>
						</div>
						
					<%-- 	<span id="totalPage" class="" name="${pager.totalPage}"></span>
						<span id="curPage" class="" name="${pager.totalPage}"></span> --%>
						<input type="hidden" id="totalPage" value="${pager.totalPage}">
						<input type="hidden" id="curPage" value="${pager.curPage}">
						
						<c:if test="${pager.totalCount>9 }">
						<button type="button" class="btn-item-more" id="btnMoreData" name="${list[0].kind}"><strong>더보기</strong></button>
						</c:if>
						
						
					
					</div>
					<div class="cols-aside">
						<div class="col-aside">
							<div class="ad-evnet">
								<div class="ad-partner01">
									<div src="" width="160" height="300" frameborder="0" scrolling="no" margingeight="0" name="M_Rectangle" id="M_Rectangle">
										<a href="${movie.link}" target="_blank"><img src="/images/banner/sideBanner/${movie.fileName}" width="160" height="300" alt="파리의 인어" border="0"></a>
									</div>	
								</div>
								<div class="ad-partner01">
									<div src="" width="160" height="300" frameborder="0" scrolling="no" margingeight="0" name="M_Rectangle" id="M_Rectangle">
										<a href="${event.link}" target="_blank"><img src="/images/banner/sideBanner/${event.fileName}" width="160" height="300" alt="파리의 인어" border="0"></a>
									</div>	
								</div>
							</div>
						</div>
					</div>
				</div>

			
			</div><!-- 끝 chart -->
			
		</div>
	</div>
	
	
	<!-- 푸터 -------------------------------------------------------------------------------------->
	<c:import url="../template/footer.jsp"></c:import>
	
	<!-- 사이드바 ---------------------------------------------------------------------------------------------->
	<c:import url="../template/sidebar.jsp"></c:import>
</div>


<script type="text/javascript" src="../js/movie/movieList.js"></script>
<script type="text/javascript">


	var totalPage= 0;
	var curPage = 0;
	var kind = '';
	
	$(".kind").click(function(){
		$(".btn-item-more").show();

		//nav color
		$(this).parent().parent().find("li>a").removeClass("on");
     	$(this).addClass("on");

     	//ajax
		kind = $(this).attr("id");
		$.post("./eventKind",{"kind":kind, "_csrf": $("#_csrf").val()},function(data){
			$("#tb").html(data);
			totalPage = $("#totalPage2").val();
			curPage = $("#curPage2").val();
			kind = $("#kind").val();
			$("#totalPage").prop("value",totalPage);
			$("#curPage").prop("value",curPage);
			$(".btn-item-more").attr("name",kind);

		 	if($("#curPage").val()==$("#totalPage").val()){
				$(".btn-item-more").hide();
			} 
		});
    }); 


		
	$(".btn-item-more").click(function(){
		var kind = $(this).attr("name");
		var curPage = $("#curPage").val();
		$.post("./eventKind",{"kind":kind, "curPage":parseInt(curPage)+1, "_csrf": $("#_csrf").val()},function(data){
			console.log(data);
			
			$("#tb").append(data);
			var cur = $("#curPage").val();
			$("#curPage").val(parseInt(cur)+1);
		 	if($("#curPage").val()==$("#totalPage").val()){
				$(".btn-item-more").hide();
			} 

		})
		
	});


	//d-day
	$(".date").each(function(){
		//endDate가 현재 날짜에서 5일 남았다면 em d-day에 날짜 출력
		var nowDate = new Date();	//현재 날짜
		var date = $(this).val();	//입력된 endDate
		console.log("nowDate : " + nowDate);
		console.log("date : " + date)
	})
	



</script>
	


</body>
</html>
















