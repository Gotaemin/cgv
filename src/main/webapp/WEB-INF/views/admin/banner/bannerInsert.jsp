<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />

<!-- movieWrite -->
<title>관리자 페이지</title>

<link rel="stylesheet" href="/css/styles.css" />
<link rel="stylesheet" href="/css/admin/movie/movie.css" />
<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
<link
	href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" crossorigin="anonymous" />

<style type="text/css">
	.minus	{
		width:16px;
		height:16px;
		margin-left:7px;
	}
	

</style>
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
					<h1>Banner ${path}</h1>
					<div>

						<div class="contents">
							<div>

								<div class="col_content">

									<!----------------------------------------------------------------------------------------------------- contents detail -->

									<div class="col_detail">

										<!----------------------------------------------------------------------------------------------------- contents detail customer_top-->
										<div class="customer_top">
											<!-- 뭐하는 부분일까요..? -->
											
											
										</div>

										<!----------------------------------------------------------------------------------------------------- contents detail box_bbslist-->
										<form action="./banner${path}" method="post" enctype="multipart/form-data" id="fo">
										<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
										<c:if test="${path eq 'Update'}">
											<input type="hidden" name="num" value="${vo.num}"> 
										</c:if>
											<fieldset>

												<div class="tbl_write">
													<!-- imgaeVO의 AI인 num -->
													<%-- <input type="hidden" value="${vo.num}" name="num"> 
													<input type="hidden" value="${vo.movieImageVOs.fileName}" id="fileName"> --%>

													<table class="tbl_bbs_write">
														<colgroup>
															<col style="width: 100px;">
															<col style="width: 320px;">
														</colgroup>
														<tbody>
															<div class="form-group">
														   	 <label for="type">타입:</label>
														   	 <select class="" id="" name="type">
														   	 	<option value="1">사이드 배너</option>
															 </select>
														  	</div>
														  	
														  	<div class="form-group">
														   	 <label for="index">분류:</label>
														   	 <select class="" id="idx" name="index">
														   	 	<option value="0">영화 광고</option>
														   	 	<option value="1">이벤트 광고</option>
															 </select>
														  	</div>

															<div class="form-group">
																<label for="title">제목:</label>
																<input type="text" class="form-control" id="title" name="title" value="${vo.title}">
															</div>
															
															<div class="form-group">
																<label for="files">배너 이미지:</label> 
																<span>
																<span>
																	<c:if test="${path  eq 'Insert'}">
																		<input type="file" class="form-control files" id="files" placeholder="배너 이미지 선택" name="files">
																	</c:if>
																	<c:if test="${path  eq 'Update'}">
																		<input type="text" class="form-control files" value="${vo.originName}" placeholder="배너 이미지 선택" name="files" readonly="readonly">
																		
																		<i id="${vo.num}" class="glyphicon glyphicon-remove remove fileDelete fd0"  data-type="0" name="${vo.fileName}">
																	    		<img alt="" class="minus" src="/images/theater/minus.png">
																	    </i>
																	</c:if>
																</span>
																</span>
															</div>
															
															<div class="form-group">
																<label for="link">이동 링크:</label>
																<input type="text" class="form-control" id="title" name="link" value="${vo.link}">
															</div>

															<div class="form-group">
																<label for="startDate">시작일:</label>
																<input type="date" class="form-control" id="startDate" name="startDate" value="${vo.startDate}">
															</div>

															<div class="form-group">
																<label for="endDate">마감일:</label>
																<input type="date" class="form-control" id="endDate" name="endDate" value="${vo.endDate}">
															</div>
														<%-- 	<c:set var="now" value="<%=new java.util.Date()%>" />
															<c:set var="sysYear">
																<fmt:formatDate value="${now}" pattern="yyyy" />
															</c:set>
															<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="i" /> --%>

															<%-- <c:if test="${path eq 'Write' }">
																<div class="form-group">
																	<label for="createAt">생성일:</label> <input type="date"
																		class="form-control" id="createAt" name="createAt"
																		value="${i}" readonly="readonly">
																</div>
															</c:if> --%>


														</tbody>

													</table>

												</div>
													<a href="./movieList" class="round gray" id="cancle"> 
														<span>취소</span>
													</a>
													<button id="btn" type="submit" class="round inred">
														<span>등록하기</span>
													</button>
											</fieldset>
										</form>

									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>

	<!-- 스크립트 -->
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
	<script type="text/javascript">

		//row, col 출력
		var idx = '${vo.index}';
		$("#idx option[value="+idx+"]").prop("selected",true);


	

		var deleteImage = [];

	
		$(".fileDelete").each(function(index){
			$(this).click(function(){

				//var test = 
			  	var check = confirm("파일을 삭제하시겠습니까?");

				if(check){
					var s = $(".fd"+index);
					var tp = s.data("type");
					alert("tp :" + tp)

					s.parent().find('input').remove();
					s.parent().parent().html('<input type="file" class="form-control files" id="files" placeholder="배너 이미지 선택" name="files">');
					
					deleteImage.push(s.attr('id'));
					alert(deleteImage);
					$("#fo").append('<input type="hidden" name="delNum" value="'+ deleteImage[deleteImage.length-1] +'">');
					
				}  
				
			});
		});



	</script>

</body>
</html>