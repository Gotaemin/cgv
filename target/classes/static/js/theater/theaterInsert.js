// 0 : 검은색(자리 없음)
// 1 : 테두리 노랑 = 주황
// 2 : 테두리 빨강
// 3 : 테두리 초록

var seatCount = 0;
var seatColor = 1;

function changeGrade(grade){
	seatColor = grade;
}

// seat list 생성
var list = [];
var listLength = 0;

function makeVo(row, col, grade){
	var vo = {
		"row":row,
		"col":col,
		"grade":1
	}
	list.push(vo);
}

var rowList = [];
var colList = [];

function spaceVO(){
	var l = [space, num]
	spaceList.push(vo);
}

//col select하면 row와 col의 값을 읽고
//숫자만큼의  .seats .seat_row  / .seats .seat_row .seat_group .seat 생성
//test부터


// 선택한 행, 열 수만큼 seat 생성
function changeSelect(){
	$("#seats_list").empty();
	list.length = 0;
	rowList.length = 0;
	colList.length = 0;
	//list = [];
	//console.log(rowList);
	//console.log(colList);

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
		+'<span class="row_plus" onclick="rowPlus('+i+')"><img src="../../images/theater/plus.png" id="img"></span>'
		+'<div class="label">'+ch+'</div><div class="seat_group" id="r'+i+'">');
		
			for(j=1; j<=col; j++){
				makeVo(ch, j, 1);
				
				$("#r"+i).append('<div class="seat c'+j+'"><span class="sb" onclick="checkSeat('+ch+j+')"  name="'+ch+j+'" id="'+ch+j+'"><span class="no">'+j+'</span></span></div>')	
				
				//첫번째 로우라면  버튼 만들기
				if(i<1){
				$("#r"+i).find(".c"+j).append(
				'<span class="col_plus" onclick="colPlus('+j+')"><img src="../../images/theater/plus.png" id="img"></span>'+
				'<div class="col_label">'+j+'</div>');
				}	

				console.log(list)
				
			}
			
			$("#r"+i).append('<span id="arrow'+i+'" class="arrow" name="'+ch+'"><img src="../../images/theater/arrow.png" class="arrow-img" /></span>')
			
		$("#seats_list").append('</div></div>');		
		listLength = list.length;
		

		//console.log(rowList);
		//console.log(colList);
	}
	
	//마지막 행, 열의 space 조정 버튼 지우기
	$(".c"+col).find(".col_plus").remove();
	$(".r"+row).find(".row_plus").remove();
	
}

// seat grade 조정
function checkSeat(name){
	var grade=1; 
	var chName = $(name).attr("name");
	var chClass = $(name).attr("class");
	var rw = chName.substring(0,1);
	var cl = chName.substring(1); 

	//좌석 삭제
	if(seatColor==0){
		
		if(chClass=='rating_delete'){
			//$(name).attr("name","");
			$(name).removeClass();
			$(name).addClass("rating_economy")
			for(i=0; i<listLength; i++){
				if(list[i].row == rw && list[i].col == cl){
					list[i].grade = 1;
					//console.log("-----------:"+list[i].grade);
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
					//console.log("-----------:"+list[i].grade);
				}
			}
			
			grade=0;

			seatCount -= 1;
			$("#seatCount").val(seatCount);
		}
	}else if(seatColor==1){

	//Economy

		// 테두리 색 맞게 바꾸기
		// vo.grade = 1
		if(chClass!='rating_delete'){
		$(name).removeClass();
		$(name).addClass("rating_economy");
			for(i=0; i<listLength; i++){
				if(list[i].row == rw && list[i].col == cl){
					list[i].grade = 1;
					//console.log("-----------:"+list[i].grade);
				}
			}
		}
	}else if(seatColor==2){

	//Standard
		// 테두리 색 맞게 바꾸기
		// vo.grade = 2 
		if(chClass!='rating_delete'){
		$(name).removeClass();
		$(name).addClass("rating_standard");
		
			for(i=0; i<listLength; i++){
			
				if(list[i].row == rw && list[i].col == cl){
					list[i].grade = 2;
					console.log(list[i].row + " / " + list[i].col + " / " + cl);
					//console.log("-----------:"+list[i].grade);
				}
			}
		}
	}else if(seatColor==3){

	//Prime
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
	}

	//console.log(rowList);
	//console.log(colList);
}


//한 줄 seat grade 조정
//$(".arrow").each(function(){
//	console.log("123");
//	alert("test");
//	$(this).click(function(){
//		alert("하핳ㅎㅎㅎㅎ")
//		var ch = $(this).attr("name");
//		//해당 r의 col의 개수....어케구하지?
//		//1) list에서 
//		//2) parent() -> 그룹 안에 있는 seat의 개수
//		var length = colList.length;
//		alert("length : " + length);
//		
//	});
//	
//});


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
	var c = '.r'+(i+1);	//r1
	$(c).after('<p class="row_space rs'+(i+1)+'"></p>');
	rowList.push(i+1);
	//console.log(rowList);
	//아이콘이 -로 바뀌고 
	//class, onclick, src 변경
	
	$(c).find(".row_plus").attr("onclick","rowMinus("+(i)+");");
	$(c).find(".row_plus").find("#img").attr("src","/images/theater/minus.png");
	$(c).find(".row_plus").attr("class","row_minus");
}


function rowMinus(i){
	//p태그 지우기
	//List에서 i 제거하기
	//console.log(i + ">.<");
	
	$(".rs"+(i+1)).remove();

	for(l=0; l<rowList.length; l++){
		if(rowList[l]=(i+1)){
			rowList.splice(l,1);
			//console.log(rowList);
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
	//console.log(colList);
	$(c).find(".col_plus").attr("onclick","colMinus("+j+");");
	$(c).find(".col_plus").find("#img").attr("src","/images/theater/minus.png");
	$(c).find(".col_plus").attr("class","col_minus");
}

function colMinus(j){
	//console.log(j);
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



// submit
$("#btn_insert").click(function(){

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
	
		// grade가 0인 것 앞쪽으로 정렬 후 list에서 제거
		list.sort(function(a,b) {
			return a["grade"] - b["grade"];
		});
	
		var cnt = 0; 
		
		for(i=0; i<listLength; i++){
			if(list[i].grade=="0"){
				cnt = cnt+1;
			}
			//console.log(list[i]);
		}
		//console.log(cnt);
		list.splice(0,cnt);
	
		
		// list - row, col, grade / row_space / col_space -> form 안에 hidden으로 넣기
		for(k=0; k<list.length; k++){
			
			console.log(list[k].row+""+list[k].col+ " : "+list[k].grade)
			
			var r = '<input type="hidden" name="row" value="'+list[k].row+'">';
			r = r + '<input type="hidden" name="col" value="'+list[k].col+'">';
			r = r + '<input type="hidden" name="grade" value="'+list[k].grade+'">';
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
		$("#frm").submit();
	}else if(typeCheck == false){
		alert("필름타입은 적어도 한개 체크해야합니다!");
	}

});
