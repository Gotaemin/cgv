<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<c:import url="../template/head.jsp"></c:import> 
<link href="/css/admin/cinema/theaterSeat.css" rel="stylesheet" type="text/css">

</head>
<body class="sb-nav-fixed">
		<c:import url="../template/header.jsp"></c:import> 
        <div id="layoutSidenav">
            <c:import url="../template/sidenav.jsp"></c:import>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid" style="padding: 40px;">
                        <h1 class="mt-4">Theater Select</h1>
                        <p>-영화관 정보 페이지-</p>
                        <h3>${cine.name} CGV</h3>
						<div class="card mb-4">
                            <div class="card-body">
                                <p class="mb-0">
                                   
                                    <code>Theater Info</code><br>
                               		상영관명 : <span>${theater.name}</span><br>
                               		총 좌석수 : <span>${theater.seatCount}</span><br>
	                         		필름 타입 : 			
								 	<c:forEach items="${filmType}" begin="${i.index}" end="${i.index}" var="f">
										<c:forEach items="${f}" var="m">
											<c:if test="${m eq 1}">
												2D
											</c:if>
											<c:if test="${m eq 2}">
												3D
											</c:if>
											<c:if test="${m eq 4}">
												4D
											</c:if>
										</c:forEach>
									</c:forEach>
									
                                </p>
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table mr-1"></i>
                          	      좌석배치도
                            </div>
							<!-- 좌석 배치 -->
							<div class=".theater_minimap">
							<div class="theater nano has-scrollbar">
								<div class="seat-content" style="right: -17px; bottom: -17px;">
									<div class="screen" style="width: 652px;">
										<span class="text"></span>
									</div>
									<div class="seats" style="width: 272px; height: 192px;">
										<c:forEach var="row" items="${rowList}" varStatus="t" >
											<div class="roww" style="top:${t.index+(t.index*16)}px;" data-row="${row.rowIdx}">
												<div class="label">${row.rowIdx}</div>
												<div class="seat_group" data-seat-group="">
													<div class="group"> 
														<c:forEach begin="1" end="${maxCol}" var="i" >
															<!--blocked(선택불가)  reserved(이미 예매)  -->
															<!-- rating_economy(노랑) rating_comfort(초록) rating_prime(빨강)  -->
															
															<div class="seat" style="left:${48+(i*16)}px" data-row="${t.index+1}" data-col="${i}" data-grade="${row.grade}"> 
																<a href="#" onclick="return false;"> 
																	<span class="no">${i}</span>
																	<span class="sreader"></span>
																	<span class="sreader mod"></span>
																</a>
															</div>
														</c:forEach>
															
													</div>
												</div>
											</div>
											<br>
											
										</c:forEach>
										
									</div>
								</div>								
							</div>
							</div>			
							<!-- 좌석 배치 -->
                    </div>
                    
                    <div class="">
                    	<span id="de" class="btn btn-danger">삭제</span>
                    	<a href="./theaterUpdate?num=${theater.num}&cinemaNum=${cine.num}" id="up" class="btn btn-primary">수정</a>
                    </div>
                    </div>
                </main>
                <c:import url="../template/footer.jsp"></c:import>
            </div>
        </div>
        <c:import url="../template/scripts.jsp"></c:import>
    <script type="text/javascript">
	$("#de").click(function(){
		//정말 삭제할 거냐고 묻는 alert창
		var check = confirm("삭제하시겠습니까?");
		if(check){
			location.href="./theaterDelete?num="+${theater.num}+"&cinemaNum="+${theater.cinemaNum};
		}
	});
	
    
	var seatList = [];


	<c:forEach items="${seatList}" var="vo">
		var seatVO = {
		      num: `${vo.num}`,
		      theaterNum:	`${vo.theaterNum}`,
		      rowIdx :	`${vo.rowIdx}`,
		      colIdx :	`${vo.colIdx}`,
		      grade:	`${vo.grade}`,
		};
	
		if(seatVO.grade == 1){
			console.log("economy");
		}else if(seatVO.grade == 2){
			console.log("standard");
		}else if(seatVO.grade == 3){
			console.log("prome");
		}
	
		
		seatList.push(seatVO);   
	</c:forEach>

	console.log(seatList);


