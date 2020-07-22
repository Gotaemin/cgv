<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<c:import url="../template/head.jsp"></c:import>
	<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
	<style type="text/css">
	.review_delete {
		height: 30px; font-size: small;
	}
	</style>
</head>
<body class="sb-nav-fixed">
	<c:import url="../template/header.jsp"></c:import>
	<div id="layoutSidenav">
		<c:import url="../template/sidenav.jsp"></c:import>
		
		<div id="layoutSidenav_content">
			<input id="_csrf" type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<main>
				<div class="container-fluid">
					<h1>Review Accusation</h1>
					<p>-리뷰 관리 페이지-</p>
					<!-- 검색 -->
					<p>
					<div class="input-group" style="width: 400px; position: unset; ">
						<select id="searchTag" name="searchTag" style="color: #495057; border: 1px solid #ced4da; border-right: none;">
						    <option value="title">영화제목</option>
						    <option value="uid">아이디</option>
						    <option value="contents">내용</option>
						</select>
						
						<input id="searchTxt" class="form-control" type="text" placeholder="찾으실 내용을 입력해주세요" aria-label="Search" aria-describedby="basic-addon2" />
						
						<div class="input-group-append">
							<button id="searchBtn" class="btn btn-primary" type="button">
								<i class="fas fa-search"></i><!-- 돋보기 아이콘 -->
							</button>
						</div>
						


						<div style="position: absolute; right: 129px;"><button class="btn btn-info" id="cancelDelete">신고취소</button></div>
						<div style="position: absolute; right: 42px;"><button class="btn btn-danger" id="partDelete">신고삭제</button></div>

					</div>
					
					
					</p>
					
					<!-- 목록 -->
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr class="admin-tr"> <!-- 8개 -->
									<th><input type="checkbox" id="d1"></th>
									<th>No.(리뷰번호)</th>
									<th>예매번호</th> 
									<th>영화제목</th>
									<th>아이디</th> 
									<th>내용</th>
									<th>작성시간</th>
									<th>스포일러 신고</th>
									<th>욕설비방 신고</th>
									<th>삭제</th>
								</tr>
							</thead>

							<tbody id="tb">
								 <c:forEach items="${list}" var="vo"> 
									<tr class="admin-tr-each">
										<td class="ate-center" style="width: 3%;">
											<input style="width:13px;" type="checkbox" class="c1" data-num="${vo.reservationNum}">
										</td>
										<td class="ate-center" style="width: 8%;">${vo.num}</td>
										<td class="ate-center" style="width: 6%;">${vo.reservationNum}</td>
										<td class="ate-center" style="width: 15%;">${vo.title}</td>
										<td class="ate-center" style="width: 10%;">${vo.uid}</td>
										<td class="ate-center">${vo.contents}</td>
										<td class="ate-center" style="width: 8%;">${vo.createAt}</td>
										<td class="ate-center" style="width: 8%;">${vo.spoiler}</td>
										<td class="ate-center" style="width: 8%;">${vo.swearword}</td>
										<td class="ate-center" style="width: 6%;">
											<button class="btn btn-danger review_delete" data-delete_num="${vo.reservationNum}">삭제</button>
										</td>
									</tr>
								 </c:forEach> 
							</tbody>
						</table>


						<!-- 페이저 -->
						<div class="pager">
							<ul class="pagination">
								<c:if test="${pager.curBlock gt 1}">
									<li><a href="./adminReview?curPage=${pager.startNum - 1}&kind=${pager.kind}&search=${pager.search}" class="page-link custompager"
										title="${pager.startNum-1}">이전</a></li>
								</c:if>

								<c:forEach begin="${pager.startNum}" end="${pager.lastNum}"
									var="p">
									<li><a href="./adminReview?curPage=${p}&kind=${pager.kind}&search=${pager.search}" class="page-link custompager" title="${p}">${p}</a></li>
								</c:forEach>

								<c:if test="${pager.curBlock lt pager.totalBlock}">
									<li><a href="./adminReview?curPage=${pager.lastNum + 1}&kind=${pager.kind}&search=${pager.search}" class="page-link custompager"
										title="${pager.lastNum+1}">다음</a></li>
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
	
	<!-- 스크립트 -->
	<script type="text/javascript">
		/* 검색 기능 */
		$("#searchBtn").click(function() {

			var searchTag = $("#searchTag").val();
			var searchTxt = $("#searchTxt").val();
			location.href = "./adminReview?curPage=&kind="+searchTag+"&search="+searchTxt;
		});

		//전체선택
		$("#d1").click(function(){
			$(".c1").prop("checked", $("#d1").prop("checked")); //prop("checked",true)
		});

		//부분선택
		$(".c1").click(function(){
			var result = true;

			$(".c1").each(function(){
				if(!$(this).prop("checked")){
					result=false;
				}
			});

			$("#d1").prop("checked",result);
		});

		
		/* 신고 취소 */
		$("#cancelDelete").click(function(item){
			var result=0;
			var result2 = [];

			if(confirm("선택한 리뷰의 신고내역을 초기화 하시겠습니까?")){
				$(".c1").each(function(){
					if($(this).prop("checked")){
						result = $(this).attr("data-num");
						result2.push(result); //배열
					}
				});

 				$.ajax ({
					type:"GET",
					url:"./cancelDelete",
					traditional: true,
					data:{
						num : result2,
					},
					success:function(data){
						alert("해당 리뷰 신고초기화 완료");
						location.reload();
						
					}
				})	 
			}
		});

		/* 부분 삭제 */
		$("#partDelete").click(function(item){
			var result=0;
			var result2 = [];

			if(confirm("선택한 리뷰를 삭제 하시겠습니까?")){
				$(".c1").each(function(){
					if($(this).prop("checked")){
						result = $(this).attr("data-num");
						result2.push(result); //배열
					}
				});

 				$.ajax ({
					type:"GET",
					url:"./partDelete",
					traditional: true,
					data:{
						num : result2,
					},
					success:function(data){
						alert("리뷰삭제 완료");
						location.reload();
						
					}
				})	 
			}
		});

		/* 리뷰 1개 삭제 */
		$(".review_delete").click(function(){
			if(confirm("정말 삭제하시겠습니까?")){
			var reservationNum = $(this).attr("data-delete_num");
			console.log("reservationNum: "+reservationNum);
			$.ajax ({
				type:"GET",
				url:"./adminReviewDelete",
				data:{
					reservationNum : reservationNum,
				},
				success:function(data){
					alert("리뷰삭제 완료");
					location.reload();
					
				}
			})
			}
		})
		
		
		
	</script>
	
</body>
</html>