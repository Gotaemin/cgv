<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/css/layout.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie/movieList.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/event/eventSelect.css" rel="stylesheet" type="text/css">

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
					<a href="./eventList">이벤트</a>
				</li>
				<li>
					<a href="./eventList">이벤트리스트</a>
				</li>
				<li class="last">
					이벤트상세
				</li>
			</ul>
		</div>
	</div>
	<div class="contents">
		<div class="tbl-viw-head">
			<h3>
				<em class="txt-lightblue">${vo.kind}</em>
				${vo.title}
			</h3>
			<em class="date">
				<span>기간 : </span>
				${vo.startDate} ~ ${vo.endDate}
			</em>
			
		</div>
		<div class="tbl-viw-content">
			<c:forEach var="eventImageVO" items="${vo.eventImageVOs}">
			<img src="../images/event/eventList/eventImage/${eventImageVO.fileName}">
			</c:forEach>
		</div>
		<div class="tbl-viw-nav">
			<div class="dir-prev">
				<a href="./eventList">목록</a>
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
</body>
</html>
















