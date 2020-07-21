/**
 * 
 */


var page1 = 0;
var num4 = $(".num4").val(); //영화번호
var uid = $(".username").val(); //아이디 세션값

var select1 = "../review/movieSelect2";
var reservationNum = 0; //나머지 

var g_num = 0; //리뷰 수정,작성 (=reservationNum)
var g_title = "";
var g_egg = 0;
var g_contents = "";

var g_emotionPoint = 0;
var g_charmPoint = 0;

//페이지 들어가면 바로 실행(리뷰리스트)
window.onload = function () {
   $.ajax({
      type:"GET",
      url:"../review/movieSelect2",
      data:{
         movieNum : num4,
         
      },
      success:function(data){
         //html로 받음
         $("#ajax_ms").html(data);

         
         var totalCount = $("#totalCount").val();
         console.log("토탈:"+totalCount);
         $("#reviewer").html(totalCount);
         

      }
   })
}

 
 //페이지 버튼 > 이벤트 위임
$("#ajax_ms").on("click",".page1",function(){

   page1 =$(this).attr("data-page1");
	
       $.ajax({
         type:"GET",
         url:select1,
         data:{
            movieNum : num4,
            curPage : page1,
         },
         success:function(data){
            $("#ajax_ms").html(data);
         }
   
      })
      
}); 

/* ------------------------------------------------ */
//최신순
function newBtn(){
   select1="../review/movieSelect2";
   aa(select1);
   
}

//추천순
function recBtn(){
   select1="../review/movieSelect3";
   aa(select1);
}

function aa(url){
   $.ajax({
      type:"GET",
      url:url,
      data:{
         movieNum : num4,
         
      },
      success:function(data){
         //html로 받음
         $("#ajax_ms").html(data);

         
         var totalCount = $("#totalCount").val();
         console.log("토탈:"+totalCount);
         $("#reviewer").html(totalCount);

      }
   })
}


/* ------------------------------------------------ */
//... 버튼을 클릭하면 신고버튼 켜짐
var btn_delete = true;

 $("#ajax_ms").on("click",".btn_notify",function(){

   reservationNum =$(this).attr("data-reservation");
   var reservationNum1 = String(reservationNum); //숫자>문자

   if(btn_delete){
      $('#btn'+reservationNum).addClass('btn_on');
      btn_delete=false;   
   }else{
      $('#btn'+reservationNum).removeClass('btn_on');
      btn_delete=true;
   }
}); 

/* ------------------------------------------------ */
//checkLike > 1.like 2.spoiler 3.swearword
//스포일러 신고
$("#ajax_ms").on("click",".lii1",function(){
   reservationNum =$(this).attr("data-reservation");

   if(uid!=""){
      if(confirm("평점 내용에 스포일러가 포함되어 있습니까?")){
         $.ajax({
            type: "GET",
            url: "../review/reviewSpoiler",
            data:{
               reservationNum : reservationNum,
               uid : uid,
               movieNum : num4,
            },
            success:function(data){
               if(data>0){
                  alert("신고가 성공적으로 접수되었습니다.");
               
               }else{
               //alert(data.trim());
                  alert("이미 스포일러 신고를 누르셨습니다.");
               }
   
             }
         })   
      }      
   }else{
      if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")){
         window.location.href='http://localhost/member/login';
      }
   }
});

//욕설,비방 신고
$("#ajax_ms").on("click",".lii2",function(){
   reservationNum =$(this).attr("data-reservation");

   if(uid!=""){
      if(confirm("평점 내용에 욕설/비방성 내용이 포함되어 있습니까?")){
         $.ajax({
            type: "GET",
            url: "../review/reviewSwearWord",
            data:{
               reservationNum : reservationNum,
               uid : uid,
               movieNum : num4,
            },
            success:function(data){
               if(data>0){
                  alert("신고가 성공적으로 접수되었습니다.");
               
               }else{
               //alert(data.trim());
                  alert("이미 욕설/비방 신고를 누르셨습니다.");
               }
   
             }
         })   
      }
   }else{
      if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")){
         window.location.href='http://localhost/member/login';
      }
   }
});

/* ------------------------------------------------ */

//좋아요 버튼 > 이벤트 위임
$("#ajax_ms").on("click",".date",function(){
   //좋아요 아이디당 한개만 가능 (좋아요 눌렀을때 현재 session값있는지 확인)
   

   if(uid!=""){
      reservationNum =$(this).attr("data-reservation");

       $.ajax({
         type: "GET",
         url: "../review/reviewLike",
         data:{
            reservationNum : reservationNum,
            uid : uid,
            movieNum : num4,
         },
         success:function(data){
            //alert("성공 "+"최신?추천?"+select1+"영화번호?"+num4+"현재페이지?"+page1);
            //../review/movieSelect3 + 1 + 1
            
            if(data>0){
            alert("추천하였습니다.");
            
            }else{
            //alert(data.trim());
            alert("이미 좋아요를 누르셨습니다.");
            }


            $.ajax({
               type:"GET",
               url: select1,
               data:{
                  movieNum : num4,
                  curPage : page1,
               },
               success:function(data){
                  $("#ajax_ms").html(data);
               }
            })
             
         }
      })
   }else{
      if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")){
         window.location.href='http://localhost/member/login';
      }
   }
   
});

