
	
var title ="";
var theater = "";
var date = "";
var time="";
var kind="";
var movieNum;

	
//class selected값 변경
$(".sortmenu a").click(function() {
	$(".sortmenu a").removeClass("selected");
	$(this).addClass("selected");
});
		
//영화제목 선택  =영화 이미지, 제목, 연령제한
$(".movie-list").on("click","#movie-list-content li",function() {
	var titleChecked = false;

	if($(this).hasClass("dimmed") === true){
		//alert("선택할수 없습니다.");
		//다른것으로 변경할 것인지에 대한 알림창 출력해야 됨
		if(confirm('선택한 영화에 원하는 상영스케줄이 없습니다.\n계속하시겠습니까?(선택한 날짜 및 극장이 해제 됩니다.)')){
			titleChecked = true;
			
			theaterReset();
			dateReset();
		}
	}else{
		titleChecked = true;
	}

	if(titleChecked){
		$("#movie-list-content li").removeClass("selected");
		$(this).addClass("selected");

		$("#select_title").text($(this).data("title"));
		$("#select_image").attr("src","../images/movie/movieList/filmCover/"+$(this).data("image"));
		$("#select_ageLimit").text($(this).data("age_limit"));
		$("#movieNum").val($(this).data("index"));
		title = $(this).data("title");
		movieNum = $(this).data("index");

		$(".movie_poster img").css("display","inline");
		$(".movie_title").css("display","block");
		$(".movie .placeholder").css("display","none");

		console.log("title: "+title);
		console.log("theater: "+theater);
		console.log("date: "+date);
		//ajax
		ajaxLoad();
	}
});
		
		
//지역선택
$(".theater-area-list > ul > li").click(function(){
	$(".theater-area-list > ul > li").removeClass("selected");
	$(this).addClass("selected");
});
		
		
		
//극장 선택
$(".theater-list").on("click",".area_theater_list > ul > li",function(){
	var theaterChecked = false;
	if($(this).hasClass("dimmed") === true){
		//alert("선택할수 없습니다.");
		if(confirm('선택한 극장에 원하는 상영스케줄이 없습니다.\n계속하시겠습니까?(선택한 영화 및 날짜가 해제 됩니다.)')){
			theaterChecked = true;
			movieReset();
			dateReset();
		}
	}else{
		theaterChecked = true;
	}
	
	if(theaterChecked){
		$(".area_theater_list li").removeClass("selected");
		$(this).addClass("selected");
		theater = $(this).data("theater");
		$("#cinemaName").val(theater);

		$("#select_cinema").text($(this).data("theater"));
		$(".row.name").css("display","block");
		$(".row.date").css("display","block");
		$(".row.screen").css("display","block");
		$(".row.number").css("display","block");
		$(".info.theater .placeholder").css("display","none");
		
		console.log("title: "+title);
		console.log("theater: "+theater);
		console.log("date: "+date);
		//ajax
		ajaxLoad();

		var selected_cinema = $(this).data("num");
		$("#cinemaNum").val(selected_cinema);

		//해당 극장의 조조,심야 시간 조회 - ajax
		search_time_limit(selected_cinema);
	}
});
		
var sTimeList;
var eTimeList;
var timeLimitList = [];

//해당극장의 조조,심야시간 구해오기
function search_time_limit(selected_cinema){
	//timeLimitList = [];
	timeLimitList.length = 0;
	$.ajax({
		url : '../timePrice/searchLimit',
		type : 'get',
		data : {
			cinemaNum : selected_cinema
		},
		success : function(result){
			for(i=0;i<result.length;i++){
				var list = [];

				sTime = result[i].morning.replace(/:/gi,",");
				eTime = result[i].night.replace(/:/gi,",");

				list.push(sTime);
				list.push(eTime);
				list.push(result[i].filmType);

				timeLimitList.push(list);
			}
		}
	});
}
		
		
		

// 날짜 토,일 CSS 적용
$(".date-list ul li.day").each(function(){
	if($(this).data("week") == '토'){
		$(this).addClass("day-sat");

	}else if($(this).data("week") == '일'){
		$(this).addClass("day-sun");
	}
});



