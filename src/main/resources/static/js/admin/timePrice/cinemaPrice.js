//insert , update 공용





//HH:MM 형식 생성
function inputTimeColon(time) {
    // replace 함수를 사용하여 콜론( : )을 공백으로 치환한다.
    var replaceTime = time.value.replace(/\:/g, "");

    // 텍스트박스의 입력값이 4~5글자 사이가 되는 경우에만 실행한다.
    if(replaceTime.length >= 4 && replaceTime.length < 5) {
        var hours = replaceTime.substring(0, 2);      // 선언한 변수 hours에 시간값을 담는다.
        var minute = replaceTime.substring(2, 4);    // 선언한 변수 minute에 분을 담는다.

        // isFinite함수를 사용하여 문자가 선언되었는지 확인한다.
        if(isFinite(hours + minute) == false) {
            alert("문자는 입력하실 수 없습니다.");
            time.value = "00:00";
            return false;
        }

        // 두 변수의 시간과 분을 합쳐 입력한 시간이 24시가 넘는지를 체크한다.
        if(hours + minute > 2459) {
            alert("시간은 24시를 넘길 수 없습니다.");
            time.value = "24:59";
            return false;
        }

        // 입력한 분의 값이 60분을 넘는지 체크한다.
        if(minute > 60) {
            alert("분은 60분을 넘길 수 없습니다.");
            time.value = hours + ":00";
            return false;
        }
        time.value = hours + ":" + minute;
    }
}


//update ======================================================
//default값 설정
$(".sTime:first").val("06:00");
$(".sTime:first").attr("readonly",true);
$(".eTime:last").val("02:00")
$(".eTime:last").attr("readonly",true);

//시간 form변형
$(".eTime").each(function(){
	var eTime = $(this).val();
	eTime = eTime.substr(0,5);
	$(this).val(eTime);
});


if(timePrice == 'update'){
	//sTime 값 생성 및 글자 출려값 변경
	$(".eTime").each(function(){
		var sTime = $(this).val();

		sTime = sTime.split(":");
		var t1 = new Date(0,0,0,sTime[0],sTime[1]);
		t1.setMinutes(t1.getMinutes()+1);

		var minute = t1.getMinutes()+"";
		var hour = t1.getHours()+"";
		if(sTime[0] > 24){
			sTime[0] = "0"+(sTime[0]-24);
		}
		if(minute.length < 2){
			minute = "0"+minute;
		}
		if(hour.length < 2){
			if(hour == 0){
				hour = '24';
			}else{
				hour = "0"+hour;
			}
		}
		sTime = hour+":"+minute;

		//맨앞 2개 맨뒤 2개 x버튼 지우기 (최소 4개는 입력해야됨)
		$(".underData:first").find(".button_del").remove();
		$(".underData:first").next().find(".button_del").remove();
		$(".underData:first").next().next().find(".button_del").remove();
		$(".underData:last").find(".button_del").remove();

		count = $(".underData").length;
		$(this).parent().parent().parent().next().find(".sTime").val(sTime);
	});
	//제목 변경
	$("#title").text("극장별 관람가격 수정")

}

//insert  ======================================================
//하단부 정보 추가 버튼 클릭
$("#addUnderDataBtn").click(function(){
	//var copyHTML = $(".underData:first").clone();
	var html = '<div class="underData" style="display:flex!important;">'
		+ '<div class="form-group">'
		+ '<div style="display:flex!important;">'
		+ '<input type="text" class="sTime form-control timeBox" onKeyup="inputTimeColon(this);" placeholder="HH:MM" maxlength="5"  style="width: 45%;  margin: 0 auto" required="required"/>'
		+ ' ~ ' 
		+ '<input type="text" name="eTime" class="eTime form-control timeBox" onKeyup="inputTimeColon(this);" placeholder="HH:MM" maxlength="5"  style="width: 45%;  margin: 0 auto; margin-right: 0" required="required"/>'
		+ '</div>'
		+ '</div>'
		+ '<div class="form-group">'
		+ '<input type="text" name="commonPrice" class="commonPrice form-control inputbox" required="required"'
		+ 'style="IME-MODE:disabled;" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">'
		+ '</div>'
		+ '<div class="form-group">'
		+ '<input type="text" name="teenagerPrice" class="teenagerPrice form-control inputbox" required="required"'
		+ 'style="IME-MODE:disabled; width:217px;" onKeypress="if(event.keyCode < 45 || event.keyCode > 57) event.returnValue = false;">'
		+ '</div>'
		+ '<div class="button_del"><button class="btn delBtn" type="button" style="position: absolute; right: 4px;">&nbsp;X</button></div>';
	
	if(count < 6){
		count += 1;
		$(".underData:last").before(html);
	}else{
		alert("최대 6개까지 가능합니다.")
	}
	
});

//항목 삭제 버튼
$("#underData").on("click",".delBtn",function(){
	//update면, DB에서 값 날리기 
	if(timePrice == 'update'){
		//console.log($(this).parent().parent().find('input[name="num"]').val())
		var timePriceNum = $(this).parent().parent().find('input[name="num"]').val();

		if(typeof timePriceNum != 'undefined' || timePriceNum != null || timePriceNum != ""){
			$.get("./deleteSelect?num="+timePriceNum,function(result){
				if(result > 0){
					alert("삭제되었습니다.");
				}
			});
		}

	}
	count -= 1;
	$(this).parent().parent().remove();
});



//공용
var filmTypeStr = "2D";
switch(filmType){
case 2:
	filmTypeStr = "3D";
	break;
case 4:
	filmTypeStr = "4D";
	break;
}
$("#filmType").val(filmTypeStr);
















