/**
 * 
 */

//숫자만 등록 가능
$("#price").keyup(function() {
	reg = /[^0-9]/gi;
	v = $(this).val();

	if (reg.test(v)) {
		$(this).val(v.replace(reg, ''));
		$(this).focus();
	}
});



//selectBox에 따라서 ajax실행
//1.기프티콘 - 시리얼번호(16자리-숫자,영어),비밀번호(6자리) 생성
//2.할인쿠폰 - 시리언번호(6자리-숫자) 생성
$("#btnCreate").click(function() {
	var type = $("#selectBox option:selected").val();
	console.log(path);
	
	if(path != 'couponUpdate'){
		$.ajax({
			url : './makeSerial',
			type : 'get',
			data : {
				type : type
			},
			success : function(result) {
				console.log(result);
				if (type == 1) {
					//시리얼번호,비번
					$("#pwd").val(result[1])
				}
				$("#serialNum").val(result[0])
			}
		});
	}else{
		alert("이미 생성된 시리얼 번호는 변경할 수 없습니다.")
	}
	
});

if (path == 'couponInsert') {
	$("#title").text("쿠폰 등록");
} else {
	//업데이트 일때
	//수정 막기	
	if (type == 1) {
		//selected값 수정
		$('#selectBox option[value="1"]').prop("selected", true);
		//출력폼 수정
		$("#cgvGiftCardForm").css("display", "block");
		$("#cgvCouponForm").css("display", "none");
		$("#count").val(1);
	}
	$("#selectBox option").each(function() {
		$(this).prop("disabled", true);
	});
	$("#btnSubmit").text("수정하기");
}



//날짜 조건 체크(시작일이 종료일 보다 빨라야됨 -made.신우)
periodComparison("coupon-form");

//selectBox 선택에 의해서 출력 폼 변경
$("#selectBox").change(function() {
	$('input[type="text"]').val("");

	if ($("#selectBox option:selected").val() == 1) { //1: 기프티콘
		$("#cgvGiftCardForm").css("display", "block");
		$("#cgvCouponForm").css("display", "none");
		$("#count").val(1);

	} else { //2: 할인쿠폰
		$("#cgvGiftCardForm").css("display", "none");
		$("#cgvCouponForm").css("display", "block");
	}
});











