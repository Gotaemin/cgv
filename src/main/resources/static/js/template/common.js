/**
 * 
 */

// 1000원 단위 ',' 붙이기
function addComma(num) {
	var regexp = /\B(?=(\d{3})+(?!\d))/g;
	return num.toString().replace(regexp, ',');
}

// ',' 제거
function removeComma(str){
	n = parseInt(str.replace(/,/g,""));
	return n;
}

// '01011112222' String에 '-' 붙이기
function makePhoneNum(phoneNumStr) {
	
	if(typeof phoneNumStr != 'string') {
		
		return phoneNumStr;
	}
	
	var phoneNum = phoneNumStr.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	return phoneNum;
}

// 'yyyy-mm-dd' String을 'yyyy년 mm월 dd일' 로 변경 
function makeBirth(birthStr) {
	var birthInfo = birthStr.split('-');
	return birthInfo[0] + "년 "+ birthInfo[1] + "월 " + birthInfo[2] + "일";
}

//사용기간 비교 - 두날짜간에 차이 비교(앞에 날짜가 뒤에 날짜보다 클수 없음) - 해당 Form태그의 아이디값 필요 
function periodComparison(id){
	$("#"+id).submit(function() {
		var startDate = $("#sIssuance").val();
		var endDate = $("#eIssuance").val();

		var startArray = startDate.split('-');
		var endArray = endDate.split('-');

		var start_date = new Date(startArray[0], startArray[1],	startArray[2]);
		var end_date = new Date(endArray[0], endArray[1], endArray[2]);

		if (start_date.getTime() > end_date.getTime()) {
			alert("종료일이 시작일보다 늦어야합니다!");
			return false;
		}
	});
}

//해당 날짜의 요일 구하기 (날짜형식 : yyyy-mm-dd)
function weekFind(date){
	var week = ['일', '월', '화', '수', '목', '금', '토'];
	var dayOfWeek = week[new Date(date).getDay()];
	
	return dayOfWeek;
}