/* ------------------------------------------------ */



//리뷰 update, write
function review_Modal(){
   //0. 로그인 확인
   if(uid!=""){
   //1. 이영화를 봤는지 확인(아이디와 영화번호에 해당하는 "reservation 정보"가 있는지 먼저 확인)
   //2. 해당 영화를 봤다면 리뷰가 한개이상인지 확인 (리뷰>0 = 수정 , 리뷰=0 = 작성)
        $.ajax({
         type:"GET",
         url: "../review/review_Modal",
         data:{
            uid : uid,
            movieNum : num4
         },
         success:function(data){
            if(data==1000000){ //해당 영화를 보지 않았을 경우에
               if(confirm("실관람객에 한하여 관람평 작성이 가능합니다.\n실관람객 등록 페이지로 이동하시겠습니까?")){
                  window.location.href='http://localhost/review/reviewList';
               }
            //가장 최신쓴 "리뷰"의 reservationNum구하기(createAt은 notnull deleteAt은 null) 
            //data가 0이면 작성, 숫자나오면 수정
            }else if(data>=1){
               if(confirm("이미 관람평 작성을 완료하셨습니다. 관람평을 수정하시겠습니까?\n(해당 영화의 리뷰를 2개 이상 작성하였을 시 가장 최신예매순의 리뷰가 수정됩니다.)")){
                    $.ajax({
                     type:"GET",
                     url: "../review/movieSelect_reviewUpdate",
                     data:{
                        uid : uid,
                        movieNum : num4
                     },
                     success:function(data){
                         //console.log(data);
                         //alert(data.contents);
                         g_num = data.reservationNum
                         g_title = data.title;
                         g_egg = data.egg;
                         g_contents = data.contents;

                         document.getElementById("title").innerHTML =g_title; 
                         
                         if(g_egg==1){
                            $('input:radio[name="egg"][value=1]').prop('checked', true);
                         }else{
                             $('input:radio[name="egg"][value=0]').prop('checked', true);
                         }
                        //내용 가져오기
                         document.getElementById("mContents").value =g_contents;
                         //글자 byte조회
                        CheckByte(document.getElementById("mContents"));
                         
                        $("#myModal").modal({backdrop: 'static', keyboard: false});
                     }   
                  })
               }   
            }else if(data==0){
               //해당 영화의 가장 최근 reservation num에다 review작성(가장 최신순)
               alert("해당 영화의 예매내역이 2건 이상 있는 경우 가장 최근예매순으로 리뷰가 작성됩니다.");
               $.ajax({
                  type:"GET",
                  url: "../review/movieSelect_reviewWrite",
                  data:{
                     uid : uid,
                     movieNum : num4
                  },
                  success:function(data){
                     g_num = data.num; //reservationNum
                     g_title = data.title;

                     console.log("dddddddd "+g_num);
                     console.log("dddddddd "+g_title);
                     
                     
                     document.getElementById("title2").innerHTML =g_title; 
                     //egg초기화
                     $('input:radio[name="egg2"][value=1]').prop('checked', true);
                     
                     //contents초기화
                     document.getElementById("mContents2").value ="";
                     //글자 byte조회
                     CheckByte2(document.getElementById("mContents2"));
                     
                     $("#myModall").modal({backdrop: 'static', keyboard: false});
                  }
               })
               
            }
         }
      })  

      
   }else{
      if(confirm("로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?")){
         window.location.href='http://localhost/member/login';
      }
   }   

}



