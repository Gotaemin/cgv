<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<c:import url="../template/head.jsp"></c:import> 
	<link rel="stylesheet" href="/css/admin/cinema/cinemaList.css" />
	<style type="text/css">
		.form-control	{
			width:500px;
		}
	</style>
</head>
<body class="sb-nav-fixed">
		<c:import url="../template/header.jsp"></c:import> 
        <div id="layoutSidenav">
            <c:import url="../template/sidenav.jsp"></c:import>
            <div id="layoutSidenav_content">
				<main>
					<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="container-fluid">
						<h1>Cinema ${path}</h1>
						<br>
						<div>
						<form action="cinema${path}" method="post" enctype="multipart/form-data">
	                    	<input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<c:if test="${path eq 'Update'}">
								<input type="hidden" name="num" id="num" value="${vo.num}">
							</c:if>
	
								
						  <div class="form-group">
						   	 <label for="name">상영관명:</label>
						   	 <input type="text" class="form-control" id="name" name="name" value="${vo.name}" required="required">
						  </div>
						  
						  <div class="form-group">
						   	 <label for="local">지역:</label>
						   	 <select class="form-control" id="local" name="local">
						   	 	<option value="서울">서울</option>
						   	 	<option value="경기">경기</option>
						   	 	<option value="인천">인천</option>
						   	 	<option value="강원">강원</option>
						   	 	<option value="대전/충청">대전/충청</option>
						   	 	<option value="대구">대구</option>
						   	 	<option value="부산/울산">부산/울산</option>
						   	 	<option value="경상">경상</option>
						   	 	<option value="광주/전라/제주">광주/전라/제주</option>
							 </select>
						  </div>
						  
						  <div class="form-group">
						   	 <label for="address">주소:</label>
						   	 <input type="text" class="form-control" id="address" name="address" value="${vo.address}" required="required">
						  </div>
						  
						  <div class="form-group">
						   	 <label for="tel">전화번호:</label>
						   	 <input type="text" class="form-control" id="tel" name="tel" value="${vo.tel}" required="required"
						   	  onKeyup="this.value=this.value.replace(/[^0-9][-]/g,'');">
						  </div>
						  
						  <div class="form-group">
						   		<label for="totalTheater">총 관수:</label>
						   	 <input type="text" class="form-control" id="totalTheater" name="totalTheater" value="${vo.totalTheater}" readonly="readonly">
						  </div>
						  
						  <div class="form-group">
						   		<label for="totalSeat">총 좌석수:</label>
						   	 <input type="text" class="form-control" id="totalSeat" name="totalSeat" value="${vo.totalSeat}" readonly="readonly">
						  </div>
						  
						  
						  <div class="form-group">
						   		<label for="trafficInfo">교통정보:</label>
						   	 <input type="text" class="form-control" id="trafficInfo" name="trafficInfo" value="${vo.trafficInfo}" required="required">
						  </div>
						  
						  
						  <div class="form-group">
						   		<label for="parkingInfo">주차정보:</label>
						   	 <input type="text" class="form-control" id="parkingInfo" name="parkingInfo" value="${vo.parkingInfo}" required="required">
						  </div>
						  
						  <div class="form-group">
						   		<label for="intro">영화관 소개:</label>
						   	 <input type="text" class="form-control" id="intro" name="intro" value="${vo.intro}" required="required">
						  </div>


			

						  <button type="submit" class="btn-mo">등록</button>
						</form>
					


					</div>
				</main>
                <c:import url="../template/footer.jsp"></c:import>
            </div>
        </div>
        <c:import url="../template/scripts.jsp"></c:import>
		<script type="text/javascript" src="/js/admin/cinema/cinema.js"></script>
		<script type="text/javascript">


	    
		var c = '${vo.local}';
		$('#local option[value="'+c+'"]').prop("selected",true);
	

		$("#name").blur(function(){
			if($(this).val()!=""){
				var cinemaName = $("#name").val();
				$.get("./cinemaNameCheck",{
						name:cinemaName
					},function(result){
						if(result == 1){
							alert("이미 존재하는 극장 이름입니다.")
							$("#name").val("");
						}else{
							alert("사용 가능한 이름입니다.")
						}
				});
			}
		});
		</script>

    </body>
</html>