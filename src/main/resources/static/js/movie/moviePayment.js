
//discCoupon : 할인쿠폰
//payPoints : 포인트 


//포인트에서 선택한  li값의 명칭 (default)
var selected_li = "CJ ONE 포인트";
var totalDiscount = 0;
var lastPrice = 0;
var usePrice = 0;

var discountList;


//비회원 로그인이면 폼 수정
//최종 결제하기 부분만 출력되어야함
if(beMemberVO != '' && memberId == ''){
	$("#discCoupon").css("display","none");
	$("#payPoints").css("display","none");
	$(".ts3_titlebar.ts3_t1 .header").text("STEP .");
}




//info payment-ticket - 아래 바의 결제 부분 감추기
$(".info.payment-ticket").css("display","none");

//summary_total_amount - 결제 총액
var totalPrice = $(".payment-ticket .payment-final .data .price").attr("title");
$("#summary_total_amount").text(addComma(totalPrice));

//summary_discount_total - 할인 금액
$("#summary_discount_total").text(0);


//summary_payment_total  - 남은 결제금액
lastPrice = totalPrice-$("#summary_discount_total").text();
$("#summary_payment_total").text(addComma(lastPrice));
$("#summary_payment_list .num").text(addComma(lastPrice));

var cupon_load = 0;
//#discCoupon .tpm_body - 할인 쿠폰
$("#discCoupon .tpm_header").click(function(){
	var check = discountTypeCheck(1,"할인 쿠폰을");
	if(check){
		discount_select("#discCoupon ","#payPoints ");
		if(cupon_load == 0){
			selected_li = "CGV 할인쿠폰";
			discount_cupon_ajax();
			cupon_load = 1;
		}
	}
});

//#payPoints .tpm_body - 포인트 
$("#payPoints .tpm_header").click(function(){
	var check = discountTypeCheck(2,"포인트를");
	
	if(check){
		discount_select("#payPoints ","#discCoupon ");
		selected_li="CJ ONE 포인트";
		discount_point_ajax();
	}
	
});

var discount_type = 0; //1:쿠폰 , 2:포인트 , 0:없음
//하나의 할인 방법만 사용가능(쿠폰 :1 or 포인트:2 /없음 : 0)
function discountTypeCheck(type,step){
	var check = true;

	if(discount_type != type && discount_type != 0){
		var check = confirm("할인수단 변경시, 이미 적용된 포인트 및 기타 결제 수단이 초기화 됩니다.\n "+ step +" 적용/변경하시겠습니까?") //초기화 시킴
		if(check){
			//discount_type = type;
			discount_type = type;
			
			//할인내역 폼 지우기
			$("#summary_discount_list").empty();
			
			switch (type) {
			case 1: //할인 쿠폰
				$(".discount_form span > input").each(function(){
					$(this).prop("checked",false);
				});
				$("#cgvCoupon .price").text(0);
				break;
			case 2: //포인트
				//포인트 val()값 초기화
				$(".discount_form dd > input").each(function(){
					$(this).val(0);
				});

				$(".discount_form dt > input").each(function(){
					$(this).prop("checked",false);
				});
				break;
			}
			
			//금액 초기화 >>>>
			//총액 초기화
			totalPriceSum(totalDiscount);
			//총 할인액초기화
			$("#summary_discount_total").text(0);
			totalDiscount = 0;
			selected_cuponNum = 0;
		}
	}
	return check;
}


//할인 수단 방법 선택 - (할인쿠폰 or 포인트)
function discount_select(selected,other){
	if($(selected +".tpm_body").css("display") == 'none'){
		$(selected +".tpm_body").css("display","block");
		$(other+".tpm_body").css("display","none");
	}else{
		$(selected+" .tpm_body").css("display","none");
	}
}



