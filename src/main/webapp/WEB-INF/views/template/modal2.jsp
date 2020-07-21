<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<!-- 쓰기 전용 -->

	<!-- The Modal -->
	<div class="modal" id="myModall">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<form id="form2" name="form2" method="post"
					action="./review/review_Write">
					<div class="modal-header" style="background-color: #333;">
						<h4 class="modal-title"
							style="color: #F2F0E5; font-size: X-large;">평점작성</h4>
						<button id="exitt" type="button" class="close" data-dismiss="modal">&times;</button>
					</div>

					<!-- Modal body -->
					<div class="modal-body">
						<div id="title2"></div>   <!-- reviewSubmit.js / reviewMore / $(".popupBtn1").click 참고 -->
						<br>
						<div style="text-align: center;">
						
								<div class="group_radio" id="egg2" >	<!-- 각 class나 name에 같은값을 주면 된다. -->
									<label class="label_radio"> 
										<input type="radio" name="egg2" value=1 class="egg2" checked="checked">
										<span class="text_position">좋았어요~^^</span>
									</label>
									&ensp;&ensp;
									<label class="label_radio">
										<input type="radio" name="egg2" value=0 class="egg2">
										<span class="text_position">흠~좀 별로였어요;;;</span>
									</label>	
								</div>
						
						</div><br>
						
						<!-- 나중에 여기에 session으로 정보불러와서 같이 보내기 -->
						<textarea id="mContents2" name="contents2" rows="5" cols="70" onkeyup="CheckByte(this)"
							placeholder="운영원칙에 어긋나는 게시물로 판단되는 글은 제재 조치를 받을 수 있습니다." 
							style="font-size: small;"></textarea>	<!-- textarea에서 키보드를 누르면 CheckByte.js의 해당내용(this)의 함수실행 -->
					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<span id="bytes2" style="color: black;">0</span>/150(byte)
						&emsp;
						<input type="button" class="btn btn-danger" id="submitBtn11" value="확인">
					</div>
				</form>
			</div>
		</div>
	</div>


<!-- ----------------------------------------------------------------------------------------------------------------  -->


		<!-- The Modal2 -->
		
		<div class="modal" id="myModall2">
			<div class="modal-dialog">
				<div class="modal-content">

					<!-- Modal Header -->
					<form id="form2" name="form2" method="post"
						action="./review/review_Write">
						<div class="modal-header" style="background-color: #333;">
							<h4 class="modal-title"
								style="color: #F2F0E5; font-size: X-large;">관람 포인트 선택</h4>
							<button id="exitt2" type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<div style="width: 100%; height: 100px; text-align: center; padding-top: 20px;"><span style="font-size: large; color: #333333">이 영화의 관람포인트를 선택해 주세요!</span><br>
							<span style="color: red;">중복선택</span>이 가능합니다.</div>
							
							<!-- label과 id가 같으면 글씨만 클릭해도 체크박스를 클릭할수 있다. -->
							
							<div style="border-top: 1px solid #cccccc;"><div style="font-weight: bold; padding: 15px 0;">매력 포인트</div>
								<div style="font-weight: lighter;">
								<input type="checkbox" value="감독연출" id="a1" class="charmPoint2" data-charm="1"> <label for="a">감독연출</label> &emsp; &emsp; &emsp; &emsp;
								<input type="checkbox" value="스토리" id="b1" class="charmPoint2" data-charm="2"> <label for="b">스토리</label> &emsp; &emsp; &emsp; &emsp;
								<input type="checkbox" value="영상미" id="c1" class="charmPoint2" data-charm="4"> <label for="c">영상미</label>
								<br>
								<input type="checkbox" value="배우연기" id="d1" class="charmPoint2" data-charm="8"> <label for="d">배우연기</label> &emsp; &emsp; &emsp; &emsp;
								<input type="checkbox" value="OST" id="e1" class="charmPoint2" data-charm="16"> <label for="e">OST</label>
								<br><br>
								</div>
							</div>
							
							<div style="border-top: 1px solid #cccccc;"><div style="font-weight: bold; padding: 15px 0;">감정 포인트</div>
								<div style="font-weight: lighter;">
								<input type="checkbox" value="몰입감" id="f1" class="emotionPoint2" data-emotion="1"> <label for="f">몰입감</label> &emsp; &emsp; &emsp; &emsp; &ensp;
								<input type="checkbox" value="감동" id="g1" class="emotionPoint2" data-emotion="2"> <label for="g">감동</label> &emsp; &emsp; &emsp; &emsp; &ensp;
								<input type="checkbox" value="스트레스 해소" id="h1" class="emotionPoint2" data-emotion="4"> <label for="h">스트레스 해소</label>
								<br>
								<input type="checkbox" value="즐거움" id="i1" class="emotionPoint2" data-emotion="8"> <label for="i">즐거움</label> &emsp; &emsp; &emsp; &emsp; &ensp;
								<input type="checkbox" value="공감" id="j1" class="emotionPoint2" data-emotion="16"> <label for="j">공감</label>
								<br><br>
								</div>
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<input type="button" class="btn btn-danger" id="submitBtn22" value="확인">
						</div>
						
					</form>
				</div>
			</div>
		</div>