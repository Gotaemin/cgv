<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../template/head.jsp"></c:import>
<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
<link rel="stylesheet" href="/css/admin/coupon/couponList.css" />

</head>

<body class="sb-nav-fixed">
	<c:import url="../template/header.jsp"></c:import>

	<!-- 사이드바 -->
	<div id="layoutSidenav">
		<c:import url="../template/sidenav.jsp"></c:import>

		<!-- 내용 -->
		<div id="layoutSidenav_content">
			<%-- <input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> --%>
			<main>
				<div class="container-fluid">
					<h1>Coupon List</h1>
					<p>-쿠폰 목록 페이지-</p>

					<form action="./couponList" id="form-Data" class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0" style="float:right; padding-bottom: 20px;display:flex!important; " >
						<input type="hidden" id="curPage" name="curPage" value="">
						<div class="form-group">
							<span>시작일 &nbsp;</span>
							<input class="form-control" type="date" name="startDate">
							&nbsp;&nbsp;~&nbsp;&nbsp;
							<span>종료일 &nbsp;</span>
							<input class="form-control" type="date" name="endDate">
						</div>
					
						<div class="form-group" style="padding: 0 10px; text-align: right; ">
							<select class="form-control col-md-12" name="kind">
								<option class="type" id="all" value="" selected="selected">전체</option>
								<option class="type" id="cgvCoupon" value="2">CGV 할인쿠폰</option>
								<option class="type" id="cgvGiftcon" value="1">CGV 기프티콘</option>
							</select>
						</div>
						
						
						<div class="input-group" >
							<input class="form-control" name="search" value="${pager.search}" type="text" placeholder="검색어를 입력" aria-label="Search" aria-describedby="basic-addon2" />
							<input type="hidden" id="curPage" name="curPage" value="">
							 
							<div class="input-group-append">
								<button class="btn btn-primary" type="submit">
									<i class="fas fa-search"></i>
								</button>
							</div>
						</div>
					</form>


					<!-- 목록 -->
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
							<thead>
								<tr class="admin-tr">
									<th>No.</th>
									<th>이름</th>
									<th>Serial no.</th>
									<th>비밀번호</th>
									<th>가격</th>
									<th>타입</th>
									<th>잔여 수</th>
									<th>사용기간(시작)</th>
									<th>사용기간(끝)</th>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tfoot>
								<tr class="admin-tr">
									<th>No.</th>
									<th>이름</th>
									<th>Serial no.</th>
									<th>비밀번호</th>
									<th>가격</th>
									<th>타입</th>
									<th>잔여 수</th>
									<th>사용기간(시작)</th>
									<th>사용기간(끝)</th>
									<th></th>
									<th></th>
								</tr>
							</tfoot>
							<tbody id="tb">
								<c:forEach items="${couponList}" var="vo">
									<tr class="admin-tr-each">
										<td class="num ate-center">${vo.num}</td>
										<td class="ate-center"><a>${vo.name}</a></td>
										<td class="ate-center">${vo.serialNum}</td>
										<td class="ate-center">${vo.pwd}</td>
										<td class="price ate-center">${vo.price}</td>
										<td class="ate-center">${vo.type}</td>
										<td class="ate-center">${vo.count}</td>
										<td class="ate-center">${vo.getSIssuance()}</td>
										<td class="eIssuance ate-center">${vo.getEIssuance()}</td>
										<td><button onclick="location.href='./couponUpdate?num=${vo.num}'" class="btnUpdate btn btn-light">수정</button></td>
										<td><button class="btnDelete btn btn-light">삭제</button></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<div>
							<button id="btn-insert" class="btn btn-primary">쿠폰 등록</button>
						</div>


						<!-- 페이저 -->
						<div class="pager" style="display: flex; justify-content: center;">
							<ul class="pagination">
								<c:if test="${pager.curBlock>1}">
									<li class="page-item"><a href="#" class="page-link custompager" title="${pager.startNum-1}">이전</a></li>
								</c:if>
								
								<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="p">
									<li class="page-item"><a href="#" class="page-link custompager" title="${p}">${p}</a></li>
								</c:forEach>

								<c:if test="${pager.curBlock<pager.totalBlock}">
									<li class="page-item"><a href="#" class="page-link custompager" title="${pager.lastNum+1}">다음</a></li>
								</c:if>
								
							</ul>
						</div>
					</div>
				</div>
				
			</main>
			<c:import url="../template/footer.jsp"></c:import>
		</div>
	</div>
	
	<c:import url="../template/scripts.jsp"></c:import>
	

	<script type="text/javascript" src="/js/template/common.js"></script>
	<script type="text/javascript">
		var kind = `${pager.kind}`;
	</script>
	<script type="text/javascript" src="/js/admin/coupon/couponList.js"></script>
</body>
</html>

        
