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
					<h1>Theater Update</h1>
					<p>-영화관 정보 수정 페이지-</p>
					<form id="frm" action="./${board}${path}" method="post"
						enctype="multipart/form-data">
						<input type="hidden" id="_csrf" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
						<c:if test="${path eq 'Update'}">
							<input type="hidden" name="num" id="num" value="${theater.num}">
						</c:if>
						<div class="form-group">
							<label class="theaterLebel" for="cinemaNum">영화관:</label> <input
								type="text" class="form-control selectcinenum" id="name"
								value="${cine.num} / ${cine.name}" readonly="readonly">
							<input type="hidden" name="cinemaNum" value="${cine.num}">
							<br> <label class="theaterLebel lebelname" for="name">이름:</label>
							<input type="text" class="form-control selectcinenum" id="name"
								name="name" value="${theater.name}"> <br> <label
								class="theaterLebel" for="filmType">필름타입:</label> <label
								class="ckfm"> <input type="checkbox" class="filmType"
								name="filmType" value="1"> 2D <span class="checkmark"></span>
							</label> <label class="ckfm"> <input type="checkbox"
								class="filmType" name="filmType" value="2"> 3D <span
								class="checkmark"></span>
							</label> <label class="ckfm"> <input type="checkbox"
								class="filmType" name="filmType" value="4"> 4D <span
								class="checkmark"></span>
							</label>
							<c:forEach items="${filmType}" begin="${i.index}"
								end="${i.index}" var="f">
								<c:forEach items="${f}" var="m">
									<c:if test="${m eq 1}">
										<input type="hidden" class="ft" value="${m}">
										<!-- 2D -->
									</c:if>
									<c:if test="${m eq 2}">
										<input type="hidden" class="ft" value="${m}">
										<!-- 3D -->
									</c:if>
									<c:if test="${m eq 4}">
										<input type="hidden" class="ft" value="${m}">
										<!-- 4D -->
									</c:if>
								</c:forEach>
							</c:forEach>
							<br> <label class="theaterLebel" for="seat">좌석:</label>

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
										</select> <select class="seat_col" id="seat_col" onchange="">
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
									</div>
									<!-- end header_btn -->
								</div>
								<!-- end seat header -->
								<div class="seat_section">
									<div class="section_btn">

										
										<button class="btn_stop" type="button" onclick="changeGrade(4)">예매 중단</button>
										<button class="btn_economy" type="button" onclick="changeGrade(1)">Economy</button>
										<button class="btn_standard" type="button" onclick="changeGrade(2)">Standard</button>
										<button class="btn_prime" type="button" onclick="changeGrade(3)">Prime</button>
										<button class="btn_del" type="button" onclick="changeGrade(0)">좌석 삭제</button>
								 	</div><!-- end section_btn -->
							 		<div class="contents">
							 			<div class="seats" id="seats_list">
								
										</div>
							 		</div>
								</div><!-- end seat section -->
							</div><!-- end seat box -->
							<br>
							<label for="seatCount">SeatCount:</label>
	 						<input type="text" class="form-control selectcinenum" id="seatCount" name="seatCount" value="${vo.seatCount}">
							
							<div class="btn_s">
								<input type="button" id="btn_insert2" class="btn btn-default"
									value="수정" style="background-color: #eff2f8;">
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
		
		//filmType 출력
 	    $(".ft").each(function(){
 	 	    var num = $(this).val();

 	 	  	$(".filmType").each(function(){
	  	     	if($(this).val()==num){
					$(this).prop('checked', true);
	  	  	    }
 	 	  	});
  	  	});

		

		//row, col 출력
		var r = '${rowIdx}';
		var c = '${colIdx}';
		console.log("row : " + r);
		console.log("col : " + c);
		$("#seat_row option[value="+r+"]").prop("selected",true);
		$("#seat_col option[value="+c+"]").prop("selected",true);



		//seat list
		var list = [];
		var rowList = [];
		var colList = [];
		var stopList = [];


		var seatCount = 0;
		var seatColor = 1;

		function spaceVO(){
			var l = [space, num]
			spaceList.push(vo);
		}
		
		
		function changeGrade(grade){
			seatColor = grade;
		}

		
		function makeVo1(row, col, grade){
			var vo = {
				"row":row,
				"col":col,
				"grade":grade
			}

			list.push(vo);
		}
		

		

		//default changeSelect function
		seatSelect();
		function seatSelect(){
			var row = $("#seat_row").val();
			var col = $("#seat_col").val();
			seatCount = ${theater.seatCount};
			$("#seatCount").val(${theater.seatCount}); //DB에서 검색한 값 넣어주기

			for(i=0; i<row; i++){
				var ch = String.fromCharCode(i+65);

				console.log("ch : " + ch);
				 src="../images/login/btn_home.png">	
				
				$("#seats_list").append('<div class="seat_row r'+(i+1)+'"><div class="bo">'
				+'<span class="row_plus" onclick="rowPlus('+i+')"><img src="/images/theater/plus.png" id="img"></span>'
				+'<div class="label">'+ch+'</div><div class="seat_group" id="r'+i+'">');
				

					for(j=1; j<=col; j++){
						//makeVo(ch, j, 1);

						$("#r"+i).append('<div class="seat c'+j+'"><span class="" onclick="checkSeat('+ch+j+')"  name="'+ch+j+'" id="'+ch+j+'"><span class="no">'+j+'</span></span></div>')	
						
						//첫번째 로우라면  버튼 만들기
						if(i<1){
						$("#r"+i).find(".c"+j).append(
						'<span class="col_plus" onclick="colPlus('+j+')"><img src="/images/theater/plus.png" id="img"></span>'+
						'<div class="col_label">'+j+'</div>');
						}

						//일단 grade=0으로 list 생성 후 아래에서 grade 수정한 값으로 삽입
						makeVo1(ch, j, 0);
						
					}

					$("#r"+i).append('<span id="arrow'+i+'" class="arrow" name="'+ch+'"><img src="../../images/theater/arrow.png" class="arrow-img" /></span>')
					
				$("#seats_list").append('</div></div>');		
				listLength = list.length;
			}
			//마지막 행, 열의 space 조정 버튼 지우기
			$(".c"+col).find(".col_plus").remove();
			$(".r"+row).find(".row_plus").remove();

		    <c:forEach items="${seatList}" var="vo" varStatus="i">
	    		var num=col*row;
	    		for(i=0; i<num; i++){
					if(list[i].row == `${vo.rowIdx}` && list[i].col == `${vo.colIdx}`){
						//console.log(${i.index});
						list[i].grade = `${vo.grade}`;
						//console.log("-----------:"+list[${i.index}].grade);
					}
					console.log(list[i]);
	    		}
				
	
	     	    //list.push(seatVO);   
  		    </c:forEach>
			
		}
		

		//list에 값 넣는 function
		function makeVo(row, col, grade){
			var vo = {
				"row":row,
				"col":col,
				"grade":grade
			}

			list.push(vo);
		}



		//list에 값 넣기
	    <c:forEach items="${seatList}" var="vo" varStatus="i">
	    		console.log("밀크티");
	    		console.log(list[${i.index}]);
	    		console.log(`${vo.grade}`);
				if(list[${i.index}].row == `${vo.rowIdx}` && list[${i.index}].col == `${vo.colIdx}`){
					console.log(${i.index});
					list[${i.index}].grade = `${vo.grade}`;
					console.log("-----------:"+list[${i.index}].grade);
				}
				console.log(list[${i.index}]);

	       //list.push(seatVO);   
	    </c:forEach>

	    console.log("---test---");
	    console.log(list);
	    console.log(list.length);


	    //stop_list에 값 넣기
	    <c:forEach items="${stopSeat}" var="vo">
	  		  var vo = {
				"r":'${vo.rowIdx}',
				"c":${vo.colIdx}
			}
	    	stopList.push(vo);
		    console.log(stopList);
	    </c:forEach>
		

		//seat color
		//grade가 ?라면 ?클래스주기
		//List 돌려서 ...검사하기...
	 	for(i=0; i<list.length; i++){
			
			//span태그 전체가 매개변수로 들어가는 함수 checkSeat
			//조합해서 function 실행
			var com = list[i].row + list[i].col;
			console.log("com : " + com);
			
			if(list[i].grade==0){
				$("#"+com).addClass("rating_delete");
				//$("#"+com).attr("class","del");
			}else if(list[i].grade==1){
				$("#"+com).addClass("rating_economy");
			}else if(list[i].grade==2){
				$("#"+com).addClass("rating_standard");
			}else if(list[i].grade==3){
				$("#"+com).addClass("rating_prime");
			}else if(list[i].grade==4){
				$("#"+com).addClass("rating_stop");
			}
			
		}
		
		//stop color
		for(i=0; i<stopList.length; i++){
			var com = stopList[i].r + stopList[i].c;
			console.log("test : " + com);

			$("#"+com).addClass("rating_stop");
		}



		//default seatSpace
		
		var seatSpaceList = [];
		<c:forEach items="${seatSpaceList}" var="seatSpaceVO">
			var seatSpaceVO = {
			      type : `${seatSpaceVO.rowOrCol}`,
			      index : `${seatSpaceVO.index}`
			};
			seatSpaceList.push(seatSpaceVO);
		</c:forEach>

		
	
		//좌석 빈칸 띄우기
		for(i=0;i<seatSpaceList.length;i++){
			var type = seatSpaceList[i].type;
			var index = seatSpaceList[i].index;
	
			console.log(type +" : "+index);
	
			
			//행띄우기
			if(type == 0){
				var c = '.r'+index;
				$(c).after('<p class="row_space rs'+index+'"></p>');
				rowList.push(index);
	
				$(c).find(".row_plus").attr("onclick","rowMinus("+(i)+");");
				$(c).find(".row_plus").find("#img").attr("src","/images/theater/minus.png");
				$(c).find(".row_plus").attr("class","row_minus");
			}else if(type == 1){
				var c = ".c"+index;
				console.log(c);
				$(".c"+index).after('<span class="col_space cs'+index+'">　</span>')
				colList.push(index);
	
				$(c).find(".col_plus").attr("onclick","colMinus("+index+");");
				$(c).find(".col_plus").find("#img").attr("src","/images/theater/minus.png");
				$(c).find(".col_plus").attr("class","col_minus");
	
				
			}
			
		}



		/////////////////////////////////////////////////////////////////////////////
		function changeSelect(){
			$("#seats_list").empty();
			list.length = 0;
			rowList.length = 0;
			colList.length = 0;
				
			var row = $("#seat_row").val();
			var col = $("#seat_col").val();
			console.log("생성한 row : " +row);
			console.log("생성한 col : " +col);

			seatCount = row * col;
			$("#seatCount").val(seatCount);
			
			//1 2 3 4 5 6 7 8 
			//1 -> 65  
			for(i=0; i<row; i++){
				var ch = String.fromCharCode(i+65);

				console.log("ch : " + ch);
				 src="../images/login/btn_home.png">	
				
				$("#seats_list").append('<div class="seat_row r'+(i+1)+'"><div class="bo">'
				+'<span class="row_plus" onclick="rowPlus('+i+')"><img src="/images/theater/plus.png" id="img"></span>'
				+'<div class="label">'+ch+'</div><div class="seat_group" id="r'+i+'">');
				
				
			
				for(j=1; j<=col; j++){
	
					makeVo(ch, j, 1);
					
					$("#r"+i).append('<div class="seat c'+j+'"><span class="" onclick="checkSeat('+ch+j+')"  name="'+ch+j+'" id="'+ch+j+'"><span class="no">'+j+'</span></span></div>')	
					
					//첫번째 로우라면  버튼 만들기
					if(i<1){
					$("#r"+i).find(".c"+j).append(
					'<span class="col_plus" onclick="colPlus('+j+')"><img src="/images/theater/plus.png" id="img"></span>'+
					'<div class="col_label">'+j+'</div>');
					}	
					
				}
				$("#r"+i).append('<span id="arrow'+i+'" class="arrow" name="'+ch+'"><img src="../../images/theater/arrow.png" class="arrow-img" /></span>')
				
				
				$("#seats_list").append('</div></div>');		
				listLength = list.length;
			}
		}


		/////////////////////////////////////////////////////
		function checkSeat(name){
			console.log("---test---");
			console.log(name);
		
			var grade=1; 
			var chName = $(name).attr("name");
			var chClass = $(name).attr("class");
			//console.log("ck : " + ck);
			console.log(chClass)
		
			var rw = chName.substring(0,1);
			var cl = chName.substring(1); 
			console.log("rw : " + rw);
			console.log("cl : " + cl);
			
			
			
			switch(seatColor) {
		
			//좌석 삭제
			case 0:
				
				
				if(chClass=='rating_delete'){
					//$(name).attr("name","");
					$(name).removeClass();
					$(name).addClass("rating_economy")
					for(i=0; i<listLength; i++){
						if(list[i].row == rw && list[i].col == cl){
							list[i].grade = 1;
							console.log("-----------:"+list[i].grade);
						}
					}
		
					seatCount += 1;
					$("#seatCount").val(seatCount);
		
					
				}else{
					$(name).removeClass();
					$(name).addClass("rating_delete");
					// vo.grade=0; (k k 0)
					//vo의 row가 A, col이 B인 것을 찾아 grade 값 바꾸기
					//$(name).attr("name","del");
					for(i=0; i<listLength; i++){
						if(list[i].row == rw && list[i].col == cl){
							list[i].grade = 0;
							console.log("-----------:"+list[i].grade);
						}
					}
		
					
					grade=0;
		
		
					seatCount -= 1;
					$("#seatCount").val(seatCount);
					
				}
				
				break;
		
			//Economy
			case 1:
				// 테두리 색 맞게 바꾸기
				// vo.grade = 1
				if(chClass!='rating_delete'){
				$(name).removeClass();
				$(name).addClass("rating_economy");
					for(i=0; i<listLength; i++){
						if(list[i].row == rw && list[i].col == cl){
							list[i].grade = 1;
							console.log("-----------:"+list[i].grade);
						}
					}
				}
				
				
				
				break;
		
			//Standard
			case 2:
				// 테두리 색 맞게 바꾸기
				// vo.grade = 2 
				if(chClass!='rating_delete'){
				$(name).removeClass();
				$(name).addClass("rating_standard");
				
					for(i=0; i<listLength; i++){
						if(list[i].row == rw && list[i].col == cl){
							list[i].grade = 2;
							console.log("-----------:"+list[i].grade);
						}
					}
				}
				
				break;
		
			//Prime
			case 3:
				// 테두리 색 맞게 바꾸기
				// vo.grade = 3
				if(chClass!='rating_delete'){
				//$(name).find("span").css('border','2px solid #f71708');
				$(name).removeClass();
				$(name).addClass("rating_prime");
					for(i=0; i<listLength; i++){
						if(list[i].row == rw && list[i].col == cl){
							list[i].grade = 3;
						}
					}
				}
				
				break;
			
		
		 	case 4:
				//seatBooking table의 reservationNum을 0으로
				//grade는 4로
				//컨트롤러 넘긴 후 grade가 4인 것은....X > 몇 개 없을 테니까 따로 String을 보내도 될 것 같음
				//아무튼.....A5 이런 형식으로 보내서?
				//아니면 따로따로 보내서
				//DB에서 검색 몇관의 몇번시트인지
				//
		 		

				
				if(chClass!='rating_delete' && !$(name).hasClass('rating_stop')){
					$(name).addClass("rating_stop");
					/* 	for(i=0; i<listLength; i++){
							if(list[i].row == rw && list[i].col == cl){
								list[i].grade = 3;
							}
						} */
						//stop list 만들어서 row, col, grade 삽입
					var stopVO = {
						"r":rw,
						"c":cl
					} 
					stopList.push(stopVO);
					console.log(",,,")
					console.log(stopList);
				}else if($(name).hasClass('rating_stop')){
					$(name).removeClass("rating_stop");
					for(i=0; i<stopList.length; i++){
						if(stopList[i].r == rw && stopList[i].c == cl){
							stopList[i].c=0;
						}
					}
					console.log(stopList);
					
				}
			
			break; 
		
			}
		}

	$(".seat_box").on("click",".arrow",function(){
		var r = $(this).attr("name")
		var l = $("#seat_col").val();

		for(b=1; b<=l; b++){
			var n = r+b;
			checkSeat("#"+n);
		}
		
	});

	
	// space 조정 + - 버튼
	function rowPlus(i){
		var c = '.r'+(i+1);
		$(c).after('<p class="row_space rs'+(i+1)+'"></p>');
		rowList.push(i+1);
		console.log(rowList);
		//아이콘이 -로 바뀌고 
		//class, onclick, src 변경
		//
		
		$(c).find(".row_plus").attr("onclick","rowMinus("+(i)+");");
		$(c).find(".row_plus").find("#img").attr("src","/images/theater/minus.png");
		$(c).find(".row_plus").attr("class","row_minus");

	}


	function rowMinus(i){
		//p태그 지우기
		//List에서 i 제거하기
		console.log(i + ">.<");
		
		$(".rs"+(i+1)).remove();

		for(l=0; l<rowList.length; l++){
			if(rowList[l]=(i+1)){
				rowList.splice(l,1);
				console.log(rowList);
				break;
			}
		}

		var c = ".r"+(i+1);
		$(c).find(".row_minus").attr("onclick","rowPlus("+i+");");
		$(c).find(".row_minus").find("#img").attr("src","/images/theater/plus.png");
		$(c).find(".row_minus").attr("class","row_plus");

		
	}


	function colPlus(j){
		var c = ".c"+j;
		$(".c"+j).after('<span class="col_space cs'+j+'">　</span>')
		colList.push(j);
		console.log(colList);
		$(c).find(".col_plus").attr("onclick","colMinus("+j+");");
		$(c).find(".col_plus").find("#img").attr("src","/images/theater/minus.png");
		$(c).find(".col_plus").attr("class","col_minus");


		
	}

	function colMinus(j){
		console.log(j);
		$(".cs"+j).remove();
		for(l=0; l<colList.length; l++){
			if(colList[l]=j){
				colList.splice(l,1);
				console.log(colList);
				break;
			}
		}


		var c = ".c"+j;
		$(c).find(".col_minus").attr("onclick","colPlus("+j+");");
		$(c).find(".col_minus").find("#img").attr("src","/images/theater/plus.png");
		$(c).find(".col_minus").attr("class","col_plus");
		
	}



	
	console.log(list);
		

	$("#btn_insert").click(function(){

		// grade가 0인 것 앞쪽으로 정렬 후 list에서 제거
		list.sort(function(a,b) {

			return a["grade"] - b["grade"];
		});

		var cnt = 0; 
		
		for(i=0; i<listLength; i++){
			if(list[i].grade=="0"){
				cnt = cnt+1;
			}

			console.log(list[i]);
		}
		console.log(cnt);
		list.splice(0,cnt);






		

		// list - row, col, grade / row_space / col_space -> form 안에 hidden으로 넣기
		for(i=0; i<list.length; i++){
			var r = '<input type="hidden" name="row" value="'+list[i].row+'">';
			r = r + '<input type="hidden" name="col" value="'+list[i].col+'">';
			r = r + '<input type="hidden" name="grade" value="'+list[i].grade+'">';
			$("#frm").append(r);
		}


		for(y=0; y<rowList.length; y++){
			var r = '<input type="hidden" name="row_space" value="'+rowList[y]+'">';
			$("#frm").append(r);
		}

		for(z=0; z<colList.length; z++){
			var r = '<input type="hidden" name="col_space" value="'+colList[z]+'">';
			$("#frm").append(r);
		}

		for(n=0; n<stopList.length; n++){
			console.log(stopList[n])
			var r = '<input type="hidden" name="stop_rc" value="'+stopList[n].r+'">';
			r = r + '<input type="hidden" name="stop_idx" value="'+stopList[n].c+'">';
			$("#frm").append(r);
			
		}
		

		// name & seatCount - null check
		var name = document.getElementById("name");
		var seatCount = document.getElementById("seatCount");

		var nameCheck = true;
		var seatCheck = true;


		if(nameCheck && seatCheck){
			//$("#frm").submit();
		}

	});

	
	
	$("#btn_test").click(function(){
		for(n=0; n<stopList.length; n++){
			console.log(stopList[n])
			var r = '<input type="hidden" name="stop_row" value="'+stopList[n].r+'">';
			r = r + '<input type="hidden" name="stop_col" value="'+stopList[n].c+'">';
			$("#frm").append(r);
			
		}

		stopList.sort(function(a,b) {

			return a["c"] - b["c"];
		});

		cnt = 0; 
		
		for(i=0; i<stopList.length; i++){
			if(stopList[i].c=="0"){
				cnt = cnt+1;
			}

			console.log(stopList[i]);
		}
		console.log(cnt);
		stopList.splice(0,cnt);
		console.log(stopList)

		
	});


	$("#btn_insert2").click(function(){
		// grade가 0인 것 앞쪽으로 정렬 후 list에서 제거
		list.sort(function(a,b) {

			return a["grade"] - b["grade"];
		});

		var cnt = 0; 
		
		for(i=0; i<listLength; i++){
			if(list[i].grade=="0"){
				cnt = cnt+1;
			}

			console.log(list[i]);
		}
		console.log(cnt);
		list.splice(0,cnt);



		// grade가 0인 것 앞쪽으로 정렬 후 list에서 제거
		stopList.sort(function(a,b) {

			return a["c"] - b["c"];
		});

		cnt = 0; 
		
		for(i=0; i<stopList.length; i++){
			if(stopList[i].c=="0"){
				cnt = cnt+1;
			}

			console.log(stopList[i]);
		}
		console.log(cnt);
		stopList.splice(0,cnt);
		console.log(stopList)

		

		// list - row, col, grade / row_space / col_space -> form 안에 hidden으로 넣기
		for(i=0; i<list.length; i++){
			var r = '<input type="hidden" name="row" value="'+list[i].row+'">';
			r = r + '<input type="hidden" name="col" value="'+list[i].col+'">';
			r = r + '<input type="hidden" name="grade" value="'+list[i].grade+'">';
			$("#frm").append(r);
		}


		for(y=0; y<rowList.length; y++){
			var r = '<input type="hidden" name="row_space" value="'+rowList[y]+'">';
			$("#frm").append(r);
		}

		for(z=0; z<colList.length; z++){
			var r = '<input type="hidden" name="col_space" value="'+colList[z]+'">';
			$("#frm").append(r);
		}

		for(n=0; n<stopList.length; n++){
			var r = '<input type="hidden" name="stop_rc" value="'+stopList[n].r+'">';
			r = r + '<input type="hidden" name="stop_idx" value="'+stopList[n].c+'">';
			$("#frm").append(r);
			
		}
		

		// name & seatCount - null check
		var name = document.getElementById("name");
		var seatCount = document.getElementById("seatCount");

		var nameCheck = false;
		var seatCheck = false;

		if(name.value.length<1){
			alert("상영관명을 입력해주세요!");
			/*return false;*/
		}else{
			nameCheck = true;
		}
		
		if($("#seatCount").val()==''){
			alert("좌석을 선택해주세요!");
		}else{
			seatCheck = true;
		}
		
		//2D, 3D, 4D 체크
		var chkbox = document.getElementsByName('filmType');
		var typeCheck = false;
		
		for(var i=0; i<chkbox.length; i++){
			if(chkbox[i].checked){
				typeCheck = true;
				break;
			}
		}
		
		//submit
		if(nameCheck && seatCheck && typeCheck){
			$("#frm").submit();
		}else if(typeCheck == false){
			alert("필름타입은 적어도 한개 체크해야합니다!");
		}
	});

	</script>
</body>
</html>