//할인 수단으로 쿠폰 선택시 ajax으로 해당 값들을 읽어옴
function discount_cupon_ajax(){
	var memberNum = $("#memberId").val();
	$.ajax({
		url : '../memberCupon/memberCouponSelect',
		type : 'get',
		data : {
			uid : memberNum
		},
		dataType : 'json',
		success : function(result){
			if(result != null){
				$("#cgvCoupon .form_list .list_body .message").css("display","none");
			}
			
			for(i=0;i<result.length;i++){
				var name = result[i].couponInfoVO.name;
				var couponNum = result[i].couponInfoNum;
				var serialNum = result[i].couponInfoVO.serialNum;
				var eIssuance = result[i].couponInfoVO.eissuance;
				var count = result[i].couponInfoVO.count;
				var price = result[i].couponInfoVO.price;
				
				var arr = eIssuance.split("-");
				eIssuance = arr[0]+"."+arr[1]+"."+arr[2];
				
				makeCuponList(name,couponNum,serialNum,eIssuance,price,count);
			}
		}
	});
}


//쿠폰 리스트 생성 - 출력
function makeCuponList(name,couponNum,serialNum,eIssuance,price,count){
	var html = '<li class="row" data-price="'+ price +'" data-count="'+ count +'" data-coupon_num="'+ couponNum +'">'
		+ '<label>'
		+ '<span class="col col1">'+ name +'</span>'
		+ '<span class="col col2">'+ serialNum +'</span>'
		+ '<span class="col col3">'+ eIssuance +'</span>'
		+ '<span class="col col4">'
		+ '<input type="checkbox">'
		+ '</span>'
		+ '</label>'
		+ '</li>';
	
	$("#cgvCoupon .form_list .list_body ul").append(html);
}


//쿠폰은 하나만 체크 가능하도록
var checkedCoupon = false;
$("#discCoupon").on("click","#cgvCoupon ul li",function(evt){
	
	if($(this).find("input").prop("checked")){
		//선택 취소
		$(this).find("input").prop("checked",false);
		checkedCoupon = false;
		usePrice = 0;
		
		//할인 내역 삭제
		removeDiscount("cgvCoupon");
	}else{
		//선택
		if(checkedCoupon){
			$("#cgvCoupon ul li input").each(function(){
				$(this).prop("checked",false);
			});
		}
		usePrice = $(this).data("price");
		
		if(lastPrice - usePrice > 0){
			$(this).find("input").prop("checked",true);
			checkedCoupon = true;
			//할인내역 추가 - 폼 생성
			appendDiscount("cgvCoupon",1);
			
			//할인 금액 출력
			$("#cgvCoupon .form_result .price").text(addComma(usePrice));
		}else{
			alert("결제 금액보다 쿠폰액이 더 많아 사용이 불가능합니다.\n 쿠폰액 : "+addComma(usePrice)+"원");
		}
		
	}
	
	//2번 클릭 방지
	evt.preventDefault();
});




//할인 수단으로 포인트 선택시 ajax으로 해당 값들을 읽어옴
function discount_point_ajax(){
	var memberNum = $("#memberId").val();
	
	$.ajax({
		url : '../point/pointSelectList',
		type : 'get',
		data : {
			memberNum : memberNum
		},
		success : function(result){
			for(i=0;i<result.length;i++){
				var type = result[i].type;
				var price = result[i].price;
				
				switch (type) {
				case 'cjOnePointipt':
					$("#cjOnePoint .hasPoint").text(addComma(price));
					break;
				case 'cgvGiftPrePayipt':
					$("#cgvGiftPrePay .hasPoint").text(addComma(price));
					break;			
				}
			}
		}
	});
}


//사용금액창(input)클릭시 내용지움
$(".textBox2.type-n.nohan").click(function(){
	$(this).val("");
});


//포인트 사용 금액 적용 - input창
$(".textBox2.type-n.nohan").blur(function(){
	//보유 금액
	var hasPoint = removeComma($(this).parent().prev().prev().children().text());
	//사용금액
	usePrice = $(this).val();
	var chaPoint = hasPoint - usePrice;
	
	if(usePrice == 0){
		$(this).val(0);
		if(totalDiscount > 0){
			var id = $(this).attr("id");
			removeDiscount(id);
			checkboxValue(id);
		}
	}else if(chaPoint < 0){
		alert("보유하신 금액인 "+hasPoint+"보다 크게 입력하셨습니다.");
	}else if(usePrice < 1000){
		alert("최소 1,000P부터 사용 가능합니다.");
	}else if(usePrice % 10 != 0){
		alert("10P 단위로 사용 가능합니다.");
	}else{
//		console.log("usePrice : "+usePrice)
		console.log("lastPrice : "+lastPrice)
		if(usePrice > lastPrice){
			alert("사용하시려는 금액이 결제 금액보다 큽니다.");
		}else{
			//정상적인 사용가능 포인트
			var id = $(this).attr("id");
			appendDiscount(id,2);
		}
	}
});



