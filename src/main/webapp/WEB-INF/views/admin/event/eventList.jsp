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
	<style type="text/css">

	</style>
</head>
<body class="sb-nav-fixed">
	<c:import url="../template/header.jsp"></c:import>

	<!-- 사이드바 -->
	<div id="layoutSidenav">
		<c:import url="../template/sidenav.jsp"></c:import>
		
		<div id="layoutSidenav_content">
			<input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<main>
				<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
				<div class="container-fluid">
					<h1>Event List</h1>
					<p>-이벤트 목록 페이지-</p>
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
										<td class="ate-center endDate">${vo.endDate}</td>
							
									</tr>
								</c:forEach>
							</tbody>
							
						</table>
						<!-- 페이저 -->
						<div class="pager" style="display: flex; justify-content: center;">
							<ul class="pagination">
							
								<c:if test="${pager.curBlock>1}">
									<li class="page-item"><a href="${pager.startNum-1}" class="page-link custompager" title="${pager.startNum-1}">이전</a></li>
								</c:if>
								
								<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="p">
									<li class="page-item"><a href="./eventList?curPage=${p}" class="page-link custompager" title="${p}">${p}</a></li>
								</c:forEach>

								<c:if test="${pager.curBlock<pager.totalBlock}">
									<li class="page-item"><a href="${pager.lastNum+1}" class="page-link custompager" title="${pager.lastNum+1}">다음</a></li>
								</c:if>
								
							</ul>
							<div style="position: absolute; left: 40px;">
								<a href="./eventInsert" id="up" class="btn btn-primary" style="font-size: 15px;">이벤트 추가</a>
                    		</div>
						</div>
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


    		//현재 날짜보다 시간이 빠르면 css 입힘(가독성용)
    		var nowDate = new Date();
    		console.log("now : "+nowDate) 
    		$(".endDate").each(function(){

    			var date = new Date($(this).text()+ "T23:59:59");
    			console.log(date)
    			if(nowDate >= date){
    				$(this).parent().css("backgroundColor","gray")
    			}

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
