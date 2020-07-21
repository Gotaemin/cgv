/**
 *		2.글자수 최소 제한(10글자이상)
 * 		만약 글자 수(10자)를 일정이상 채우지 않으면 팝업창o & 클릭x / 10자 이상이면 ajax로 내용 넘겨주고 수동으로 값비우고 닫아주기
 */

/* 만약 글자 수(10자)를 일정이상 채우지 않으면 팝업창o & 클릭x 
	/ 10자 이상이면 ajax로 내용 넘겨주고 수동으로 값비우고 닫아주기 */

	 var g_num = 0;
	 var g_egg = 0;
	 var g_mContents = ""; 
	 var g_charmPoint = 0;
	 var g_emotionPoint = 0;
	 
	 var g_title = "";
	
	 $("#submitBtn1").click(function(e){

		var mContents = document.getElementById("mContents");
		
		g_mContents= mContents;
		var eggList = document.getElementsByClassName("egg");
		for(i=0; i<eggList.length; i++){
			
			if(eggList[i].checked == true){
				g_egg = eggList[i].value;
				
				break;
			}
		}
		
		if(mContents.value.length>=10){
			
			if(confirm("관람평이 등록되었습니다.\n관람하신 영화의 관람 포인트를\n선택하시겠습니까?")== true){

				var popupBtn2List = document.getElementsByClassName('popupBtn2');
				
				for(i=0; i<popupBtn2List.length; i++){
					console.log(popupBtn2List[i].dataset.num);
					
					if(popupBtn2List[i].dataset.num == g_num){
						console.log("list.dataset.num : "+popupBtn2List[i].dataset.num);
						//2번째 모달로 이동
						//(i번째 2번째모달 이동버튼 클릭)
						popupBtn2List[i].click();
						break;
					}
				}
				
			}else{
				//여기서는 reservationNum, contents, egg정보만을 넘겨준다.
				
				console.log("아니오");
				
				$.ajax({

					type:"POST",
					url:"./review_Write1",
					data:{
						reservationNum : g_num,
						egg : g_egg,
						contents : g_mContents.value,
						_csrf : $("#_csrf").val(),
					},
					success:function(data){
						if(g_egg==1){//egg:1==좋아요 egg:0==싫어요
							$("#r"+g_num).html('<button class="popupOnlyRead" data-num2="'+g_num+'" title="'+g_num+'" style="border: 0; height: 27px;">'+
									'<img alt="" src="../images/good.JPG"></button>'+
									'<div class="sss" id="sss'+g_num+'"  data-toggle="modal" data-target="#myModal3" data-num2="'+g_num+'">좋았어요</div>')								
							alert("리뷰가 등록되었습니다.")
							
						}else{
							$("#r"+g_num).html('<button class="popupOnlyRead" data-num2="'+g_num+'" title="'+g_num+'" style="border: 0; height: 27px;">'+
									'<img alt="" src="../images/bad.JPG"></button>'+
									'<div class="sss" id="sss'+g_num+'"  data-toggle="modal" data-target="#myModal3" data-num2="'+g_num+'">별로예요</div>')
							alert("리뷰가 등록되었습니다.")
						}
					}
				})
				
			}
			
			//팝업창 닫히고 내용 초기화(mContents, data-dismiss="modal")

			
			$("#exit").click();

								
		}else{
			alert("문자를 포함하여 10자 이상(공백 제외) 작성하셔야 등록됩니다.");
			e.preventDefault();
			
		}
	
		 });

//	 ------------------------------------------------------------------------------
	 
	 //charmpoint
	 function getCharmPoint() {
		 
		var charmPoint = 0;
		 
		var values = document.getElementsByClassName("charmPoint");
		 
		for(var i=0; i<values.length; i++) {
			if(values[i].checked){
					
			charmPoint += values[i].dataset.charm * 1;
			}					
		}
		
		return charmPoint;
	 }
	 
	 //emotionpoint
	 function getEmotionPoint() {
		 
			var emotionPoint = 0;
			 
			var values = document.getElementsByClassName("emotionPoint");
			 
			for(var i=0; i<values.length; i++) {
				if(values[i].checked){
				emotionPoint += values[i].dataset.emotion * 1;
				}					
			}
			return emotionPoint;
		 }
	 
	 
