<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${pageContext.request.contextPath}/css/movie/movieSelect.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/css/movie/movieSelect2.css" rel="stylesheet" type="text/css"><!-- review -->

<link href="../css/layout.css" rel="stylesheet" type="text/css">
<link href="../css/review/reviewList.css" rel="stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<!-- chart CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />

<!-- <link href="../css/template/modal.css" rel="stylesheet" type="text/css"> -->

<!-- BootStrap 3 -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<title>영화상세 | 영화 그 이상의 감동. CGV</title>

</head>
<body>


<div class="root">
   <!-- 헤더 -------------------------------------------------------------------------------------->
   <c:import url="../template/header2.jsp"></c:import>
   
   <!-- 컨테이너 -------------------------------------------------------------------------------------->
   <input type="hidden" id = "gTotal" value="${gTotal}">
   <input type="hidden" value="${vo.num}" class="num4">
   
   <input type="hidden" value="${memberVO.username}" class="username">
   <%-- <input type="hidden" value="${sessionScope.memberBasicVO.username}" class="username"> --%>
   
   <input type="hidden" id="_csrf" name="${_csrf.parameterName}" value="${_csrf.token}" />
  
   <div class="container2" >
      <div class="c_nav">
         <div class="nav_linemap">
            <ul>
               <li>
                  <a href="../" class="a">
                     <img alt="go to Home" src="../images/login/btn_home.png">               
                  </a>
               </li>
               <li>
                  <a href="" class="a">영화</a>
               </li>
               <li class="last">
                  영화상세
               </li>
            </ul>
         </div>
      </div>
      
      <div class="contents">
         <div class="wrap-movie-detail" id="select_main">
            <div class="tit-heading-wrap">
               <h3>영화상세</h3>
               
            </div>
            <div class="sect-base-movie">
               <div class="box-image"  >
               <a href="" class="a">
                  <span class="thumb-image">
                     <img  class="box-image" alt="" src="../images/movie/movieList/filmCover/${vo.movieImageVOs[0].fileName}">
                     <span class="icon-grade grade-${list.ageLimit}">${list.ageLimit}</span>
                  </span>
               </a>
               </div>
               <div class="box-contents">
                  <div class="title">
                     <span id="title1">${vo.title}</span>
                     <em class="round lightblue">
                        <span>현재 상영중</span>
                     </em>
                     <p>${vo.titleEng}</p>
                  </div>
                  
                  <div class="score" >
                     <span class="strong percent">
                        예매율&nbsp;
                        <span>${vo.rate}</span>
                     </span>
                  
                  
                     <div class="egg-gage small" style="background: url('../images/movie/movieList/bg_writeinfo.gif') 0 12px no-repeat;">
                           <!--   <img alt="" src="../images/movie/movieList/sprite_egg.png">-->
                           
                           <!-- <div class="egg great" id="this" style="background:url('../images/movie/movieList/sprite_egg.png')" ></div> -->
                           <c:if test="${vo.errRate lt 50 }">
                           <!-- 터진  계란  -->
                           <span class="egg great" id="this" style="background:url('../images/movie/movieList/sprite_egg.png') no-repeat -0px -47px"></span>
                           </c:if>
                           
                           <c:if test="${vo.errRate lt 70 && vo.errRate ge 50 }">
                           <!-- 왕관없는 계란  -->
                           <span class="egg great" id="this" style="background:url('../images/movie/movieList/sprite_egg.png') no-repeat -18px -47px"></span>
                           </c:if>
                           
                           <c:if test="${vo.errRate ge 70 }">
                           <!-- 왕관있는 계란 -->
                            <span class="egg great" id="this" style="background:url('../images/movie/movieList/sprite_egg.png') no-repeat -38px -47px"></span> 
                           </c:if>
                        <span class="percent">${vo.errRate}%</span>
                     </div>
                  </div>
                  
                  
                  <div class="spec">
                     <dl>
                        <dt>감독 :&nbsp;</dt>
                        <dd><a href="" class="a">${vo.director}</a></dd>
                        <dd></dd>
                        <dt>&nbsp;/ 배우 :&nbsp;</dt>
                        <dd class="on">
                           <a href="" class="a">${vo.actor}</a>
                        </dd>
                        <dt>장르 :&nbsp;</dt>
                        <dd>${vo.ganre}</dd>
                        <dt>&nbsp;/ 기본 : &nbsp;</dt>
                        <dd class="">${vo.ageLimit}세 이상,&nbsp;${vo.runtime}분,&nbsp;${vo.country}</dd>
                        <br>
                        <dt>개봉 : &nbsp;</dt>
                        <dd class="on">${vo.openDate}</dd>
                     </dl>
                  </div>
                  <span class="screentype">
                  
                  </span>
                  
                  
                  <span class="like">
                     <a class="link-count" href="" class="a">
                        <i class="sprite_preegg1 btn_md default"></i>
                       		 프리에그
                     </a>
                     <a class="link-reservation a" href="/movie/movieReservation?num=${vo.num}" style="background-image: url('../images/movie/movieList/sprite_btn.png')">예매</a>
                  </span>
                  
               </div>
               </div>
               <!--여기까지가 상영시간, 감독 등등 나오는 곳----------------------------------------------------------------------------------------------------->

               <!----------------------------------------------------------------------------------------------------- contents detail -->
               <div class="cols-content" id="menu" >
               <div class="col_detail">
               
               <ul class="tab-menu">
                  <li class="on" >
                     <a title="현재 선택됨" href="" class="a">주요정보</a>
                  </li>
                  <li>

                     <a href="javascript:window.scrollTo(0,500);" >트레일러</a>
                  </li>
                  <li>
                     <a href="javascript:window.scrollTo(0,900);">스틸컷</a>
                  </li>
                  <li>
                     <a href="javascript:window.scrollTo(0,1900);">평점/리뷰</a>
                  </li>
                  <li class="last">
                     <a href="/movie/movieReservation" class="a">상영시간표</a>
                  </li>
               </ul>
               
               <div class="sect-story-movie" >
                  <span class="strong">${vo.contents}</span>
               </div>
               
               <div id="showchart">
               <div id="ctl00_PlaceHolderContent_Section_Chart" class="sect-graph sect-graph-emotion" style="margin-top: 40px;">
                  <ul class="graph">
                     <li>
                        <span class="strong rect-title">성별 예매 분포</span>
                        <div id="qplot_sex" class="chart jqplot-target" style="position: relative">
                         <div id="chart_div" style="position: absolute; left: -20px;">
                            
                         </div>
                        </div>
                     </li>
                     <li>
                        <span class="strong rect-title">연령별 예매 분포</span>
                        <div id="qplot_sex" class="chart jqplot-target" style="position: relative">
                        <div id="columnchart_values" style="width: 900px; height: 300px; position: absolute; left: -71px;" >
                        
                        </div>
                        </div>
                     </li>
                  </ul>
               </div>
               </div>
               
               
            
               
               <div id="ctl00_PlaceHolderContent_Section_Trailer" class="sect-trailer" >
                  <div class="heading">
                     <span class="hh">&ensp; 트레일러</span>
                     <span id="ctl00_PlaceHolderContent_TrailerTotalCount" class="count">${tco}건</span>
                  </div>
                  
                  <c:forEach var="ar" items="${ar}">
                  <c:if test="${ar.type eq 2 }">
                  <ul>
                     <li>
                     <div class="box-image">

                        <a href="${ar.movieVideoVOs[0].videolink }">
                           <img alt="메인예고편" src="../images/movie/movieList/filmCover/${ar.fileName}" class="box-image">
                        </a>
                     </div>
                     <div class="box-contents">
                        <a href="" class="a">
                           <span class="strong title">
                              <span class="ico-trailer hd">HD</span>
                          		    예고편 영상
                           </strong>

                        </a>
                        
                     </div>
                     </li>
                  </ul>
                  </c:if>
                  </c:forEach>
                  
               </div>
               <!-- 여기까지가 트레일러 -->
               
               <div id="ctl00_PlaceHolderContent_Section_Still_Cut" class="sect-stillcut">
                  <div class="heading">
                     <span class="hh">&ensp; 스틸컷</span>
                     <span class="count">
                        <span class="strong" id="stillcut_current"></span>
                       ${sco}건
                     </span>
                  </div>
                  
                  <div class="slider-wrap">
                  	<div id="myCarousel" class="carousel slide" data-ride="carousel" style="height: 350px;">
					    <!-- Indicators -->
					     <c:forEach var="ar" items="${ar}" varStatus="i">
					      <c:if test="${ar.type eq 3 }">
							    <ol class="carousel-indicators">
							      <li data-target="#myCarousel" data-slide-to="${i.index}" ></li>
							    </ol>
							</c:if>
					 	 </c:forEach>
					    <!-- Wrapper for slides -->
					    <div class="carousel-inner">
					      <c:forEach var="ar" items="${ar}" varStatus="i">
					      
						      <c:if test="${ar.type eq 3 }">
							      <div class="item" style="width: 100%; height: 100%;">
							       	<img alt="스틸컷" src="../images/movie/movieList/filmCover/${ar.fileName}" class="box-image"
							       	style="width: 100%; height: 100%;">
							      </div>
							       
						       </c:if>
					       </c:forEach>
					    </div>
							
					 	
					    <!-- Left and right controls -->
					    <a class="left carousel-control" href="#myCarousel" data-slide="prev">
					      <span class="glyphicon glyphicon-chevron-left"></span>
					      <span class="sr-only">Previous</span>
					    </a>
					    <a class="right carousel-control" href="#myCarousel" data-slide="next">
					      <span class="glyphicon glyphicon-chevron-right"></span>
					      <span class="sr-only">Next</span>
					    </a>
					 
					  </div>
					   
                  </div>
                  
                  
               </div>
               <!-- 여기까지가 스틸컷 -->
               <div class="sect-grade" style="margin-top: 40px;">
                  <div class="movie_grade">
                     <div class="egg_point">
                        <div class="title">
                           배우들의 연기가 메소드급인<br>
                           몰입하여 보게 되는 영화
                        </div>
                        <div class="rating" id="rating" style="position: relative;">
                           <div class="box" style="position: absolute; right: 150px;">
                           
                           <!-- pre egg -->
                           <!-- <div class="sprite_preegg big default" style="background: url('../images/movie/movieList/sprite_preegg.png')no-repeat -25px -20px;" ></div> -->
                              
                              <!--  <span class="sprite_preegg big default" style="background: url('../images/movie/movieList/sprite_preegg.png') no-repeat -4px -35px;"></span> 
                              
                              <span class="desc" >PreEgg</span>
                              <span class="percent">94%</span>
                              <span class="tooltip">사전기대지수</span> -->
                              
                           </div>
                           <div class="box box_golden" style="position: absolute; right: 40px;">
                              <span class="sprite_preegg big great" style="background: url('../images/movie/movieList/sprite_preegg.png') no-repeat -115px -135px;"></span>
                              <span class="desc">GoldenEgg</span>
                              <span class="percent">${vo.errRate}%</span>
                              <span class="tooltip">실관람평지수</span>
                           </div>
                        </div>
                     </div>
                     
                     <div class="chart_total">
                        <div class="box">
                           <div class="title">매력 포인트</div>
                           <div class="radar-graph" id="chart2">
                              <div id="myChartTest">
                                 <canvas id="myChart" width="100" height="100">
                                 
                                 </canvas>
                              </div>
                           </div>
                        </div>
                        <div class="box">
                           <div class="title">감정 포인트</div>
                           <div class="radar-graph" id="chart3">
                              <div id="myChartTest">
                                 <canvas id="myChart2" width="100" height="100">
                                 
                                 </canvas>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="real-rating">
                     <p class="title">관람일 포함 7일 이내 관람평을 남기시면 <span class="strong red">CJ ONE 20P</span>가 적립됩니다.</p>
                     <p class="desc"><span><em id="reviewer"></em>명의 실관람객이 평가해주셨습니다.</span></p>
                     <div class="wrap_btn">
                        <a class="link-gradewrite a" href="javascript:void(0);" onclick="review_Modal();"><span>평점작성</span></a>
                        <a class="link-reviewwrite a" href="../review/reviewLook"><span>내 평점</span></a>
                     </div>
                  </div>
                  
                  <ul class="sort" id="sortTab">
                     <!-- 최신순 -->
                     <li class="sortTab on" data-order-type="0" id="test">
                        <a href="javascript:void(0);" title="현재선택" class="a newBtn" onclick="newBtn();">
                           최신순
                           <span class="arrow-down"></span>
                        </a>   
                     </li>
                     <!-- 추천순 -->
                     <li class="sortTab" data-order-type="3" >
                        <a href="javascript:void(0);" class="a recBtn" onclick="recBtn();">
                           추천순
                           <span class="arrow-down"></span>
                        </a>
                     </li>
                     
                  </ul>
                  

                  <!-- 리뷰 시작 / ajax_movieSelect.jsp 참고-->
                  <div id="ajax_ms">
                  
                  

                        <%-- <div class="bbs_btn">
                           <button type="button" class="round inblack" id="btn-list"><span>목록으로</span></button>
                           
                           <c:if test="${bbsVO.writer eq memberVO.id }">
                              <a href="./${board}Delete?num=${vo.num}"><button type="button" class="round inred" id="btn-delete"><span>삭제하기</span></button></a>
                              <a href="./${board}Update?num=${vo.num}"><button type="button" class="round inred" id="btn-update"><span>수정하기</span></button></a>
                           </c:if>
                           
                        </div> --%>
                     
                  

               </div>
            </div>
         
         </div>
      </div>
   </div>
   </div>
      
   <!-- Modal (이건 부트스트랩이 적용되어있어서 디자인이 깨져 새로 만들었음) / 글자 세기(작성:0으로초기화 / 수정:글자수적용)-------------------------------------->
   <c:import url="../template/modal3.jsp"></c:import>   
   <c:import url="../template/modal4.jsp"></c:import>
   
   <!-- 푸터 -------------------------------------------------------------------------------------->
   <c:import url="../template/footer.jsp"></c:import>
   
   <!-- 사이드바 ---------------------------------------------------------------------------------------------->
   <c:import url="../template/sidebar.jsp"></c:import>