// 	var str = 'ABCD';
// 	console.log(str);
// 	console.log(str.charCodeAt(0));
// 	console.log(str.charCodeAt(0)-64);

	var seatNumList = [];

	for(i=0;i<seatList.length;i++){
		var row = seatList[i].rowIdx;
		row = row.charCodeAt(0)-64;
		var col = seatList[i].colIdx;

// 		console.log("seat["+i+"] : "+row+col);
// 		console.log(row+col);
		seatNumList.push(row+col);
		
	}

	var seatSpaceList = [];
	<c:forEach items="${seatSpaceList}" var="seatSpaceVO">
		var seatSpaceVO = {
		      type : `${seatSpaceVO.rowOrCol}`,
		      index : `${seatSpaceVO.index}`
		};
		seatSpaceList.push(seatSpaceVO);
	</c:forEach>

	var stopList = [];
    //stop_list에 값 넣기
    <c:forEach items="${stopSeat}" var="vo">
    	  //alert("testttt");
  		  var vo = {
			"r":'${vo.rowIdx}',
			"c":${vo.colIdx}
		}
    	stopList.push(vo);
	    console.log(stopList);
    </c:forEach>



	$(".seats .seat").each(function(){
		//없는 좌석 삭제
		var checkNum = $(this).data("row")+""+$(this).data("col");
		console.log(checkNum);

// 		console.log(seatNumList.indexOf(checkNum));
		if(seatNumList.indexOf(checkNum) == -1){
			$(this).remove();
		}


		//좌석 등급 css 등록
		<!-- rating_economy(노랑) rating_comfort(초록) rating_prime(빨강)  -->
		if($(this).data("grade")==1){
			//economy
			$(this).addClass("rating_economy");
		}else if($(this).data("grade")==2){
			//standard
			$(this).addClass("rating_comfort");
		}else if($(this).data("grade")==3){
			//prime
			$(this).addClass("rating_prime");
		}




		//stop color
		for(i=0; i<stopList.length; i++){
			//alert(">.<!!");
			var r = stopList[i].r;
			console.log("r : " + r);
			var c = stopList[i].c;
			console.log("c : " + c);
			var rn = r.charCodeAt(0)-64;
			console.log("rn : " + rn);
			//alert("rn : " + rn);
			//r = A = 1 변환
			if($(this).data("row")==rn && $(this).data("col")==c){
				$(this).removeClass();
				$(this).addClass("seat");
				$(this).addClass("rating_stop");
			}
			
		}
	});


	//좌석 빈칸 띄우기
	for(i=0;i<seatSpaceList.length;i++){
		var type = seatSpaceList[i].type;
		var index = seatSpaceList[i].index;

		console.log(type +" : "+index);

		
		//행띄우기
		if(type == 0){
			$(".seats .roww").each(function(){
				var charAt = $(this).data("row");
				charAt = charAt.charCodeAt(0)-64;
				
				if(charAt > index){
					console.log(charAt + " "+index);
					var top = ($(this).css('top').replace('px', ''))*1;
					console.log("top : "+top);
					top = top+16;
					console.log("top2 : "+top);

					$(this).css('top',top+"px");
				}
				
			});
		}else if(type == 1){
			$(".seats .seat").each(function(){
				var charAt = $(this).data("col");
				
				
				if(charAt > index){
					console.log(charAt + " "+index);
					var top = ($(this).css('left').replace('px', ''))*1;
					console.log("left : "+top);
					top = top+16;
					console.log("left : "+top);

					$(this).css('left',top+"px");
				}
			});

		}
		
		
		
		
		
		
	}
	


	




</script>
    </body>
</html>