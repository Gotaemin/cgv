<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../template/head.jsp"></c:import>
<title>관리자 페이지</title>
<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
</head>

<body class="sb-nav-fixed">
	<c:import url="../template/header.jsp"></c:import> 
	<div id="layoutSidenav">
		<c:import url="../template/sidenav.jsp"></c:import>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid">
					<h1>Event Info</h1>
					<div class="" style="float:right; margin-top:-50px;">

						<a href="./eventUpdate?num=${vo.num}" id="up" class="btn-mo">수정</a>
                    	<span id="de" class="btn btn-danger">삭제</span>

                    </div>
					<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<tr class="admin-tr">
								<th style="width:200px">${vo.num}</th>
								<th style="width:200px">${vo.kind}</th>
								<th>${vo.title}</th>
								<th style="width:200px">시작일 : ${vo.startDate}</th>
								<th style="width:200px">종료일 : ${vo.endDate}</th>
							</tr>
						</thead>
					</table>
                        
                     
					<div class="card mb-4">
						<div class="card-body">
							<p class="mb-0" style="display:inline-block; width:50%; float:left;">
								<code>배너 이미지</code><br>
								<span style="width:100%"><img src="/images/event/eventList/eventImage/${vo.eventImageVOs[0].fileName}"/></span>
								<br>
								<br>
								<code>이벤트 상세 내용</code><br>
								<span>${vo.contents}</span>
								
							
							</p>
							<p class="mb-0" style="display:inline-block; width:50%; float:left;">
								<code>콘텐츠 이미지</code><br>
								<span><img src="/images/event/eventList/eventImage/${vo.eventImageVOs[1].fileName}" style="width:100%"/></span>
							
							</p>
						</div>
					</div>
				
				</div>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2020</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
			</footer>
		</div>
	</div>
	<script type="text/javascript">
		//delete submit
		$("#de").click(function(){
			//정말 삭제할 거냐고 묻는 alert창
			var check = confirm("삭제하시겠습니까?");
			if(check){
				location.href="./eventDelete?num="+${vo.num};
			}
		});
	</script>
</body>
</html>