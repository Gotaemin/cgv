<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../template/head.jsp"></c:import>

<!-- movieWrite -->
<title>관리자 페이지</title>
<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
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
					<h1>Event ${path}</h1>
					
					<div>

						<div class="contents">
							<div style="width: 410px;">

								<div class="col_content">

									<!----------------------------------------------------------------------------------------------------- contents detail -->

									<div class="col_detail">

										<!----------------------------------------------------------------------------------------------------- contents detail customer_top-->
										<div class="customer_top">
										</div>

										<!----------------------------------------------------------------------------------------------------- contents detail box_bbslist-->
										<form action="./event${path}" method="post" enctype="multipart/form-data" id="fo">
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
														   	 <label for="kind">분류:</label>
														   	 <select class="form-control" id="kind" name="kind">
														   	 	<option value="special">스페셜이벤트</option>
														   	 	<option value="movie">영화/예매</option>
														   	 	<option value="discount">제휴/할인</option>
														   	 	<option value="membership">멤버십</option>
														   	 	<option value="pub">PUB이벤트</option>
															 </select>
														  	</div>


															<div class="form-group">
																<label for="title">제목:</label>
																<input type="text" class="form-control" id="title" name="title" value="${vo.title}">
															</div>
															
															<div class="form-group" style="margin: 0;">
																<label for="files">배너 이미지:</label> 
																<span style="position: relative;">
																	<c:if test="${path  eq 'Insert'}">
																		<input type="file" class="form-control files" id="files" placeholder="배너 이미지 선택" name="files">
																	</c:if>
																	<c:if test="${path  eq 'Update' and vo.eventImageVOs[0].type eq 0}">
																		<input type="text" class="form-control files" value="${vo.eventImageVOs[0].originName}" placeholder="배너 이미지 선택" name="files" readonly="readonly">
																		
																		<i id="${vo.eventImageVOs[0].num}" class="glyphicon glyphicon-remove remove fileDelete fd0"  data-type="0" name="${vo.eventImageVOs[0].fileName}"
																		style="position: relative; top: -31px; left: 375px;">
																	    		<img alt="" class="minus" src="/images/theater/minus.png">
																	    </i>
																	</c:if>
																</span>
															</div>
															
														<%-- 	<div class="form-group">
																<label for="files">배너 이미지:</label> <input type="text"
																	class="form-control files" value="${vo.eventImageVOs[0].originName}" 
																	placeholder="배너 이미지 선택" name="files"><img alt="" class="minus" src="/images/theater/minus.png">
																	<c:if test="${path  eq 'Update' and !empty vo.eventImageVOs[0]}">
																	    <p style="margin-left:110px;">${vo.eventImageVOs[0].originName}
																	    	<i id="${vo.eventImageVOs[0].num}" class="glyphicon glyphicon-remove remove fileDelete fd0"
																	    	name="${vo.eventImageVOs[0].fileName}">
																	    		<img alt="" class="minus" src="/images/theater/minus.png">
																	    	</i>
																		</p>
																	</c:if>
															</div> --%>
															
															<div class="form-group">
																<label for="files">컨텐츠 이미지:</label>
																<span style="position: relative;">
																	<c:if test="${path  eq 'Insert'}">
																		<input type="file" class="form-control files" id="files" placeholder="컨텐츠 이미지 선택" name="files" data-type="1">
																	</c:if>
																	<c:if test="${path  eq 'Update' and vo.eventImageVOs[1].type eq 1}">
																		<input type="text" class="form-control files" value="${vo.eventImageVOs[1].originName}" placeholder="배너 이미지 선택" name="files" readonly="readonly">
																		
																		<i id="${vo.eventImageVOs[1].num}" class="glyphicon glyphicon-remove remove fileDelete fd1"  data-type="1" name="${vo.eventImageVOs[1].fileName}"
																		style="position: relative; top: -31px; left: 375px;">
																	    		<img alt="" class="minus" src="/images/theater/minus.png">
																	    </i>
																	</c:if>
																</span>
															</div>
															
															


															<div class="form-group">
																<label for="startDate">시작일:</label>
																<input type="date"
																	class="form-control" id="startDate" name="startDate"
																	value="${vo.startDate}">
															</div>

															<div class="form-group">
																<label for="endDate">마감일:</label> <input type="date"
																	class="form-control" id="endDate" name="endDate"
																	value="${vo.endDate}">
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

															<div class="form-group">
																<label for="contents">Contents:</label>
																<textarea rows="" cols="" class="form-control"
																	id="contents" name="contents">${vo.contents}</textarea>

															</div>

														</tbody>

													</table>

												</div>
													<a href="./movieList" class="round gray" id="cancle"> 
														<span style="font-size: 15px">취소</span>
													</a>
													<button id="btn" type="submit" class="round inred">
														<span style="font-size: 15px">등록하기</span>
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


		var c = '${vo.kind}';
		$('#kind option[value="'+c+'"]').prop("selected",true);

		

	</script>

</body>
</html>