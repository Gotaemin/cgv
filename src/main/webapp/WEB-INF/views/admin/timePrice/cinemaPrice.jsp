<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:import url="../template/head.jsp"></c:import>
<link rel="stylesheet" href="/css/admin/movieTime/insert.css">
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
					<h1>Cinema Price</h1>
					<p id="title">극장별 관람가격 등록</p>
					<div id="selectDatetime" class="container tab-pane fade active show">
					
						<form action="./${timePrice}" method="post">
							<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />	
						
							<div class="container">
								<div id="movieTimeInsert">
									<!-- 상단부 -->
									<div style="display:flex!important;">
										<div class="form-group">
											<label for="local">지역</label> 
											<input type="text" value="${cinemaVO.local}" class="form-control" readonly="readonly" >
										</div>
										<div class="form-group">
											<label for="cinema">영화관</label> 
											<input type="text" value="${cinemaVO.name}" class="form-control" readonly="readonly">
											<input type="hidden" name="cinemaNum" value="${cinemaVO.num}">
										</div>
										<div class="form-group">
											<label for="screenType">종류</label> 
											
											<c:if test="${timePrice eq 'update'}">
												<input type="text" id="filmType" class="form-control" name="filmType" value="" readonly="readonly">
											</c:if>
											<c:if test="${timePrice ne 'update'}">
												<select id="screenType" class="form-control" name="filmType">
													<option value="1">2D</option>
													<option value="2">3D</option>
													<option value="4">4D</option>
												</select>
											</c:if>
										</div>
									</div>
									<hr>
								
									<!-- 하단부 -->
										<button id="addUnderDataBtn" type="button" class="btn" style="padding: 0px 10px; position: absolute; right: 0px;">+</button>
										<div>
											<label for="Time" style="width: 210px!important; margin: 0 5px;">시간대</label>
											<label for="adult-price" style="width: 210px!important; margin: 0 5px;">일반가격</label>
											<label for="youth-price" style="width: 210px!important; margin:0;">청소년가격</label>
										</div>
										<div id="underData">
										
										<c:if test="${timePrice eq 'update'}">
											<c:forEach var="timePriceVO" items="${timePriceList}" varStatus="i">
												<div class="underData">
													<input type="hidden" name="num" value="${timePriceVO.num}">										
													<div class="form-group">
														<div style="display:flex!important;">
															<input type="text" class="sTime form-control timeBox" onKeyup="inputTimeColon(this);" placeholder="HH:MM" maxlength="5" required="required"/>
															 ~ 
															<input type="text" name="eTime" value="${timePriceVO.getETime()}" class="eTime form-control timeBox" onKeyup="inputTimeColon(this);" placeholder="HH:MM" maxlength="5" required="required"/>
														</div>
													</div>
													
													<div class="form-group">
														<input type="text" name="commonPrice" value="${timePriceVO.commonPrice}" class="commonPrice form-control inputbox" required="required"
															style="IME-MODE:disabled;" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
													</div>
													
													<div class="form-group">
														<input type="text" name="teenagerPrice" value="${timePriceVO.teenagerPrice}" class="teenagerPrice form-control inputbox" required="required"
															style="IME-MODE:disabled;" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
													</div>
													<div class="button_del"><button class="btn delBtn" type="button" style="width: 5%;">&nbsp;X</button></div>
													
												</div>
											</c:forEach>										
										</c:if>
										<c:if test="${timePrice ne 'update'}">
											<c:forEach begin="1" end="4">
												<div class="underData" id="default" style="display:flex!important;">
													<div class="form-group">
														<div style="display:flex!important;">
															<input type="text" class="sTime form-control timeBox" onKeyup="inputTimeColon(this);" placeholder="HH:MM" style="width: 45%;  margin: 0 auto" required="required"/>
															 ~ 
															<input type="text" name="eTime" class="eTime form-control timeBox" onKeyup="inputTimeColon(this);" placeholder="HH:MM" maxlength="5"  style="width: 45%;  margin: 0 auto" required="required"/>
														</div>
													</div>
													
													<div class="form-group">
														<input type="text" name="commonPrice" class="commonPrice form-control inputbox" required="required"
															style="IME-MODE:disabled;" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
													</div>
													
													<div class="form-group">
														<input type="text" name="teenagerPrice" class="teenagerPrice form-control inputbox" required="required"
															style="IME-MODE:disabled;" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">
													</div>
													<!-- <div style="width: 5%;">&nbsp;</div> -->
												</div>
											</c:forEach>
										
										</c:if>
											
											
											
										</div>
										
										<div class="text-center" style="float: right; margin: 20px 0;">
											<button id="submitBtn" type="submit" class="btn btn-primary">등록</button>
										</div>
										
									</div>
								</div>
							</form>
						</div>
				</div>
			</main>
			
		</div>
	</div>

	<script type="text/javascript">
		var timePrice = `${timePrice}`;
		var filmType = `${timePriceList[0].filmType}`;
		var count = 4;

		//write일때 이미 등록되어 있는 filmType 감지
		var filmTypeGroup = `${filmTypeGroup}`;

		if(filmTypeGroup != null){
			<c:forEach var="fimTypeVO" items="${filmTypeGroup}">
				var groupItem = ${fimTypeVO.filmType};
				typeMatch(groupItem);

			</c:forEach>
		}

		function typeMatch(num){
			$("#screenType option").each(function(){
				if($(this).val() == num){
					$(this).remove();

				}
			});
		}
	</script>
	<script type="text/javascript" src="/js/admin/timePrice/cinemaPrice.js"></script>
</body>
</html>
