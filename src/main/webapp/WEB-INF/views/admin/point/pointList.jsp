<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../template/head.jsp"></c:import>
<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
<link rel="stylesheet" href="/css/admin/point/pointList.css" />

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
					<h1>Point List</h1>
					<p>-포인트 사용 내역 페이지-</p>

					<form action="./pointHistoryList" id="form-Data" class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0" style="float:right; padding-bottom: 20px;display:flex!important; " >
						<input type="hidden" id="curPage" name="curPage" value="${pager.curPage}">
						<div class="form-group">
							<label>시작일</label>
							<input class="form-control" type="date" name="startDate">
							&nbsp;&nbsp;&nbsp;&nbsp;~
							<label>종료일</label>
							<input class="form-control" type="date" name="endDate">
						</div>
					
						<div class="form-group" style="padding: 0 10px; text-align: right; ">
							<select class="form-control col-md-12" name="kind">
								<option class="type" id="all" value="" selected="selected">CJ+CGV포인트</option>
								<option class="type" id="cjOnePoint" value="cjOnePointipt">CJ포인트</option>
								<option class="type" id="cgvPoint" value="cgvGiftPrePayipt">CGV포인트</option>
							</select>
						</div>
						
						
						<div class="input-group" >
							<input class="form-control" name="search" value="${pager.search}" type="text" placeholder="아이디를 입력" aria-label="Search" aria-describedby="basic-addon2" />
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
									<th>ID</th>
									<th>적립금액</th>
									<th>사용금액</th>
									<th>종류</th>
									<th>사용날짜</th>
								</tr>
							</thead>
							<tfoot>
								<tr class="admin-tr">
									<th>No.</th>
									<th>ID</th>
									<th>적립금액</th>
									<th>사용금액</th>
									<th>종류</th>
									<th>사용날짜</th>
								</tr>
							</tfoot>
							<tbody id="tb">
								<c:forEach items="${pointHistoryList}" var="vo">
									<tr class="admin-tr-each">
										<td class="num ate-center">${vo.num}</td>
										<td class="ate-center"><a>${vo.username}</a></td>
										<td class="price ate-center">${vo.inputPrice}</td>
										<td class="price ate-center">${vo.outputPrice}</td>
										<td class="type ate-center">${vo.type}</td>
										<td class="ate-center">${vo.createAt}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

						<div>
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
	
		var kind = '${pager.kind}';
		switch(kind){
		case '' :
			$("#all").prop("selected", true);
			break;
		case 'cjOnePointipt' :
			$("#cjOnePoint").prop("selected", true);
			break;
		case 'cgvGiftPrePayipt' :
			$("#cgvPoint").prop("selected", true);
			break;
		}

	</script>
	<script type="text/javascript" src="/js/admin/point/pointList.js"></script>
</body>
</html>

        
