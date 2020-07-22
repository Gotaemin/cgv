<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    


<div class="section section-complement">
    <div class="col-head">
        <!--<img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/title_complement.png" alt="예매 완료" />-->
    </div>
	<div class="col-body">
        <div class="article result">
            <div class="text_complement"><img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/step4/text_complement.png" alt="예매가 완료 되었습니다."> </div>
			
            <div class="ticket_summary_wrap">
                <div class="ticket_summary">
                    <div class="poster"><img src="/images/movie/movieList/filmCover/${reservationVO.movieImageVO.fileName}" alt=""></div>
                    <table>
                        <caption>예매정보</caption>
                        <thead></thead>
                        <tbody>
                            <tr class="ticket_no">
                                <th scope="row">예매번호</th> 
                                <td><span class="red">${reservationVO.num}</span></td>
                            </tr>
                            <tr class="movie_name">
                                <th scope="row">영화</th>
                                <td><em></em>${reservationVO.movieInfoVO.title}</td>
                            </tr>
                            <tr class="theater">
                                <th scope="row">극장</th>
                                <td><em><span class="theater_name"></span>${reservationVO.cinemaName} / ${reservationVO.theaterName}<span class="theater_loc"></span></em></td>
                            </tr>
                            <tr class="movie_date">
                                <th scope="row">일시</th>
                                <td><em></em></td>
                            </tr>
                            <tr class="people">
                                <th scope="row">인원</th>
                                <td><em></em></td>
                            </tr>
                            <tr class="seat">
                                <th scope="row">좌석</th>
                                <td><em>${reservationVO.seats}</em></td>
                            </tr>
                            <tr class="payment_price">
                                <th scope="row">결제금액</th>
                                <td><span class="price"></span> 원</td>
                            </tr>
                            <tr class="payment_method">
                                <th scope="row">결제수단</th>
                                <td>
                                    <div class="row">
                                        <span class="title"><em>${reservationVO.paymentVO.pay_method}</em></span>
                                        <span class="content">
                                        	<span class="price"></span>
										</span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="ticket_exception">
                <em>CGV 청담씨네시티는 대중교통이용을 권장합니다.</em><br>
                <span class="desc">발레파킹을 이용하실 수 있으나, 가능 차량수가 한정적이며 주변 교통상황에 따라 지연될 수 있습니다.</span>
            </div>
            <div class="ticket_button_group"><div>
                <a class="btn_step4 btn_result_smssend" href="#" onclick="return false;"><span>예매결과 SMS발송</span></a>
                <a class="btn_step4 btn_red btn_ticket_check" id="ticket_cancle" data-index="${reservationVO.num}" href="#" onclick="return false;"><span>예매확인/취소</span></a>
            </div></div>
            <div class="ticket_instructions">
                <dl>
                    <dt><img src="http://img.cgv.co.kr/CGV_RIA/Ticket/image/reservation/step4/text_ticket_instructions.png" alt="예매 유의 사항"></dt>
                    <dd>
                        <ul>
                            <li>CJ ONE 포인트는 상영일 익일 적립됩니다.<em>(영화관람권, 비회원 예매 제외)</em></li>
                            <li>영화 상영 스케줄은 영화관사정에 의해 변경될 수 있습니다.</li>
                            <li>비회원 예매하신 경우는 예매내역이 이메일로  발송되지 않습니다.</li>
                        </ul>
						
					</dd>
                </dl>
            </div>
        </div>
    </div>
</div>

<script>

dateForm();
personnel();
discountInfo();

//하단바 
$("#ticket_tnb").css("display","none");

//총 결제액
$(".ticket_summary .payment_price .price").text(addComma(`${reservationVO.totalPrice}`));

//날짜 포맷
function dateForm(){
	var screenDate = `${reservationVO.movieTimeVO.screenDate}`;
	var screenTime = `${reservationVO.movieTimeVO.screenTime}`;
	var endTime = `${endTime}`;
	
	var arr = [];
	arr = screenDate.split("-");
	var y = arr[0];
	var m = arr[1];
	var d = arr[2];

	$(".ticket_summary .movie_date em").text(y+"년 "+m+"월 "+d+"일 "+screenTime+"~"+endTime);
}

//인원
function personnel(){
	var common = `${reservationVO.common}`;
	var teenager = `${reservationVO.teenager}`;
	var preference = `${reservationVO.preference}`;

	var personnelList =[];
	if(common > 0){
		personnelList.push("일반: "+common);
	}
	if(teenager > 0){
		personnelList.push("청소년: "+teenager);
	}
	if(preference > 0){
		personnelList.push("우대: "+preference);
	}
	
	$(".ticket_summary .people em").text(personnelList.join(","));
}

//할인 금액 정보 
// 형식 :  (CJ ONE 포인트 <span class="price">3,000</span>원)
function discountInfo(){
	var list = [];
	
	<c:forEach var="vo" items="${discountInfoList}">
		var discountInfoVO = {
			type : `${vo.type}`,
			discountPrice : `${vo.discountPrice}`
		}
		
		list.push(discountInfoVO);
	</c:forEach>

	var html = "원 ";	
	var discountTotal = 0;
	
	for(i=0;i<list.length;i++){
		var type = list[i].type;
		var discountPrice = list[i].discountPrice;

		discountTotal += (discountPrice*1);
		
		var str = "";
		
		switch(type){
		case 'cjOnePointipt':
			str = "CJ ONE 포인트";
			break;
		case 'cgvGiftPrePayipt':
			str = "CGV GIFT 포인트";
			break;
		case 'cgvCoupon':
			str = "CGV 할인 쿠폰";
			break;
			
		}
		html = html + '('+ str +' <span class="price">' + discountPrice + '</span>원)';
		console.log(html);
	}

	var totalPrice = `${reservationVO.totalPrice}`;
	console.log("------------------------")
	console.log("총 금액 : "+totalPrice);
	console.log("타입 : "+ typeof totalPrice);

	console.log("총 할인액 : "+discountTotal);
	console.log("타입 : "+ typeof discountTotal);
	console.log("------------------------")

		
	var paymentPrice = (totalPrice)*1 - discountTotal

	console.log("실 결제액 : "+paymentPrice);
	console.log("타입 : "+ typeof paymentPrice);
	console.log("------------------------")

	//할인정보 추가
	$(".payment_method .content .price").after(html);
	//실 결제액 추가
	$(".payment_method .content .price:first").text(addComma(paymentPrice));

}

</script>
<script type="text/javascript" src="/js/movie/movieReservationResult.js"></script>