//날짜 선택
$(".date-list ul li.day").click(function(){
	var dateChecked = false;
	if($(this).hasClass("dimmed") === true){
		//alert("선택할수 없습니다.");
		if(confirm('선택한 날짜에 원하는 상영스케줄이 없습니다.\n계속하시겠습니까?(선택한 영화 및 극장이 해제 됩니다.)')){
			dateChecked = true;

			movieReset();
			theaterReset();
		}
	}else{
		dateChecked = true;
	}
	if(dateChecked){
		$(".date-list ul li.day").removeClass("selected");
		$(this).addClass("selected");
		var str = $(this).data("year")+"."+$(this).data("month")+"."+$(this).data("date")+"("+$(this).data("week")+")";

		$("#sDate").val(str)
		$("#select_day").text(str);
		var sYear = $(this).data("year");
		var sMonth = $(this).data("month")+"";
		var sDate = $(this).data("date")+"";

		if(sMonth.length == 1){
			sMonth = "0"+sMonth;
		}
		if(sDate.length == 1){
			sDate = "0"+sDate;
		}
		date = sYear+"-"+sMonth+"-"+sDate;

		$(".row.name").css("display","block");
		$(".row.date").css("display","block");
		$(".row.screen").css("display","block");
		$(".row.number").css("display","block");
		$(".info.theater .placeholder").css("display","none");

		//ajax
		ajaxLoad();
	}
});
		
//영화 선택 초기화
function movieReset(){
	movieNum = 0;
	$("#movie-list-content li").removeClass("selected");
	$(".movie_poster img").css("display","none");
	$(".movie_title").css("display","none");
	$(".section.section-time .placeholder").css("display","block");
}

//극장 선택 초기화
function theaterReset(){
	theater = "";
	$(".area_theater_list li").removeClass("selected");
	$(".row.name").css("display","none");
	$(".row.date").css("display","none");
	$(".row.screen").css("display","none");
	$(".row.number").css("display","none");
	$(".section.section-time .placeholder").css("display","block");
}