//할인 내역 추가 + 총 할인 금액 계산
function appendDiscount(id,type){
	//생성하려는 아이디가 존재하면 삭제후 재생성
	if($("#"+id+"_del").length > 0){
        removeDiscount(id)
    }
	//총 할인액 갱신
	totalDiscount += (usePrice*1);
	discount_type = type;

	var html = '<dl>'
	+'<dt>' + selected_li + '</dt>'
	+'<dd><span class="num discountNum" data-type="'+ id +'">'+ addComma(usePrice) +'</span>'
	+'<span class="won">원</span>'
	+'<a class="discount_del" id="'+ id +'_del" href="#none"><span>적용취소</span></a>'
	+'</dd>'
	+'</dl>';
	
	//총 할인액 화면에 출력
	$("#summary_discount_list").append(html);
	$("#summary_discount_total").text(addComma(totalDiscount));
	
	
	//남은 결제 금액 출력
	lastPrice = totalPrice - totalDiscount;
	$("#summary_payment_total").text(addComma(lastPrice));
	$("#summary_payment_list .num").text(addComma(lastPrice));
	
}

//할인 내역 제거 + 가격 변환
function removeDiscount(id){
	//취소하는 할인내역에 있는 금액으로 totalDiscount 금액을 빼준다
	var delPoint = removeComma($("#"+ id +"_del").prev().prev().text());
	totalDiscount -= delPoint;
	
	//할인내역 지우고  +  총 할인내역 금액 화면에 출력
	$("#summary_discount_total").text(addComma(totalDiscount));
	$("#"+ id +"_del").parent().parent().remove();
	
	//취소하는 할인내역에 있는 금액으로 lastPrice 금액에 더한다
	totalPriceSum(delPoint);
}

//할인 취소시 할인 추가 전 금액으로 복귀
function totalPriceSum(delPoint){
	lastPrice += delPoint*1;
	
	//화면에 지불해야하는 금액 변경
	$("#summary_payment_total").text(addComma(lastPrice));
	$("#summary_payment_list .num").text(addComma(lastPrice));
	
}


//적용 포인트 X버튼 클릭시 취소
$("#summary_discount_list").on("click",".discount_del",function(){
	var delPoint = removeComma($(this).prev().prev().text());
	totalDiscount -= (delPoint*1);
	
	//해당 맞는 input id 값 도출  -> val값을 0으로 초기화
	var arr = [];
	arr = $(this).attr("id").split("_");
	var id = arr[0];

	if(id != 'cgvCoupon'){
		//포인트일때만 실행
		$("#"+id).val(0)
		checkboxValue(id);
	}else{
		//쿠폰일때만 실행
		$("#cgvCoupon ul li input").each(function(){
			$(this).prop("checked",false);
		});

		usePrice = 0;
		checkedCoupon = false;
		$("#cgvCoupon .form_result .price").text(0);
	}
	
	//할인 내역 삭제
	$(this).parent().parent().remove();
	
	//화면에 총 할인 내역 출력
	$("#summary_discount_total").text(addComma(totalDiscount));
	totalPriceSum(delPoint);
});


//포인트 - 모두 사용(checkbox)
//계산해야될 금액 - 잔여금액 < 0     :       계산해야될금액  
//계산해야될 금액 - 잔여금액 > 0     :		잔여금액 전부 (일의 자리 내림)
$(".secondTit").click(function(){
	//checked가 true이면
	
	if($(this).children().prop("checked") == true){
		
		if(lastPrice != 0){
			usePrice = removeComma($(this).parent().find(".hasPoint").text());
			
			if(lastPrice - usePrice < 0){
				usePrice = lastPrice;
			}else{
				usePrice = Math.floor(usePrice/10)*10;
			}
			lastPrice = lastPrice - usePrice;
			
			//input창에 출력
			$(this).parent().find("input").val(usePrice);
			//할인내역 추가
			var id = $(this).parent().find("input").attr("id");
			appendDiscount(id,2);
		}else{
			alert("남은 결제금액이 0원입니다.");
			$(this).find("input").prop("checked",false);
		}
		
		
	}else{
		if(totalDiscount > 0){
			var id = $(this).parent().find("input").attr("id");
			removeDiscount(id);
			$(this).parent().find("input").val(0);
		}
	}
	
});


