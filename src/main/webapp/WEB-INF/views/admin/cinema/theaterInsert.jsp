<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<c:import url="../template/head.jsp"></c:import> 
	<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
	<link href="/css/admin/cinema/theaterInsert.css" rel="stylesheet" />
	<style type="text/css">
		.arrow	{
			cursor:pointer;
			z-index:10;
		}
	
		.arrow-img	{
			width:10px;
				
		}
	</style>
</head>
<body class="sb-nav-fixed">
	<c:import url="../template/header.jsp"></c:import> 
    <div id="layoutSidenav">
	<c:import url="../template/sidenav.jsp"></c:import>
		<div id="layoutSidenav_content">
		<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<main>
				<div class="container-fluid">
					<h1>Theater Insert</h1>
					<p>-상영관 추가 페이지-</p>
	                <form id="frm" action="./${board}${path}" method="post" enctype="multipart/form-data">
						<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<c:if test="${path eq 'Update'}">
							<input type="hidden" name="num" id="num" value="${vo.num}">
						</c:if>
						<div class="form-group">
							<label class="theaterLebel" for="cinemaNum">영화관:</label>
							<select class="cinemaNum selectcinenum" id="cineNum" name="cinemaNum">
								
								<c:forEach items="${cine}" var="cnt">
								<option value="${cnt.num}" name="cinemaNum">${cnt.num} / ${cnt.name}</option>
								</c:forEach>
								
 							</select>
							<br>
							<label class="theaterLebel lebelname" for="name">이름:</label>
							<input type="text" class="form-control selectcinenum" id="name" name="name" value="${vo.name}">
							<br>
							<label class="theaterLebel" for="filmType">필름타입:</label>
							<label class="ckfm"> <input type="checkbox" id="checkbox0"
								name="filmType" value="1">  <span class="checkmark">2D</span>
							</label> 
							<label class="ckfm"> <input type="checkbox" id="checkbox1"
								name="filmType" value="2">  <span class="checkmark">3D</span>
							</label> 
							<label class="ckfm"> <input type="checkbox" id="checkbox2"
								name="filmType" value="4">  <span class="checkmark">4D</span>
							</label> 
							<br> 
							<label class="theaterLebel" for="seat">좌석:</label>
							<div class="seat_box">
								<div class="seat_header">
									<div class="header_btn">
							   	 		<select class="seat_row" id="seat_row">
									   	 	<option value="1">A</option>
									   	 	<option value="2">B</option>
									   	 	<option value="3">C</option>
									   	 	<option value="4">D</option>
									   	 	<option value="5">E</option>
									   	 	<option value="6">F</option>
									   	 	<option value="7">G</option>
									   	 	<option value="8">H</option>
									   	 	<option value="9">I</option>
									   	 	<option value="10">J</option>
									   	 	<option value="11">K</option>
									   	 	<option value="12">L</option>
									   	 	<option value="13">M</option>
									   	 	<option value="14">N</option>
									   	 </select>
									   	 
									   	 <select class="seat_col" id="seat_col" onchange="">
									   	 	<option value="1">1</option>
									   	 	<option value="2">2</option>
									   	 	<option value="3">3</option>
									   	 	<option value="4">4</option>
									   	 	<option value="5">5</option>
									   	 	<option value="6">6</option>
									   	 	<option value="7">7</option>
									   	 	<option value="8">8</option>
									   	 	<option value="9">9</option>
									   	 	<option value="10">10</option>
									   	 	<option value="11">11</option>
									   	 	<option value="12">12</option>
									   	 	<option value="13">13</option>
									   	 	<option value="14">14</option>
									   	 	<option value="15">15</option>
									   	 	<option value="16">16</option>
									   	 	<option value="17">17</option>
									   	 	<option value="18">18</option>
									   	 	<option value="19">19</option>
									   	 	<option value="20">20</option>
									   	 </select>
									   	 
									   	 <!-- 아니면 select 할 때마다  script 처리 해서 바로 생성 -->
										<button type="button" onclick="changeSelect()">좌석 생성</button>
									</div><!-- end header_btn -->
								</div><!-- end seat header -->
								<div class="seat_section">
									<div class="section_btn">
										<button class="btn_del" type="button" onclick="changeGrade(0)">좌석
											삭제</button>
										<button class="btn_economy" type="button"
											onclick="changeGrade(1)">Economy</button>
										<button class="btn_standard" type="button"
											onclick="changeGrade(2)">Standard</button>
										<button class="btn_prime" type="button"
											onclick="changeGrade(3)">Prime</button>
									</div>
									<div class="contents">
										<div class="seats" id="seats_list"></div>
									</div>
								</div>
							</div>
							<!-- end seat box -->
							<br> <label for="seatCount" class="theaterLebel labelname">좌석 수:</label>
							<input type="text" class="form-control selectcinenum" id="seatCount" name="seatCount" value="${vo.seatCount}" required="required" readonly="readonly">
							<div class="btn_s">
								<input type="button" id="btn_insert" class="btn btn-default"
									value="생성" style="background-color: #eff2f8;">
							</div>
						</div>
					</form>
				</div>
			</main>

		<c:import url="../template/footer.jsp"></c:import>

		</div>
	</div>
	<c:import url="../template/scripts.jsp"></c:import>
	<script src="/js/theater/theaterInsert.js"></script>
	<script type="text/javascript">

		<c:if test="${!empty cineCheck}">
			var n = '${cineCheck.num}';
			$("#cineNum option[value="+n+"]").prop("selected",true);
		</c:if>

	</script>
</body>
</html>