<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<ol style="height: 420px;">
	<c:forEach var="list" items="${list}" varStatus="i">
		<c:if test="${i.index ne 0 && i.index % 4 eq 0 }">
			</ol><ol style="height: 420px;">
		</c:if>
	
		<li>
			<!-- 윗 부분 -->
			<div class="box-image">
				<a href="./movieSelect?num=${list.num}">
				  
					<span class="thumb-image">

						<img alt="이미지" src="../images/movie/movieList/filmCover/${list.movieImageVOs[0].fileName}">

						<span class="icon-grade grade-${list.ageLimit }">${list.ageLimit }</span>
					</span>
				</a>
				<span class="screentype"></span>
			</div> <!-- 아래 부분 -->
			<div class="box-contents">
				<a href="./movieSelect?num=${list.num}"><strong class="title">${list.title}</strong> </a>
				<div class="score">
					<strong class="percent">예매율<span>${list.rate}%</span></strong>
					<div class="egg-gage small">
						<span class="egg great"></span> <span class="percent">${list.errRate}%</span>
					</div>
				</div>
				<span class="text-info"> <strong>${list.openDate}<span>개봉${i.index}</span></strong>
				</span> <span class="like"> <%-- 									
					<a href="./movieReservation?mNum=${list.mNum}" class="link-reservation">예매</a> --%>
					<a href="./movieReservation" class="link-reservation">예매</a>
				</span>
			</div>
		</li>
		
		

	</c:forEach>
</ol>