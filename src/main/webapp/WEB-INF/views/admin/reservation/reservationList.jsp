<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../template/head.jsp"></c:import>
<link rel="stylesheet" href="/css/admin/reservation/reservation.css" />

</head>
<body class="sb-nav-fixed">
	
	<c:import url="../template/header.jsp"></c:import>

	<!-- 사이드바 -->
	<div id="layoutSidenav">
		
		<c:import url="../template/sidenav.jsp"></c:import>
		<!-- 내용 -->
		<div id="layoutSidenav_content">

			<main style="min-width: 1578px;">
				<div class="container-fluid">
					<h1>Reservation List</h1>
					<p>-예매 내역 목록-</p>

					<form action="../reservation/selectList" id="form-Data" class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0" style="float:right; padding-bottom: 20px;display:flex!important; " >
						<div class="form-group" style="padding-right: 10px; text-align: right; ">
							<select class="form-control col-md-12" name="kind">
								<option class="type" id="title" value="title" selected="selected">제목</option>
								<option class="type" id="username" value="username">아이디</option>
								<option class="type" id="all" value="all">제목+아이디</option>
							</select>
						</div>
						
						
						<div class="input-group">
							<input class="form-control" name="search" value="${pager.search}" type="text" placeholder="검색어를 입력" aria-label="Search" aria-describedby="basic-addon2" />
							<input type="hidden" id="curPage" name="curPage" value="">
							<input type="hidden" id="sDate" name="sDate" value="">
							<input type="hidden" id="eDate" name="eDate" value="">
							 
							<div class="input-group-append">
								<button class="btn btn-primary" type="submit">
									<i class="fas fa-search"></i>
								</button>
							</div>
						</div>
					</form>

					<!-- 목록 -->
					<div class="table-responsive" style="clear: both;">
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0" style="table-layout: fixed;">
							<thead>
								<tr class="admin-tr">
									<th style="width: 55px;">No.</th>
									<th>영화제목</th>
									<th style="width: 80px;">시작 시간</th>
									<th style="width: 78px;">결제 번호</th>
									<th style="width: 78px;">필름 타입</th>
									<th style="width: 78px;">영화관</th>
									<th style="width: 73px;">상영관</th>
									<th style="width: 83px;">예매 좌석</th>
									<th style="width: 62px;">일반</th>
									<th style="width: 62px;">청소년</th>
									<th style="width: 62px;">우대</th>
									<th style="width: 105px;">ID</th>
									<th style="width: 98px;">결제 금액</th>
									<th style="width: 142px;">생성일</th>
									<th style="width: 50px;">삭제</th>
								</tr>
							</thead>
							<tfoot>
								<tr class="admin-tr">
									<th>No.</th>
									<th>영화제목</th>
									<th>시작 시간</th>
									<th>결제 번호</th>
									<th>필름 타입</th>
									<th>영화관</th>
									<th>상영관</th>
									<th>예매 좌석</th>
									<th>일반</th>
									<th>청소년</th>
									<th>우대</th>
									<th>ID</th>
									<th>결제 금액</th>
									<th>생성일</th>
									<th>삭제</th>
								</tr>
							</tfoot>
							<tbody>
								<c:forEach items="${reservationList}" var="vo">
									<tr class="admin-tr-each">

										<td class="ate-center">${vo.num}</td>
										<td class="" style="text-overflow: ellipsis; white-space: nowrap;overflow: hidden;">${vo.movieInfoVO.title}</td>
										<td class="ate-center">${vo.movieTimeVO.screenTime}</td>
										<td class="ate-center" data-payment_num="${vo.paymentNum}" >
											<a href="#" onclick="show(${vo.paymentNum})" style="color: #333;">${vo.paymentNum}</a>
										</td>
										<td class="flimType ate-center">${vo.filmType}</td>
										<td class="ate-center">${vo.cinemaName}</td>
										<td class="ate-center">${vo.theaterName}</td>
										<td class="ate-center">${vo.seats}</td>
										<td class="ate-center">${vo.common}</td>
										<td class="ate-center">${vo.teenager}</td>
										<td class="ate-center">${vo.preference}</td>
										<td class="ate-center">${vo.uid}</td>
										<td class="totalPrice" style="text-align:right;">${vo.totalPrice}</td>
										<td class="ate-center">${vo.createAt}</td>
										<td class="del-td" data-reservation_num="${vo.num}">X</td>

									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<!-- DB 업로드/ 다운로드 -->
						<form action="../../excel/upload/reservation" method="post" enctype="multipart/form-data"
						style="float: left; position: absolute; display: flex;">
							<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="file" name="file" class="form-control" accept=".xls, .xlsx" style="padding: 2.5px; margin-right: 5px;">
							<input type="submit" value="EXCEL UPLOAD" class="btn-warning btn">
						</form>
						
						 
						<button class="btn btn-success" id="btnDownload" style="float: right;">EXCEL DOWN</button>
						<script type="text/javascript">
							$("#btnDownload").click(function(){
								location.href="../../reservation.xls";
							});
						</script>


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
					
					<!-- 결체 모달창 출력 부분 -->
					<div class="payment-List">
					
					</div>

					
					<!-- 모달창 -->
					<div class="modal fade" id="myModal" role="dialog">
						<div class="modal-dialog">

							<!-- Modal content-->
							<div class="modal-content" style="width: 850px;">
								<div class="modal-header">
									<h4 class="modal-title" style="float: left">결제 정보</h4>
									<button type="button" class="close" data-dismiss="modal">&times;</button>
								</div>
								<div class="modal-body">
									<div class="container-fluid">
										<!-- 목록 -->
										<div class="table-responsive">
											<table class="table table-bordered" id="dataTable" style="width: 100%;">
												<thead>
													<tr class="admin-tr">
														<th style="width: 48px;">No.</th>
														<th style="width: 80px;">imp_uid</th>
														<th style="width: 78px;">merchant_uid</th>
														<th style="width: 78px;">pg</th>
														<th style="width: 78px;">pay_method</th>
														<th style="width: 73px;">apply_num</th>
													</tr>
												</thead>
												
												<tbody>
													<tr class="admin-tr-each">
														<td id="paymentNum" class="ate-center">${vo.num}</td>
														<td id="imp_uid" class="ate-center">${vo.imp_uid}</td>
														<td id="merchant_uid" class="ate-center">${vo.merchant_uid}</td>
														<td id="pg" class="ate-center">${vo.pg}</td>
														<td id="pay_method" class="ate-center">${vo.pay_method}</td>
														<td id="apply_num" class="ate-center">${vo.apply_num}</td>
													</tr>
												</tbody>
											</table>


										</div>
									</div>

								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal"></button>
								</div>
							</div>

						</div>
					</div>

				</div>
			</main>
		</div>
	</div>


	<!-- 스크립트 -->
	<c:import url="../template/scripts.jsp"></c:import>

	<script type="text/javascript" src="/js/admin/reservation/reservation.js"></script>
	<script type="text/javascript">

		var kind = '${pager.kind}';
		if(kind == ''){
			$("#title").prop("selected", true);
		}else{
			$("#"+kind).prop("selected",true);
		}
		
	</script>

	
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


</body>
</html>
