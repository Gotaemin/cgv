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
						<a href="./movieList">영화</a>
					</li>
					<li>
						<a href="./movieList">무비차트</a>
					</li>
					<li class="last">
						무비차트
					</li>
				</ul>
			</div>
		</div>
		
		<div class="contents">
			<div class="movie-chart">
				<div class="sect-movie-title">
					<h3>EVENT</h3>
				</div>
				<h4>종료된 이벤트</h4>

				<div class="sect-evt-entlist">
					<ul>
						<c:forEach items="${list}" var="vo">
						<li>
							<div class="box-images">
								<a href="/event/eventSelect?num=${vo.num}">
									<span class="thumb-img">
										<c:forEach items="${vo.eventImageVOs}" var="eventImageVO">
										<img src="../images/event/eventList/eventImage/${eventImageVO.fileName}">
										</c:forEach>
									</span>
								</a>
							</div>
							<div class="box-content">
								<a href="/event/eventSelect?num=${vo.num}">
									<em class="txt-lightblue">${vo.kind}</em>
									<strong>${vo.title}</strong>
								</a>
								<em class="date">
									<span>기간 : </span>
									${vo.startDate} ~ ${vo.endDate}
								</em>
							</div>
						</li>
						</c:forEach>
					</ul>
				</div>

			</div><!-- 끝 chart -->
			<div class="paging">
				<ul>
					<li>
						<a href="#" title="">1</a>
					</li>
				</ul>
			</div>
			
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
		/* 	alert(totalPage);
			alert(curPage);
			alert(kind); */
			$("#totalPage").prop("value",totalPage);
			$("#curPage").prop("value",curPage);
			$(".btn-item-more").attr("name",kind);
			


		 	if($("#curPage").val()==$("#totalPage").val()){
				$(".btn-item-more").hide();
			} 
		});
    }); 


		
	$(".btn-item-more").click(function(){
		alert("test");
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
