</div>


<!-- 스크립트 모음 ---------------------------------------------------------------------------------------------->
<script type="text/javascript" src="../js/bbsWrite.js"></script>
<!-- 글자 byte 체크 -->
<script type="text/javascript" src="../js/review/checkByte.js"></script>
<script type="text/javascript" src="../js/review/checkByte2.js"></script>
<script type="text/javascript" src="../js/review/movieSelect_review.js"></script>


<!-- 성별 그래프 1번 -->
<!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

    var total =${gTotal};
    console.log(total+"total");
   var w=${gender}/${gTotal};
   console.log(w+"w");
   var M = 1-w;

   $(function() {

   if(!(total>0)) {
   
      $("#ctl00_PlaceHolderContent_Section_Chart").prop("style", "display:none;");
   }
      
   });
   
      // Load the Visualization API and the corechart package.
      google.charts.load('current', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.charts.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Topping');
        data.addColumn('number', 'Slices');
        data.addRows([
          ['여성', w],
          ['남성', M],
         
        ]);


        // Set chart options
        var options = {'title':'',
                       'width':385,
                       'height':320,
                       backgroundColor : '#fdfcf0'};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
      </script>
<!-- 연령별 그래프 2번 -->


  <script type="text/javascript">
   var ageTotal=${ageTotal};
   console.log(ageTotal+"agetotal");
   
   var age10 =${age10}/${ageTotal};
   console.log(age10+"age10");
   var age20 =${age20}/${ageTotal};
   console.log(age20+"age20");
   var age30 =${age30}/${ageTotal};
   console.log(age30+"age30");
   var age40 =${age40}/${ageTotal};
   console.log(age40+"age40");
   var age50 =${age50}/${ageTotal};
   console.log(age50+"age50");
  
    google.charts.load("current", {packages:['corechart']});
    google.charts.setOnLoadCallback(drawChart);
    
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ["Element", "Density", { role: "style" } ],
        ["10대", ${age10}, "#b87333"],
        ["20대", ${age20}, "silver"],
        ["30대", ${age30}, "gold"],
        ["40대", ${age40}, "color: #e5e4e2"],
        ["50대", ${age50}, "color: #e5e4e2"],
        
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",   
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation",
                        },
                       2]);

      var options = {
        title: "",
        width: 530,
        height: 330,
        backgroundColor : '#fdfcf0',
        bar: {groupWidth: "75%"},
        legend: { position: "none" ,
        },
        
        hAxis : {
            gridlines: {
                 color: 'transparent'
             },
             
        },
        vAxis: {
            gridlines: {
                color: 'transparent'
            },
            textPosition:'none',
        },
         
        
        
      };
      var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
      chart.draw(view, options);
  }
  </script>