//X버튼이나 0으로 선택 기능중 input val값이 0면 모두사용(Checkbox) false로 변경
function checkboxValue(id){
	if($("#"+id).val() == 0){
		console.log($("#"+id).parent().next().children().prop("checked",false));
	}
}

var selected_cuponNum = 0;
//할인 내역 조회해 리스트 생성 : 타입 - 금액
function discount_detail_list(){
	var list = [];
	$(".discountNum").each(function(){
		var type = $(this).data("type");
		var price = removeComma($(this).text());
		list.push(type+"_"+price);
		
		if(type == 'cgvCoupon'){
			$("#cgvCoupon ul li").each(function(){
				if($(this).find("span > input").prop("checked")){
					selected_cuponNum = $(this).data("coupon_num");
				}
			});
		}
		
	});
	discountList = list.join(",");
}








//포인트 및 기타 결제 수단 출력 내용 변경 
$("#discCoupon .discount_list li").click(function(){
	$("#discCoupon .discount_list li").removeClass("selected");
	$(this).addClass("selected");
	
	discount_form_change("#discCoupon ");
});

//포인트 및 기타 결제 수단 출력 내용 변경 
$("#payPoints .discount_list li").click(function(){
	$("#payPoints .discount_list li").removeClass("selected");
	$(this).addClass("selected");
	
	discount_form_change("#payPoints ");
});


//li selected값 변경 
function discount_form_change(selected){
	$(selected+".discount_list li").each(function(){
		if($(this).hasClass("selected")){
			selected_li = $(this).find("a").text();
			$(selected+".discount_form .form").css("display","none");
			
			var str = [];
			str = $(this).attr("id").split("_");
			
			$("#"+str).css("display","block");
		}
	});
}

//====================================
// CGV 할인쿠폰 등록
//====================================

//CGV할인 쿠폰 등록창 열기
$("#cgvCoupon .form_button a").click(function(){
	$(".blackscreen").css("display","block");
	$("#layer_popup_coupon").css("display","block");
});

//CGV 기프트카드 등록 창 닫기(CGV 기프트카드 창 닫기 함수 같이 이용)

//CGV할인 쿠폰 등록
function cgvCouponEnrollment(){
	var serialNum = $(".input_txt.wht").val();
	if(serialNum != ''){
		$.ajax({
			url : '../cuponInfo/cgvCouponEnrollment',
			type : 'post',
			data : {
				serialNum: serialNum,
				_csrf : $("#_csrf").val()
			},
			success : function(result){
				if(result > 0){
					alert("등록이 완료 되었습니다.");
					
					$("#cgvCoupon .form_list .list_body ul").empty();
					discount_cupon_ajax();
					
					window_close();
				}else if(result == -1){
					alert("이미 등록한 쿠폰입니다.");
				}else{
					alert("유효하지 않은 쿠폰입니다.");
				}
			}			
		});
	}else{
		alert("시리얼 번호를 입력해주세요.");
	}
}





//====================================
//CGV 기프티콘 등록
//====================================

//CGV 기프트카드 등록창 열기
$("#cgvGiftPrePay .tpm_coupon_button").click(function(){
	$(".blackscreen").css("display","block");
	$("#layer_popup_giftcon").css("display","block");
	
});


//CGV 기프트카드 창 닫기
function window_close(){
	$(".blackscreen").css("display","none");
	$(".ft_layer_popup.f_popup").css("display","none");
}