//날짜 선택 초기화
function dateReset(){
	date = "";
	$(".date-list ul li.day").removeClass("selected");
	$(".row.name").css("display","none");
	$(".row.date").css("display","none");
	$(".row.screen").css("display","none");
	$(".row.number").css("display","none");
	$(".section.section-time .placeholder").css("display","block");
}

		
function ajaxLoad(){
	//영화관 값 출력
	$.ajax({
		type:'GET',
		url:'../reserveCheck/reserve',
		data:{
			theater:theater,
			date:date,
			kind:kind
		},
		success:function(result){
			//영화
			$("#movie-list-content li").addClass("dimmed");
			
			for(i=0;i<result.length;i++){
				$("#movie-list-content li").each(function(){
//					if($(this).data("title") == result[i].movieInfoVOs[0].title){
//						$(this).removeClass("dimmed");
//						$li = $(this);
//						$("#movie-list-content").prepend($li);
//					}
					if($(this).data("index") == result[i].movieInfoVOs[0].num){
						$(this).removeClass("dimmed");
						$li = $(this);
						$("#movie-list-content").prepend($li);
					}
				});
				
			}
			
		}
	});
	
	//극장 값 출력
	$.ajax({
		type:'GET',
		url:'../reserveCheck/reserve',
		data:{
//			title:title,
			num:movieNum,
			date:date,
			kind:kind
		},
		success:function(result){
			//극장
			$(".theater-list li").addClass("dimmed");
			//극장, 날짜
			
			$(".theater-area-list > ul > li").each(function(){
				$(this).data("index",0);
				$(this).find(".count").text("("+$(this).data("index")+")");
			});
			
			for(i=0;i<result.length;i++){
				//극장
				
				$(".theater-list ul.content li").each(function(){
					if($(this).data("theater") == result[i].cinemaVOs[0].name){
						
						if($(this).hasClass("dimmed")){
							$(this).removeClass("dimmed");
							
							$li = $(this);
							$parent = $(this).parent();
							$parent.prepend($li);
							
							
							//dimmed가 아닌 극장의 수 계산
							var prev = $(this).parent().parent().parent().data("index");
							prev += 1;
							$(this).parent().parent().parent().data("index",prev);
							var next = $(this).parent().parent().parent().data("index");
							$(this).parent().parent().parent().find(".count").text("("+next+")");
							
						}
					}
					
				});
			}
		}
	});
	
	//날짜 값 출력
	$.ajax({
		type:'GET',
		url:'../reserveCheck/reserve',
		data:{
//			title:title,
			num : movieNum,
			theater:theater,
			kind:kind
		},
		success:function(result){
			//날짜
			$(".date-list ul li.day").addClass("dimmed");
			// 날짜
			for(i=0;i<result.length;i++){
				$(".date-list ul li.day").each(function(){
					var str = result[i].movieTimeVOs[0].screenDate;
					var l = str.split('-');
					var y = l[0];
					var m = l[1];
					var d = l[2];
					
					var cy = $(this).data("year");
					var cm = $(this).data("month");
					var cd = $(this).data("date");
					if(cy == y && cm == m && cd == d ){
						$(this).removeClass("dimmed");
					}
				});
			}
		}
	});
	
	$(".time-list .content").html('');
	selectedCheck();
	
}
		
		
//3개다 체크했는지 여부 판단
function selectedCheck(){
	var cMovie = false;
	var cTheater = false;
	var cDate = false;

	if($(".movie-list ul li").hasClass("selected") == true){
		cMovie = true;
	}
	if($(".area_theater_list ul li").hasClass("selected") == true){
		cTheater = true;
	}
	if($(".date-list ul li.day").hasClass("selected") == true){
		cDate = true;
	}

	if(cMovie && cTheater && cDate){
		$("#ticket .step1 .section-time .col-body .placeholder").css("display","none");
		$("#ticket .step1 .section-time .col-body .time-list").css("display","block");

		//해당 조건에 맞는 상영 시간대 출력
		$.ajax({
			type:'GET',
			url:'../reserveCheck/reserve',
			data:{
//				title:title,
				num : movieNum,
				theater:theater,
				date:date
			},
			success:function(result){
				//상영시간 html 생성
				timeMake(result);
			}
		});

	}
}
		
		
//세개 다 선택했을 시 상영 시간 목록  HTML생성
function timeMake(result){
	var list = [];

	for(i=0;i<result.length;i++){
		var fType = "";

		if(result[i].movieTimeVOs[0].selectedFilm == 2){
			fType = '3D';
		}else if(result[i].movieTimeVOs[0].selectedFilm == 4){
			fType = '4D';
		}else{
			fType = '2D';
		}

				
		var li = '<li data-time="'+ result[i].movieTimeVOs[0].screenTime +'" data-index="'+ result[i].movieTimeVOs[0].num +'">'
		+'<a class="button" href="#" title="" onclick="return false;">'
		+'<span class="time"><span>'+ result[i].movieTimeVOs[0].screenTime +'</span></span>'
		+'<span class="count" data-count="'+ result[i].movieTimeVOs[0].remainSeat +'">'+ result[i].movieTimeVOs[0].remainSeat +'석</span>'
		+'<span class="sreader mod"> 선택불가</span>'
		+'</a>'
		+'</li>'

		var query = '<div class="theater" data-name="'+ result[i].movieTimeVOs[0].selectedFilm +'" data-floor="'+ result[i].theaterVOs[0].name 
		+'" data-seatcount="'+ result[i].theaterVOs[0].seatCount +'">'
		+'<span class="title">'
		+'<span class="name">'+ fType +'</span>'
		+'<span class="floor">'+ result[i].theaterVOs[0].name +'</span>'
		+'<span class="seatcount">(총'+ result[i].theaterVOs[0].seatCount +'석)</span>'
		+'</span>'
		+'<ul>'
		+ li
		+'</ul>'
		+'</div>'

		var checkName = result[i].movieTimeVOs[0].selectedFilm;
		var checkFloor = result[i].theaterVOs[0].name;
		var check = true;

		for(k=0;k<list.length;k++){
			if(list[k] == checkName+checkFloor){
				check = false;
			}
		}

		if(i != 0){
			$(".time-list .theater").each(function(){
				if($(this).data("name") == checkName && $(this).data("floor") == checkFloor){
					$(this).find("ul").append(li);
				}
			});
			if(check){
				$(".time-list .content").append(query);
			}
		}else{
			$(".time-list .content").append(query);
		}
		list.push(checkName+checkFloor);
	}
	
	
	

	//.time-list ul li 잔여좌석이 0인 경우 class = "disabled"추가
	$(".time-list ul li .count").each(function(){
		if($(this).data("count") == 0){
			$(this).parent().parent().addClass("disabled");
		}
	});
	
	
	//result[i].movieTimeVOs[0].screenTime 가  조조/심야 시간일때 CSS 부여 morning /night
	var morningEndTime = ""; //조조 마무리 시간(10:00 or 11:00)
	var nightStartTime = ""; //심야 시작 시간(23:01 or 00:01) => 00:01분은 비교를 위해 24:01분으로 변경해야됨(반대일수도..)
	
	//위 처럼 만드는 시간이 심야 또는 조조이면 addClass로 클래스 추가 해주면 끝 
	$(".time-list ul li").each(function(){
		//영화, 극장, 날짜의 조건에 해당하는 시간대 
		var timeList =  $(this).data("time").split(":");
		var filmType = $(this).parent().parent().data("name");
		
		//1, 2, 4 일대 구분 - timeLimitList(읽어온 조조/심야 시간값 존재)
		//하나의 시간대에 대하여서 filmType이 맞는 timLimitList의 조조/심야값 매칭해야됨
		
		var morning;
		var night;
		var index = 0;
		
		//console.log(timeLimitList);
		
		for(i=0;i<timeLimitList.length;i++){
			if(timeLimitList[i][2] == filmType){
				index = i;
				morning = timeLimitList[index][0];
				night = timeLimitList[index][1];
				
				morningList = morning.split(",");
				nightList = night.split(",");
				
				var t1 = new Date(0,0,0,morningList[0],morningList[1]); //조조
				var t2 = new Date(0,0,0,nightList[0],nightList[1]); //심야
				var t3 = new Date(0,0,0,timeList[0],timeList[1]); //비교시간
				
				
				//비교시간이 10 > x || 23 < x
				//if(timeList[0] > 23){
				if(t3 > t2){
					//심야
					$(this).addClass("night");
				}else if(t3 < t1){
					//조조
					$(this).addClass("morning");
				}
				break;
			}
		}
		
		
		
		
		
		
	});
	
	// 초기화
	//date - time
	$("#select_day").text($("#sDate").val());
	//theater
	$("#select_theater").text("");
	$("#theaterName").val("");

	//filmType
	$("#select_movieType").text("");
	$("#filmType").val("");

	$(".tnb.step1 .btn-right").removeClass("on");
	
	//상영 20분 전 예매 불가능
	timeDisabledCheck();
}
		