<!-- 방사형 chart  -->
<script type="text/javascript">

console.log(${cdirector}+"direc");
console.log(${cstory}+"story");
var ctx = document.getElementById('myChart');
var myChart = new Chart(ctx, {
   type: 'radar',
    data: {
        labels: ['감독연출', '스토리', '영상미', '배우연기', 'OST'],
        datasets: [{
            label: 'Charm',
            data: [${cdirector}, ${cstory}, ${cvisual}, ${cactor}, ${cost}],
             backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                
            ], 
             borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
               
            ], 
            borderWidth: 1
        }]
    },
    options: {      
        
        scales: { 
                               
            xAxes:[{
               gridLines:{
                display:false,
            },
               ticks:{
               display:false
                },
            }],
            
            yAxes: [{
            gridLines:{
                display:false,
            },
                ticks: {
                    beginAtZero: true,
                    display:false
                }
            }]
        }
    }
});
</script>
<script>

var ctx = document.getElementById('myChart2');
var myChart = new Chart(ctx, {
   type: 'radar',
    data: {
        labels: ['스트레스해소', '즐거움', '긴장감', '몰입감', '감동'],
        datasets: [{
            label: 'Emotion',
            data: [${cstr}, ${cfun},${cten},${cimm}, ${cimp}],
            scaleShowLabels : false,
            omitXLabels: true,
             backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                
            ], 
             borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
               
            ], 
            borderWidth: 1,
            
            
        }]
    },
    options: {      
        
        scales: { 
                               
            xAxes:[{
               gridLines:{
                display:false,
            },
            
               ticks:{
               display:false
               
                },
               
            }],
            
            yAxes: [{
            gridLines:{
                display:false,
            },
                
                ticks: {
                    beginAtZero: true,
                    display:false
                  
                    
                }
            }]
        }
    }
});

</script>


<script type="text/javascript">
	$(".item:nth-child(1)").addClass("active");

</script>





</body>
</html>