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
		td	{
			line-height:120px;
		}
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
					<h1>SideBanner List</h1>
					<p>-사이드 배너 관리 페이지-</p>
					<!-- 목록 -->
					<div class="table-responsive" id="tb">
						<p style="font-weight:600;">영화 광고</p>
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
							<thead>
								<tr class="admin-tr">
									<th style="width:50px">No.</th>
									<th style="width:70px">미리보기</th>
									<th style="width:270px">제목</th>
									<th>이동링크</th>
									<th style="width:120px">시작일</th>
									<th style="width:120px">마감일</th>
									<th style="width:170px"></th>
								</tr>
							</thead>
							<tfoot>
								<tr class="admin-tr">
									<th style="width:50px">No.</th>
									<th style="width:70px">미리보기</th>
									<th style="width:270px">제목</th>
									<th>이동링크</th>
									<th style="width:120px">시작일</th>
									<th style="width:120px">마감일</th>
									<th style="width:170px"></th>
								</tr>
							</tfoot>
							
							<tbody>
								<c:forEach items="${movie}" var="vo">
									<tr class="admin-tr-each">
										<td class="ate-center">${vo.num}</td>
										<td class="ate-center">
											<img alt="" src="/images/banner/sideBanner/${vo.fileName}" style="height:120px;">
										</td>
										<td class="ate-center">${vo.title}</td>
										<td class="ate-center"><a href="${vo.link}">${vo.link}</a></td>
										<td class="ate-center">${vo.startDate}</td>
										<td class="ate-center endDate">${vo.endDate}</td>
										<td>
											<a href="./sideBannerUpdate?num=${vo.num}" class="btn btn-danger" style="width:70px;">수정</a>
											<input type="button" class="btn btn-danger de" value="삭제" style="width:70px;" onclick="del(${vo.num})">
										</td>
									</tr>
								</c:forEach>
								<!-- 페이저 -->
								
							</tbody>
							
						</table>
						
						
						<p style="font-weight:600; margin-top:50px;">이벤트 광고</p>
						<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
							<thead>
								<tr class="admin-tr">
									<th style="width:50px">No.</th>
									<th style="width:70px">미리보기</th>
									<th style="width:270px">제목</th>
									<th>이동링크</th>
									<th style="width:120px">시작일</th>
									<th style="width:120px">마감일</th>
									<th style="width:170px"></th>
								</tr>
							</thead>
							<tfoot>
								<tr class="admin-tr">
									<th style="width:50px">No.</th>
									<th style="width:70px">미리보기</th>
									<th style="width:270px">제목</th>
									<th>이동링크</th>
									<th style="width:120px">시작일</th>
									<th style="width:120px">마감일</th>
									<th style="width:170px"></th>
								</tr>
							</tfoot>
							
							<tbody>
								<c:forEach items="${event}" var="vo">
									<tr class="admin-tr-each">
										<td class="ate-center">${vo.num}</td>
										<td class="ate-center">
											<img alt="" src="/images/banner/sideBanner/${vo.fileName}" style="height:120px;">
										</td>
										<td class="ate-center">${vo.title}</td>
										<td class="ate-center">
											<a href="${vo.link}">${vo.link}</a>
										</td>
										<td class="ate-center">${vo.startDate}</td>
										<td class="ate-center endDate">${vo.endDate}</td>
										<td>
											<a href="./sideBannerUpdate?num=${vo.num}" class="btn btn-danger" style="width:70px;">수정</a>
											<input type="button" class="btn btn-danger de" value="삭제" style="width:70px;" onclick="del(${vo.num})">
										</td>
									</tr>
								</c:forEach>
								<!-- 페이저 -->
								
							</tbody>
							
						</table>
						
					<%-- 	<div class="pager">
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
						</div> --%>
					</div>
					<div class="">
						<a href="./bannerInsert" id="up" class="btn btn-mo">등록</a>
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


	    	function del(num){
	    		var check = confirm("삭제하시겠습니까?");
	    		if(check){
    				location.href="./bannerDelete?num="+num;
    			}
		    }

		    
            
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