//DateFormat
Date.prototype.format = function (f) {
    if (!this.valueOf()) return " ";

    var weekKorName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var weekKorShortName = ["일", "월", "화", "수", "목", "금", "토"];
    var weekEngName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    var weekEngShortName = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    var d = this;

    return f.replace(/(yyyy|yy|MM|dd|KS|KL|ES|EL|HH|hh|mm|ss|a\/p)/gi, function ($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear(); // 년 (4자리)
            case "yy": return (d.getFullYear() % 1000).zf(2); // 년 (2자리)
            case "MM": return (d.getMonth() + 1).zf(2); // 월 (2자리)
            case "dd": return d.getDate().zf(2); // 일 (2자리)
            case "KS": return weekKorShortName[d.getDay()]; // 요일 (짧은 한글)
            case "KL": return weekKorName[d.getDay()]; // 요일 (긴 한글)
            case "ES": return weekEngShortName[d.getDay()]; // 요일 (짧은 영어)
            case "EL": return weekEngName[d.getDay()]; // 요일 (긴 영어)
            case "HH": return d.getHours().zf(2); // 시간 (24시간 기준, 2자리)
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2); // 시간 (12시간 기준, 2자리)
            case "mm": return d.getMinutes().zf(2); // 분 (2자리)
            case "ss": return d.getSeconds().zf(2); // 초 (2자리)
            case "a/p": return d.getHours() < 12 ? "오전" : "오후"; // 오전/오후 구분
            default: return $1;
        }
    });
};

