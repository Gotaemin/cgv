<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	<thead>
		<tr class="admin-tr">
			<th style="width:200px">No.</th>
			<th style="width:200px">분류</th>
			<th>제목</th>
			<th style="width:200px">시작일</th>
			<th style="width:200px">마감일 </th>
		</tr>
	</thead>
	<tfoot>
		<tr class="admin-tr">
			<th style="width:200px">No.</th>
			<th style="width:200px">분류</th>
			<th>제목</th>
			<th style="width:200px">시작일</th>
			<th style="width:200px">마감일</th>
		</tr>
	</tfoot>
	
	<tbody>
		<c:forEach items="${list}" var="vo">
			<tr class="admin-tr-each">
				<td class="ate-center">${vo.num}</td>
				<td class="ate-center">${vo.kind}</td>
				<td class="ate-center">
					<a href="../event/eventSelect?num=${vo.num}">${vo.title}</a>
				</td>
				<td class="ate-center">${vo.startDate}</td>
				<td class="ate-center">${vo.endDate}</td>
	
			</tr>
		</c:forEach>
		<!-- 페이저 -->
		
	</tbody>
	
</table>
<!-- 페이저 -->
<div class="pager" style="display: flex; justify-content: center;">
	<ul class="pagination">
	
		<c:if test="${pager.curBlock>1}">
			<li class="page-item"><a href="${pager.startNum-1}" class="page-link custompager" title="${pager.startNum-1}">이전</a></li>
		</c:if>
		
		<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="p">
			<li class="page-item"><a href="./cinemaList?curPage=${p}&local=${pager.kind}" class="page-link custompager" title="${p}">${p}</a></li>
		</c:forEach>

		<c:if test="${pager.curBlock<pager.totalBlock}">
			<li class="page-item"><a href="${pager.lastNum+1}" class="page-link custompager" title="${pager.lastNum+1}">다음</a></li>
		</c:if>
		
	</ul>
	<div style="position: absolute; left: 40px;">
		<a href="./eventInsert" id="up" class="btn btn-primary" style="font-size: 15px;">이벤트 추가</a>
              		</div>
</div>