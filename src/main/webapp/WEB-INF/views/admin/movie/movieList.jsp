	<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../template/head.jsp"></c:import>
<link rel="stylesheet" href="/css/admin/movie/movie.css" />
</head>
<body class="sb-nav-fixed">

<c:import url="../template/header.jsp"></c:import>
	<!-- 사이드바 -->
	<div id="layoutSidenav">
		<c:import url="../template/sidenav.jsp"></c:import>

		<!-- 내용 -->
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid">
					<h1>movie List</h1>
					<p>-영화 목록 페이지-</p>

					<div style="display: flex; justify-content: space-between;">
					<!-- 검색바 -->
					<form
						class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0"
						style="margin: 0px!important;">
						<div class="input-group">
							<input class="form-control" type="text" placeholder="검색어를 입력"
								aria-label="Search" aria-describedby="basic-addon2" id="searchM"/>
							<div class="input-group-append">
								<button class="btn btn-primary admin_search" type="button" id="admin_search" name="search">
									<i class="fas fa-search"></i>
								</button>
							</div>
						</div>
					</form>
					<!-- 정렬바 -->
						<div class="sect-sorting" style="margin: 0; display: flex;">
							<select id="selectA" name="kind" class="form-control">
								<option title="1" value="rate" >예매율순</option>
								<option title="2" value="date" selected="selected">최신순</option>
								<option title="3" value="title">제목순</option>
							</select>
							<!-- <input type="button" id="admin_sort" value="go"> -->
							<button id="admin_sort" type="button" class="btn btn-success"
							style="margin-left: 5px;">
								<span>GO</span>
							</button>
						</div>
					</div>

					<div class="col_detail">
						<!-- 목록 -->
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<tr class="admin-tr" style="font-weight: 600;">
								<td>제목</td>
								<td>영문제목</td>
								<td>상영시간</td>
								<td>감독</td>
								<td>배우</td>
								<td>장르</td>
								<td>연령가</td>
								<td>국가</td>
								<td>개봉일</td>
								<td>관람객 수</td>
								<td>평점</td>
							</tr>
							<!-- 반복 -->
							<!-- 이름 누르면 상세 페이지로 이동 -->
							<c:forEach items="${list}" var="vo">
								<tr class="memberList-c">
									<td> <a href="/admin/movie/movieSelect?num=${vo.num}">${vo.title}</a></td>
									<td>${vo.titleEng}</td>
									<td>${vo.runtime}</td>
									<td>${vo.director}</td>
									<td>${vo.actor}</td>
									<td>${vo.ganre}</td>
									<td>${vo.ageLimit}</td>
									<td>${vo.country}</td>
									<td>${vo.openDate}</td>
									<td>${vo.visitor}</td>
									<td>${vo.rate}</td>
								</tr>
							</c:forEach>
						</table>

						<!-- 페이저 -->
						<div class="pager" style="position: relative;">
							<ul class="pagination">

								<c:if test="${pager.curBlock gt 1}">
									<li><a href="./movieList?curPage=${pager.startNum-1}&kind=${pager.kind}" class="custompager page-link" title="${pager.startNum-1}">이전</a></li>
								</c:if>

								<c:forEach begin="${pager.startNum}" end="${pager.lastNum}" var="p">
									<li class="page-item"><a href="./movieList?curPage=${p}&kind=${pager.kind}" class="page-link" title="${p}">${p}</a></li>
								</c:forEach>

								<c:if test="${pager.curBlock<pager.totalBlock}">
									<li><a href="./movieList?curPage=${pager.lastNum+1}&kind=${pager.kind}" class="custompager page-link" title="${pager.lastNum+1}">다음</a></li>
								</c:if>
							</ul>
							<!-- 글쓰기 버튼 -->
							<a href="./movieWrite"><button id="btn-submit" type="button" class="btn" 
							style="background-color: #dee2e6; position: absolute; right: 0px;">영화 추가</button></a>					
						</div>
						
					</div>
				</div>
			</main>
			<c:import url="../template/footer.jsp"></c:import>
		</div>
	</div>

	<!-- 스크립트 -->
	<c:import url="../template/scripts.jsp"></c:import>
	<script type="text/javascript" src="/js/movie/adminList.js"></script>
	
	<!-- <script type="text/javascript">
	
	$("#admin_sort").click(function(){
		var kind = $("#selectA").val();
		console.log(kind+"관리자 정렬");
		location.href = "./movieList?kind="+kind;
	});

	$(document).ready(function() {
		//url로 들어오는 파라미터값 읽어들이기
		function getParam(sname) {

		    var params = location.search.substr(location.search.indexOf("?") + 1);
		    var sval = "";
		    params = params.split("&");
		    for (var i = 0; i < params.length; i++) {
		        temp = params[i].split("=");
		        if ([temp[0]] == sname) { sval = temp[1]; }
		    }
		    return sval;
		}
		
		
		//읽어들인 파라미터값으로 selected값 변경
		$("select option[value='"+getParam("kind") +"']").attr("selected", true);
	});
	
	</script> -->
</body>
</html>