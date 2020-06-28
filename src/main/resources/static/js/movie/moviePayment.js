



//#discCoupon .tpm_body - 할인 쿠폰
$("#discCoupon .tpm_header").click(function(){
	if($("#discCoupon .tpm_body").css("display") == 'none'){
		$("#discCoupon .tpm_body").css("display","block");
		$("#payPoints .tpm_body").css("display","none");
	}else{
		$("#discCoupon .tpm_body").css("display","none");
	}
});




//#payPoints .tpm_body - 포인트 
$("#payPoints .tpm_header").click(function(){
	if($("#payPoints .tpm_body").css("display") == 'none'){
		$("#payPoints .tpm_body").css("display","block");
		$("#discCoupon .tpm_body").css("display","none");
	}else{
		$("#payPoints .tpm_body").css("display","none");
	}
});


//info payment-ticket - 아래 바의 결제 부분 감추기
$(".info.payment-ticket").css("display","none");


//summary_total_amount - 결제 총액
var totalPrice = $(".payment-ticket .payment-final .data .price").attr("title");
console.log(totalPrice);
$("#summary_total_amount").text(addComma(totalPrice));


//summary_discount_total - 할인 금액
$("#summary_discount_total").text(0);


//summary_payment_total  - 남은 결제금액
var lastPrice = totalPrice-$("#summary_discount_total").text();
$("#summary_payment_total").text(addComma(totalPrice-$("#summary_discount_total").text()));



//간편 결제 클릭시 아래 수단 추가
//last_pay_radio3
$("#lastPayCon span input").click(function(){
	if($(this).prop("checked") == true && $(this).val() == 3){
		$("#smartPayCon").css("display","block");
	}else{
		$("#smartPayCon").css("display","none");
	}
});




//이니스트 결제
function payment_inicis(data){
	var IMP = window.IMP; // 생략가능
    IMP.init('imp08695126'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
    
    IMP.request_pay({
        pg : 'inicis', // version 1.1.0부터 지원.
        pay_method : 'card',
        merchant_uid : 'cgv_' + new Date().getTime(),
        amount : data.amount,
        buyer_email : data.email,
        buyer_tel : data.tel,
        m_redirect_url : 'https://www.yourdomain.com/payments/complete'
        	
    }, function(rsp) {
        if ( rsp.success ) {
            var msg = '결제가 완료되었습니다.';
            
            var imp_uid =  rsp.imp_uid; //고유ID
            var merchant_uid = rsp.merchant_uid; //상점 거래ID 
            var paid_amount = rsp.paid_amount; //결제 금액 
            var apply_num = rsp.apply_num; //카드 승인번호 
            var pay_method = rsp.pay_method; //결제 방식 
            var pg_provider =  rsp.pg_provider; //PG사
            
            $.ajax({
            	url : '../payment/paymentInsert',
            	type : 'post',
            	data : {
            			imp_uid : imp_uid,
            			merchant_uid : merchant_uid,
            			apply_num : apply_num,
            			pay_method : pay_method,
            			pg : pg_provider
            	},
            	success : function(result){
            		if(result > 0){
            			alert(msg + "결제 번호 : "+result);
            			console.log("결제 번호 : "+result);
            			
            			//결제 성공시 예매 테이블에 등록 
            			reservation_save(result);
            		}else{
            			alert('결제 DB 저장 실패');
            		}
            	}
            });
            
            
        } else {
            var msg = '결제에 실패하였습니다.';
            msg += '에러내용 : ' + rsp.error_msg;
            alert(msg);
        }
        
    });
	
}


function reservation_save(result){
	
	var reservationVO = {
		movieNum : $("#movieNum").val(),
		paymentNum : result,
		movieTimeNum : $("#movieTimeNum").val(),
		uid : 'tester',
		filmType : $("#filmType").val(),
		cinemaName : $("#cinemaName").val(),
		theaterName : $("#theaterName").val(),
		seats : $("#select_Seat").text(),
		totalPrice : lastPrice,
		common : commonCount,
		teenager : teenagerCount,
		preference : preferenceCount,
		
		selectedSeatNums : selectedSeatNumList.join(",")
	}
	console.log(reservationVO);
	
	var result = 0;
	
	$.ajax({
		url : '../reservation/reservationInsert',
		type : 'post',
		data : reservationVO,
		success : function(data){
			console.log(data);
			if(data > 0){
				console.log("예매 번호 : "+data);
			}else{
				console.log(">>>예매 테이블 등록 실패");
			}
			
		}
	});
}