//CGV 기프트 카드 등록
function giftCardEnrollment(){
	var serialCode="";
	$(".inputCon.cardNum .input_txt").each(function(){
		serialCode += $(this).val();
	});
	
	var password = $(".inputCon.cardPw .input_txt").val();
	
	$.ajax({
		url : '../cuponInfo/cuponeEnrollment',
		type: 'post',
		data : {
			serialNum : serialCode,
			pwd : password,
			_csrf : $("#_csrf").val()
		},
		success : function(price){
			if(price > 0){
				alert("등록이 완료 되었습니다.");
				window_close();
				
				//출력되어있는 값 더하기
				var preVal = removeComma($("#cgvGiftPrePay .hasPoint").text());
				var updateVal = preVal + price; 
				$("#cgvGiftPrePay .hasPoint").text(addComma(updateVal));
			}
		}
	});
	
}


//====================================
//결제
//====================================


//간편 결제 클릭시 아래 수단 추가
//last_pay_radio3
$("#lastPayCon span").click(function(){
	$("#summary_payment_list dl dt").text($(this).find("label").text());
	
	if($(this).find("input").prop("checked") == true && $(this).val() == 3){
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
        buyer_name : data.name,
        buyer_tel : data.tel,
        m_redirect_url : 'https://www.yourdomain.com/payments/complete'
        	
    }, function(rsp) {
        if ( rsp.success ) {
            var msg = '결제가 완료되었습니다.';
            
            $.ajax({
            	url : '../payment/paymentInsert',
            	type : 'post',
            	data : {
            			imp_uid : rsp.imp_uid, //고유ID
            			merchant_uid : rsp.merchant_uid, //상점 거래ID 
            			apply_num : rsp.apply_num,   //결제 금액 
            			pay_method : rsp.pay_method,   //카드 승인번호 
            			pg : rsp.pg_provider,   //결제 방식 
            			_csrf : $("#_csrf").val()   //PG사
            	},
            	success : function(result){
            		if(result > 0){
            			alert(msg + "결제 번호 : "+result);
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


//예매 정보 + 좌석예매 정보 DB저장
function reservation_save(result){
	//할인 내역 할인 리스트 생성
	discount_detail_list();

	if(discountList == ""){
		discount_type = 0;
	}
	//회원 비회원 구분
	var memberType = 1; //회원
	if(beMemberVO != ''){
		memberType = 0; //비회원
	}
	
	var aa = { 
			movieNum : $("#movieNum").val(),
			paymentNum : result,
			movieTimeNum : $("#movieTimeNum").val(),
			uid : data.name,
			filmType : $("#filmType").val(),
			cinemaName : $("#cinemaName").val(),
			theaterName : $("#theaterName").val(),
			seats : $("#select_Seat").text(),
			totalPrice : totalPrice,
			common : commonCount,
			teenager : teenagerCount,
			preference : preferenceCount,
			
			selectedSeatNums : selectedSeatNumList.join(","),
			type : discount_type,
			couponNum : selected_cuponNum,
			
			discountList : discountList, 
			
			_csrf : $("#_csrf").val()
		}
	
	$.ajax({
		url : '../reservation/reservationInsert',
		type : 'post',
		data : aa,
		success : function(result2){
			if(result2 > 0){
				console.log("예매 번호 ");
				if(beMemberVO != ''){
					//비회원 테이블에  비회원 정보 저장
					guestVO.reservationNum = result2;
					non_MemberInfoInsert(guestVO);
				}
				
				//예매 결과 페이지
				reservation_result(result2);
			}
		}
	});
}



//====================================
//결제 완료
//====================================

//예매 결과
function reservation_result(data){
	$.get("../reservation/reservationResultSelectOne?num="+data,function(result){
		$(".step.step3").css("display","none");
		$(".ticket_tnb .tnb_container .tnb").removeClass("step3");
		$(".ticket_tnb .tnb_container .tnb").addClass("step4");
		
		//할인 - 결제수단 결정 페이지
		$(".ticket_tnb .tnb.step4 .btn-left").css("display","none");
		
		$(".step.step4").css("display","block");
		$(".step.step4").html(result);
	});
}


//비회원 정보 저장
function non_MemberInfoInsert(guestVO2){
	$.ajax({
		url :'../guest/guestInsert',
		type : 'post',
		data : guestVO2,
		success : function(result3){
			
		}
	})
}

















