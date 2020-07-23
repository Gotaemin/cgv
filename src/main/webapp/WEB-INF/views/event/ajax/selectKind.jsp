<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${list}" var="vo" varStatus="i">
	<li>
		<a id="tile_${i}" href="./eventSelect?num=${vo.num}">
			<div class="evt-thumb">
				<c:forEach var="eventImageVO" items="${vo.eventImageVOs}">					
					<img alt="" src="../images/event/eventList/eventImage/${eventImageVO.fileName}">				
				</c:forEach>
			</div>
			
			
			<div class="evt-desc">
				<p class="txt1">${vo.title}</p>
				<p class="txt2">
					"${vo.startDate}~${vo.endDate}"
					<!-- <em>D-5</em> -->
				</p>
			</div>

		</a>
	</li>

</c:forEach>
<input type="hidden" id="totalPage2" value="${pager.totalPage}">

<input type="hidden" id="curPage2" value="${pager.curPage}">
<input type="hidden" id="kind" value="${list[0].kind}">