// 리뷰작성 시작============================================================================
    $("#submitBtn11").click(function(e){

       var mContents = document.getElementById("mContents2");
       g_contents = mContents.value;
       console.log("???: "+g_contents);
      var eggList = document.getElementsByClassName("egg2");
      for(i=0; i<eggList.length; i++){
         
         if(eggList[i].checked == true){
            g_egg = eggList[i].value;
            console.log("egg:"+g_egg);
            break;
         }
      }
      
      if(mContents.value.length>=10){
         
         if(confirm("관람평이 등록되었습니다.\n관람하신 영화의 관람 포인트를\n선택하시겠습니까?")== true){

            $("#popupBtn2").click();
            
         }else{
            //여기서는 reservationNum, contents, egg정보만을 넘겨준다.
            
            console.log("아니오");

            $.ajax({

               type:"POST",
               url:"../review/review_Write1",
               data:{
                  reservationNum : g_num,
                  egg : g_egg,
                  contents : g_contents,
                  _csrf : $("#_csrf").val(),
               },
               success:function(data){
                  location.reload();
               }
            })
            
         }

         $("#exitt").click();
               
      }else{
         alert("문자를 포함하여 10자 이상(공백 제외) 작성하셔야 등록됩니다.");
         e.preventDefault();
         
      }
   
       });


    $("#submitBtn22").click(function(e){
       //null값
       g_charmPoint = getCharmPoint2(); //function이름
       g_emotionPoint = getEmotionPoint2(); //function이름

       console.log("g_charmPoint: "+g_charmPoint);
       console.log("g_emotionPoint: "+g_emotionPoint);
       
      if(g_charmPoint!=null && g_emotionPoint!=null){
      
         if(g_charmPoint==0){
            alert("매력포인트를 1개 이상 선택해주세요.")   
         } else{
            if(g_emotionPoint==0){
               alert("감정포인트를 1개 이상 선택해주세요.")
            }else {
               //여기서는 reservationNum, contents, egg, emotionPoint, charmPoint 정보를 넘겨준다.
               
               $.ajax({

                  type:"POST",
                  url:"../review/review_Write2",
                  data:{
                     reservationNum : g_num,
                     egg : g_egg,
                     contents : g_contents,
                     charmPoint: g_charmPoint,
                     emotionPoint: g_emotionPoint,
                     _csrf : $("#_csrf").val(),
                  },
                  success:function(data){
                     alert("등록이 완료되었습니다.");
                     location.reload();
                  }
               })
               
                $("#exitt2").click();
                
                  
            }
         }
      }
    });


//    ------------------------------------------------------------------------------
    
    //charmpoint
    function getCharmPoint2() {
       
      var charmPoint = 0;
       
      var values = document.getElementsByClassName("charmPoint2");
       
      for(var i=0; i<values.length; i++) {
         if(values[i].checked){
               
         charmPoint += values[i].dataset.charm * 1;
         }               
      }
      
      return charmPoint;
    }
    
    //emotionpoint
    function getEmotionPoint2() {
       
         var emotionPoint = 0;
          
         var values = document.getElementsByClassName("emotionPoint2");
          
         for(var i=0; i<values.length; i++) {
            if(values[i].checked){
            emotionPoint += values[i].dataset.emotion * 1;
            }               
         }
         return emotionPoint;
       }
    
    
//    ------------------------------------------------------------------------------
    
// 리뷰작성 끝============================================================================
   
   
// 리뷰수정 시작============================================================================
   
//모달 수정 >>> 첫번째 모달 확인버튼 클릭시
$("#submitBtn1").click(function(e){
var mContents = document.getElementById("mContents");
g_contents = mContents.value;

var eggList = document.getElementsByClassName("egg");
for(i=0; i<eggList.length; i++){
   if(eggList[i].checked == true){
      g_egg = eggList[i].value;
      console.log("egg:"+g_egg);
      break;
   }
}

if(mContents.value.length>=10){
   
   if(confirm("관람평이 수정되었습니다.\n관람하신 영화의 관람 포인트를\n선택하시겠습니까?")== true){

      var Up_popupBtn2List = document.getElementsByClassName('Up_popupBtn2');
      
      for(i=0; i<Up_popupBtn2List.length; i++){
         if(Up_popupBtn2List[i].dataset.num3 == g_num){
            console.log("list.dataset.num : "+Up_popupBtn2List[i].dataset.num3);
            //2번째 모달로 이동
            //(i번째 2번째모달 이동버튼 클릭)
            Up_popupBtn2List[i].click();
            break;
         } 
      }
      
   }else{
      //여기서는 reservationNum, contents, egg정보만을 넘겨준다.
      
      console.log("아니오");
      
      $.ajax({

         type:"GET",
         url:"../review/review_Update1",
         data:{
            reservationNum : g_num,
            egg : g_egg,
            contents : g_contents,
            _csrf : $("#_csrf").val(),
         },
         success:function(data){
            alert("수정이 완료되었습니다.");
            location.reload();
            
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



//모달 수정22 >>> 2번째 모달들어갈때 checked초기화
$(".Up_popupBtn2").click(function(){
   
   // init
   $(".charmPoint").prop("checked", false);
   $(".emotionPoint").prop("checked", false);
});

//3. 두 번째 모달
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

               $.ajax({

               type:"GET",
               url:"../review/review_Update2",
               data:{
                  reservationNum : g_num,
                  egg : g_egg,
                  contents : g_contents,
                  charmPoint: g_charmPoint,
                  emotionPoint: g_emotionPoint,
                  _csrf : $("#_csrf").val(),
               },
               success:function(data){
                  alert("수정이 완료되었습니다.");
                  location.reload();
                  
               }
            }) 
            
             $("#exit2").click();
             
               
         }
      }
   }
 });


      
//    ------------------------------------------------------------------------------
    
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
    
    
//    ------------------------------------------------------------------------------
// 리뷰수정 끝===========================================================================