String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
Number.prototype.zf = function (len) { return this.toString().zf(len); };


//현재시간을 지났거나 20분전에는 예매 불가 
function timeDisabledCheck(){
	var nowDate = new Date();
	var nowTime = nowDate.format("yyyy-MM-dd");
	//누른날짜랑 현재 지금 날짜랑 동일 할때
	//시간이 지나있으면 disabled
	//읽어온 시간 값이 현재시간 20분 뒤면 disabled
	
	if(nowTime == date){
		$(".time-list ul li").each(function(){
			var arr = $(this).data("time").split(":");
			var readDate = new Date(nowDate.getFullYear(),nowDate.getMonth(),nowDate.getDate(),arr[0],arr[1]);
			var resultTime = readDate - nowDate;
			var hh = Math.floor((resultTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
			var mi = (Math.floor((resultTime % (1000 * 60 * 60)) / (1000 * 60)))+1;
			
			if(mi < 20 && hh <= 0){
				$(this).addClass("disabled");
			}
			
		});
	}
}



		
		
		
		
		
		
		
		
		
		
		
// 상영시간 선택
$(".time-list").on("click",".theater ul li",function(){
	if(!$(this).hasClass("disabled")){
		$("#movieTimeNum").val($(this).data("index"));
		$(".theater ul li").removeClass("selected");
		$(this).addClass("selected");


		//날짜 값 + 시간값
		var select_time= $("#sDate").val() +" "+$(this).data("time");
		$("#select_day").text(select_time);
		time = $(this).data("time");

		//seatCount
		$("#seatCount").val($(this).parent().parent().data("seatcount"));

		//theater
		$("#select_theater").text($(this).parent().parent().data("floor"));
		$("#theaterName").val($(this).parent().parent().data("floor"));

		//filmType
		$("#select_movieType").text($(this).parent().parent().find(".title .name").text());
		$("#filmType").val($(this).parent().parent().data("name"));

		$(".row.movie_type").css("display","block");
		$(".tnb.step1 .btn-right").addClass("on");

	}

});

		
		
		
		
//좌석예매페이지로 이동
$(".tnb_container").on("click",".tnb.step1 .btn-right",function(){
	if($(this).hasClass("on") == true){
		var timeType="normal";
		$(".time-list ul li").each(function(){
			if($(this).hasClass("selected")){
				if($(this).hasClass("morning") || $(this).hasClass("night")){
					timeType = "mn";
				}
			}
		});
		
		if(memberId == '' && beMemberVO==''){
			$(".ft_layer_popup.popup_login").css("display","block");
			$(".blackscreen").css("display","block");
		}else{
			$.ajax({
				url : '../reservation/seatReservation',
				type : 'post',
				data : {
					movieNum : $("#movieNum").val(),
					movieTimeNum : $("#movieTimeNum").val(),
					cinemaName : $("#cinemaName").val(),
					theaterName : $("#theaterName").val(),
					filmType : $("#filmType").val(),
					seatCount : $("#seatCount").val(),
					
					timeType : timeType,
					cinemaNum : $("#cinemaNum").val(),
					time : time,
					_csrf : $("#_csrf").val()
				},
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(result){
					$(".step.step1").css("display","none");
					$(".ticket_tnb .tnb_container .tnb").removeClass("step1");
					$(".ticket_tnb .tnb_container .tnb").addClass("step2");
					$(".ticket_tnb .tnb.step2 .btn-left").css("display","block");

					$(".step.step2").css("display","block");
					$(".step.step2").html(result);
				}
			});
		}

	}else{
		alert("선택해주세요");
	}

});


//결제하기 페이지로 이동
$(".tnb_container").on("click",".tnb.step2 .btn-right",function(){
	if($(this).hasClass("on")){
		//결제진행 - ajax()
		$.ajax({
			url : '../reservation/reservePayment',
			type : 'post',
			data : {
				_csrf : $("#_csrf").val()
			},
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(result){
				$(".step.step2").css("display","none");
				$(".ticket_tnb .tnb_container .tnb").removeClass("step2");
				$(".ticket_tnb .tnb_container .tnb").addClass("step3");

				//할인 - 결제수단 결정 페이지
				$(".ticket_tnb .tnb.step3 .btn-left").css("display","block");

				$(".step.step3").css("display","block");
				$(".step.step3").html(result);
			}
		});

	}else{
		if(totalCount == 0){
			alert("관람인원을 선택하여 주세요");
		}else{
			alert("관람인원과 선택좌석수가 동일하지 않습니다.");
		}
	}
});


//예메 - 로그인 폼
//로그인 창 닫기
$(".ft_layer_popup.popup_login .layer_close").click(function(){
	login_form_close();
});

function login_form_close(){
	$(".ft_layer_popup.popup_login").css("display","none");
	$(".blackscreen").css("display","none");
}

$("#location").val(window.location.href);






		

//뒤로가기 버튼 - 영화예매로 이동
$(".ticket_tnb").on("click",".tnb.step2 .btn-left",function(){
	alert("aa")
	$(".steps .step2").empty();

	$(".steps .step.step2").css("display","none");
	$(".steps .step.step1").css("display","block");

	$(".ticket_tnb .tnb_container .tnb").removeClass("step2");
	$(".ticket_tnb .tnb_container .tnb").addClass("step1");

	$(".info.seat").css("display","none");
	$(".info.payment-ticket").css("display","none");
	$(".info.path").css("display","block");
	$(".info.theater .row.number .data").text("");

	$(".tnb.step1 .btn-right").addClass("on");
});

		
//뒤로가기 버튼 - 좌석예매 이동
$(".ticket_tnb").on("click",".tnb.step3 .btn-left",function(){
	alert("aa")
	$(".steps .step.step3").empty();

	$(".steps .step.step3").css("display","none");
	$(".steps .step.step2").css("display","block");

	$(".ticket_tnb .tnb_container .tnb").removeClass("step3");
	$(".ticket_tnb .tnb_container .tnb").addClass("step2");

	$(".info.payment-ticket").css("display","block");

	$(".tnb.step2 .btn-right").addClass("on");
});


//스크롤 이동
$("#movie-list-content").scroll(function () {
	var height = $(this).scrollTop();
	$(".movie-list .slider").css("top",height);
});

		
	

//영화 정렬 방법 선택 
$(".btn-rank").click(function(){
	$.get("./movieListSort?kind=rate",function(result){
		$("#movie-list-content").html(result);
		
		//정렬 결과로 선택한 값들 재로딩
		kind = '';
		
		ajaxLoad();
		movieSort(movieNum);
	});
});

$(".btn-abc").click(function(){
	$.get("./movieListSort?kind=title",function(result){
		$("#movie-list-content").html(result);
		
		//정렬 결과로 선택한 값들 재로딩
		kind = "sort";
		ajaxLoad();
		movieSort(movieNum);
	});
});


function movieSort(num){
	$("#movie-list-content li").each(function(){
		if($(this).data("index") == num){
			$(this).addClass("selected");
			$("#select_title").text($(this).data("title"));
			$("#select_image").attr("src","../images/movie/movieList/filmCover/"+$(this).data("image"));
			$("#select_ageLimit").text($(this).data("age_limit"));
			$("#movieNum").val($(this).data("index"));
			title = $(this).data("title");
			
			$(".movie_poster img").css("display","inline");
			$(".movie_title").css("display","block");
			$(".movie .placeholder").css("display","none");
		}

	});
}



	
	
	
	