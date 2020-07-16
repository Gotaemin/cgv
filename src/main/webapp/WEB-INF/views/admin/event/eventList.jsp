<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<c:import url="../template/head.jsp"></c:import>
	
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	<link rel="stylesheet" href="/css/styles.css" />
	<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
	<link rel="stylesheet" crossorigin="anonymous" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"/>
	
	<title>관리자 페이지</title>
</head>
<body class="sb-nav-fixed">
	<c:import url="../template/header.jsp"></c:import>
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<!-- 로고 -->
		<a href="/admin"><img src="/images/header/h1_cgv.png"
			class="admin-logo" /></a>
		<!-- 검색 바-->
		<form
			class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
			<div class="input-group">
				<input class="form-control" type="text" placeholder="검색어를 입력"
					aria-label="Search" aria-describedby="basic-addon2" />
				<div class="input-group-append">
					<button class="btn btn-primary" type="button">
						<i class="fas fa-search"></i>
					</button>
				</div>
			</div>
		</form>
		<!-- 로그인-->
		<ul class="navbar-nav ml-auto ml-md-0">
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" id="userDropdown" href="#"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
				<div class="dropdown-menu dropdown-menu-right"
					aria-labelledby="userDropdown">
					<a class="dropdown-item" href="/">메인 페이지로</a> 
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberLogout">로그아웃</a>
				</div>
			</li>
		</ul>
	</nav>

	<!-- 사이드바 -->
	<div id="layoutSidenav">
		<c:import url="../template/sidenav.jsp"></c:import>
		
		<div id="layoutSidenav_content">
			<input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<main>
				<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div class="container-fluid">
					<h1>Event List</h1>
					<ol class="cinema-ol">
						<li class="breadcrumb-item active"><a href="./eventList">전체보기</a></li>
						<li class="breadcrumb-item active"><a href="#" class="kind" id="special">SPECIAL</a></li>
						<li class="breadcrumb-item active"><a href="#" class="kind" id="movie">영화/예매</a></li>
						<li class="breadcrumb-item active"><a href="#" class="kind" id="discount">제휴/할인</a></li>
						<li class="breadcrumb-item active"><a href="#" class="kind" id="membership">멤버십/CLUB</a></li>
						<li class="breadcrumb-item active"><a href="#" class="kind" id="pub">PUB이벤트</a></li>
					</ol>


					<!-- 목록 -->
					<div class="table-responsive" id="tb">
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
							<thead>
								<tr class="admin-tr">
									<th style="width:200px">No.</th>
									<th style="width:200px">분류</th>
									<th>제목</th>
									<th style="width:200px">시작일</th>
									<th style="width:200px">마감일</th>
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
						<div class="pager">
							<ul class="pagination">
								<c:if test="${pager.curBlock>1}">
									<li><a href="#" class="custompager"
										title="${pager.startNum-1}">이전</a></li>
								</c:if>

								<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="p">
									<li><a href="./eventList?curPage=${p}" class="custompager" title="${p}">${p}</a></li>
								</c:forEach>

								<c:if test="${pager.curBlock<pager.totalBlock}">
									<li><a href="#" class="custompager"
										title="${pager.lastNum+1}">다음</a></li>
								</c:if>
							</ul>
						</div>
					</div>
					<div class="">
						<a href="./eventInsert" id="up" class="btn btn-primary">Insert</a>
                    </div>
				</div>
			</main>
			<c:import url="../template/footer.jsp"></c:import>
		</div>
	</div>
	<c:import url="../template/scripts.jsp"></c:import>
	<script type="text/javascript">
        	
        	console.log("ㅎㅎ");
         	$(".kind").click(function(){
             	//alert($(this).attr("id"))
				kind = $(this).attr("id");

				$.post("./selectKind",{"kind":kind, "_csrf": $("#_csrf").val()},function(data){
					console.log(data);
					$("#tb").html(data);
				});
            }); 


			

            
		</script>
		
		<script src="js/scripts.js"></script>
		<script src="assets/demo/chart-bar-demo.js"></script>
		<script src="assets/demo/chart-area-demo.js"></script>
		<script src="assets/demo/datatables-demo.js"></script>
		<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
		<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
		<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/js/all.min.js" crossorigin="anonymous"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    </body>
</html>