//	 ------------------------------------------------------------------------------

	 
	 $("#submitBtn2").click(function(e){
		 //null값
		 g_charmPoint = getCharmPoint();
		 g_emotionPoint = getEmotionPoint();
		 
		if(g_charmPoint!=null && g_emotionPoint!=null){
		
			if(g_charmPoint==0){
				alert("매력포인트를 1개 이상 선택해주세요.")	
			} else{
				if(g_emotionPoint==0){
					alert("감정포인트를 1개 이상 선택해주세요.")
				}else {
					//여기서는 reservationNum, contents, egg, emotionPoint, charmPoint 정보를 넘겨준다.
					
					console.log(g_mContents.value);
					
					$.ajax({

						type:"POST",
						url:"./review_Write2",
						data:{
							reservationNum : g_num,
							egg : g_egg,
							contents : g_mContents.value,
							charmPoint: g_charmPoint,
							emotionPoint: g_emotionPoint,
							_csrf : $("#_csrf").val(),
						},
						success:function(data){
							if(g_egg==1){//egg:1==좋아요 egg:0==싫어요
								$("#r"+g_num).html('<button class="popupOnlyRead" data-num2="'+g_num+'" title="'+g_num+'" style="border: 0; height: 27px;">'+
										'<img alt="" src="../images/good.JPG"></button>'+
										'<div class="sss" id="sss'+g_num+'"  data-toggle="modal" data-target="#myModal3" data-num2="'+g_num+'">좋았어요</div>')
								alert("리뷰가 등록되었습니다.")
								
							}else{
								$("#r"+g_num).html('<button class="popupOnlyRead" data-num2="'+g_num+'" title="'+g_num+'" style="border: 0; height: 27px;">'+
										'<img alt="" src="../images/bad.JPG"></button>'+
										'<div class="sss" id="sss'+g_num+'"  data-toggle="modal" data-target="#myModal3" data-num2="'+g_num+'">별로예요</div>')
								alert("리뷰가 등록되었습니다.")
							}
							
							//기존 버튼
							
/*							var r = '<button type="button" class="sss" id="sss'+g_num+'"  data-toggle="modal" data-target="#myModal3" data-num2="'+g_num+'">리뷰쓴후</button>';
							
							$("#r"+g_num).html('<button type="button" class="btn btn-danger popupOnlyRead" data-num2="'+g_num+'">리뷰쓴후</button>'+r)*/
							
						}
					})
					
					 $("#exit2").click();
					 
						
				}
			}
		}
	 });
	 
	 
	 $("#submitBtn3").click(function(){
		 $("#exit3").click();
	 });

//	 ------------------------------------------------------------------------------
	 
/* 
		//닫기버튼 누르면 내용초기화 & 글자 바이트 초기화
	$("#exit").click(function(){
		document.getElementById("mContents").value ="";
		document.getElementById('bytes').innerText =0;
		
		});
	
	$("#exit2").click(function(){
		$(".charmPoint").prop("checked", false);
		$(".emotionPoint").prop("checked", false);
		});	

*/
	 
