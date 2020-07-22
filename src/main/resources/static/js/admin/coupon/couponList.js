
//Page이동
$(".custompager").click(function(){
	var curPage = $(this).attr("title");
	$("#form-Data #curPage").val(curPage);

	$("#form-Data").submit();
});


switch(kind){
case '' :
	$("#all").prop("selected", true);
	break;
case '2' :
	$("#cgvCoupon").prop("selected", true);
	break;
case '1' :
	$("#cgvGiftcon").prop("selected", true);
	break;
}


//현재 날짜보다 시간이 빠르면 css 입힘(가독성용)
var nowDate = new Date();
$(".eIssuance").each(function(){

	var date = new Date($(this).text()+ "T23:59:59");
	if(nowDate >= date){
		$(this).parent().css("backgroundColor","lightgray")
	}

});

//가격에 콤마 적용
$(".price").each(function(){
	$(this).text(addComma($(this).text()));

});

//등록버튼 클릭
$("#btn-insert").click(function(){
	location.href="./couponInsert";
});


//삭제버튼 클릭
$(".btnDelete").click(function(){
	var check = confirm("삭제하시겠습니까?");
	if(check){
		var num = $(this).parent().prevAll(".num").text();
		location.href="./couponDelete?num="+num;
	}
});



