//	 ------------------------------------------------------------------------------
	 
	 //reviewMore
		var count=1;
		
		getList(count);
		
		$("#more").click(function(){
			count++;

			getList(count);
		});
		
		function getList(curPage){//처음 창을 열면 "getList?curPage=1" 이 형태였다가, 더보기를 누르면 count++되어서 1씩 증가된 정보가 curPage에 들어가게 된다.
			//ajax
			$.get("getList?curPage="+curPage, function(result){//getList에서 만들어진 정보를 result(임의의 이름)로 받아와서 #result의 해당태그 내 자식태그의 밑에서 부터 추가된다.
				$('#result').append(result);
				//alert($(".l_count:last-child").val());
				//$("#l_count1").html($(".l_count:last-child").val());
			
				
				//1.첫번째 모달
				$(".popupBtn1").click(function(){
					g_num=$(this).data("num");//jquery
					console.log(g_num);
					
					g_title=$(this).data("title");
					console.log(g_title);
					document.getElementById("title").innerHTML =g_title; //태그 사이에 넣을 값을 쓸때는 innerHTML (javaScript)
					
					document.getElementById("mContents").value ="";
					document.getElementById('bytes').innerText =0;
					
					//document.getElementById('popupBtn').dataset.num=$(this).data("num");
					$('input:radio[name="egg"][value=1]').prop('checked', true);
				});
				
				//2.두번째 모달
				$(".popupBtn2").click(function(){
				
					// init
					$(".charmPoint").prop("checked", false);
					$(".emotionPoint").prop("checked", false);
				});
				
				
				/* ---------reservation deleteAt=now()삽입---------- */
				$(".hd_btn").click(function(){
					g_num=$(this).data("num");
					
					if(confirm("내가본영화 목록에서 삭제됩니다.\n삭제하시겠습니까?")== true){
						//reservation deleteAt
						$.ajax({
							type:"GET",
							url:"./reservation_Delete",
							data:{
								num : g_num,
							},
							success:function(data){
								if(data!=null){
									alert("삭제 되었습니다.");
									location.reload();
									
									//review deleteAt
									$.ajax({
										type:"GET",
										url:"./review_Delete",
										data:{
											reservationNum : g_num,
										},
										success:function(){

										}
									})
								}
							}
						})

					}
				});
				
				
				//3. 세번째 모달
/*			$(".popupOnlyRead").click(function(){
					
					g_num=$(this).data("num2");
					console.log(g_num);
					$.ajax({
						type:"POST",
						url:"./review_Select",
						data:{
							reservationNum : g_num,
						},
						success:function(data){//여기서 data는 json
							$("#photo").html('<img alt="" src="../images/'+data.fileName+'" width="110px" height="154.6px">')
							$("#title1").html(data.title);
							$("#uid").html(data.uid);	
							$("#egg1").html(data.egg);
							$("#contents").html(data.contents);
							$("#createAt").html(data.createAt);	
							$("#sss"+g_num).click();
							
							}
						})
					
				});*/
				

				
			});
			
			//1.현재 getList의 curPage을 받는 function 안쪽에 , 2.getList꾸려주는 ajax 바깥에 쓰기
			
			var now = curPage * 10;
			var total = $("#total").attr("title")*1; //total에 있는 title이라는 속성값 가져오기 (정수로 변환이 안될수도 있으니 *1해주기)
			if(now>=total){ 
				$("#l_count1").html("("+total+"/"+total+")");
			}else {
				$("#l_count1").html("("+now+"/"+total+")");
			}
			
		}
		
		
			//getList안에 식을 넣으면 "getList(count);"로 인해 자동으로 일단 한번 출력되고
			// memberReview.jsp의 부모(result)영역의 위임으로 한번더 실행된다. //그러므로 getList에서 빼주어야함
			
			//이벤트위임(부모영역의 이벤트를 자식으로 전달)-작성한글 새로고침없이 바로 내용출력
			$("#result").on("click", ".popupOnlyRead",function(){
				
				g_num=$(this).data("num2");
				//g_num=$(this).attr("title");
				console.log(g_num);
				$.ajax({
					type:"POST",
					url:"./review_Select",
					data:{
						reservationNum : g_num,
						_csrf : $("#_csrf").val(),
					},
					success:function(data){//여기서 data는 json
						console.log(data);
						$("#photo").html('<img alt="" src="../images/movie/movieList/filmCover/'+data.fileName+'" width="110px" height="154.6px">')
						$("#title1").html(data.title);
						$("#uid").html(data.uid);	
						$("#egg1").html(data.egg);
						$("#contents").html(data.contents);
						$("#createAt").html(data.createAt);	
						
						$("#sss"+g_num).click();
						
						//모달 이미지 변경
						var d=$("#egg1").html();
						if(d==1){
							$("#egg1").html('<table class="p-div"><tr>'+
									'<td style="width: 10px;"><div style=\"background: url(\'../images/movie/movieList/sprite_egg.png\') no-repeat -20px -50px\" class=\"egg2\"></div></td>'+
									'<td style="font-weight: 600;">&nbsp;좋았어요</td>'+
									'</tr></table>');
							}else{
							$("#egg1").html('<table class="p-div"><tr>'+
									'<td style="width: 10px;"><div style=\"background: url(\'../images/movie/movieList/sprite_egg.png\') no-repeat -0px -50px\" class=\"egg3\"></div></td>'+
									'<td style="font-weight: 600;">&nbsp;별로예요</td>'+
									'</tr></table>');
							}
						
						}
					})
				
			});
			



		/* ---------delete---------- */
		
		$("#delete1").click(function(){
			if(confirm("작성한 평점을 삭제하시겠습니까?")== true){
				$("#exit3").click();
				$.ajax({
					type:"GET",
					url:"./review_Delete",
					data:{
						reservationNum : g_num,
					},
					success:function(data){
						if(data!=null){
							alert("삭제 완료");
							location.reload();
						}
					}
				})
					
			}
		});
		

		
		/* ---------내 평점 보기---------- */
		$("#look").click(function(){
			window.location.href='http://localhost/review/reviewLook';
		});
		
/*		function reviewLook(curPage){
			$.get("getList?curPage="+curPage, function(result){
				$('#result').append(result);
			}
		}*/
		
		