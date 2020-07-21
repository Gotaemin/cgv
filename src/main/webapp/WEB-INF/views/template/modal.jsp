<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 쓰기 전용 -->

<!-- The Modal -->
<div class="modal" id="myModal" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">

			<!-- Modal Header -->
			<form id="form" name="form" method="post"
				action="./review/review_Write">
				<div class="modal-header">
					<h4 class="modal-title">평점작성</h4>
					<button id="exit" type="button" class="close" data-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-contents">
					<div class="modal-body">
						<div id="title" class="modal-contents-title"></div>
						<!-- reviewSubmit.js / reviewMore / $(".popupBtn1").click 참고 -->
						<div>
							<div class="group_radio" id="egg">
								<!-- 각 class나 name에 같은값을 주면 된다. -->
								<label class="label_radio goodegg"> <input type="radio"
									name="egg" value=1 class="egg" checked="checked"> <span
									class="text_position">좋았어요~^^</span>
								</label>
								<!-- <div>
									<img alt="사용자의 프로필 사진" src="" class="profile-pic"> <span>사용자 이름</span>
								</div> -->
								<label class="label_radio nogoodegg"> <input type="radio"
									name="egg" value=0 class="egg"> <span
									class="text_position">흠~좀 별로였어요;;;</span>
								</label>
							</div>
						</div>

						<!-- 나중에 여기에 session으로 정보불러와서 같이 보내기 -->
						<textarea id="mContents" name="contents" rows="5" cols="70"
							onkeyup="CheckByte(this)"
							placeholder="운영원칙에 어긋나는 게시물로 판단되는 글은 제재 조치를 받을 수 있습니다."
							style="font-size: small;"></textarea>
						<!-- textarea에서 키보드를 누르면 CheckByte.js의 해당내용(this)의 함수실행 -->

					</div>

					<!-- Modal footer -->
					<div class="modal-footer">
						<span id="bytes">0</span>/280(byte) &emsp; <input type="button"
							class="btn btn-danger" id="submitBtn1" value="작성완료!">
					</div>
				</div>
			</form>
		</div>
	</div>
</div>


<!-- ----------------------------------------------------------------------------------------------------------------  -->


<!-- The Modal2 -->

<div class="modal" id="myModal2" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content2">

			<!-- Modal Header -->
			<form id="form" name="form" method="post"
				action="./review/review_Write">
				<div class="modal-header" style="background-color: #333;">
					<h4 class="modal-title" style="color: #F2F0E5; font-size: X-large;">관람
						포인트 선택</h4>
					<button id="exit2" type="button" class="close" data-dismiss="modal"></button>
				</div>

				<!-- Modal body -->
				<div class="modal-contents2">
					<div class="modal-body">
						<div style="width: 100%; height: 70px; text-align: center; padding-top: 10px;">
							<span style="font-size: 22px; color: #333333">이 영화의 관람포인트를 선택해 주세요!</span><br> 
							<span style="font-size: 16px;"><span style="color: red;">중복선택</span>이 가능합니다.</span>
						</div>

						<!-- label과 id가 같으면 글씨만 클릭해도 체크박스를 클릭할수 있다. -->

						<div class="mc2-box">
							<div class="mc2-title">매력 포인트</div>
							<div style="font-weight: lighter;">
								<label for="a" class="modal-label">
									<input type="checkbox" value="감독연출" id="a" class="charmPoint" data-charm="1"> 
									감독연출
								</label>
								<label for="b" class="modal-label">
									<input type="checkbox" value="스토리" id="b" class="charmPoint" data-charm="2"> 
									스토리
								</label>
								<label for="c" class="modal-label">
									<input type="checkbox" value="영상미" id="c" class="charmPoint" data-charm="4"> 
									영상미
								</label>
								<label for="d" class="modal-label">
									<input type="checkbox" value="배우연기" id="d" class="charmPoint" data-charm="8">
									배우연기
								</label> 
								<label for="e" class="modal-label">
									<input type="checkbox" value="OST" id="e" class="charmPoint" data-charm="16">
									OST
								</label>
							</div>
						</div>

						<div class="mc2-box">
							<div class="mc2-title">감정 포인트</div>
							<div style="font-weight: lighter;">
								<label for="f" class="modal-label">
									<input type="checkbox" value="몰입감" id="f" class="emotionPoint" data-emotion="1">
									몰입감
									</label> 
								<label for="g" class="modal-label">
									<input type="checkbox" value="감동" id="g" class="emotionPoint" data-emotion="2">
									감동
									</label>
								<label for="h" class="modal-label">
									<input type="checkbox" value="스트레스 해소" id="h" class="emotionPoint" data-emotion="4">
									스트레스 해소 
								</label>
								<label for="i" class="modal-label">
									<input type="checkbox" value="즐거움" id="i" class="emotionPoint" data-emotion="8">
									즐거움
								</label>
								<label for="j" class="modal-label">
									<input type="checkbox" value="공감" id="j" class="emotionPoint" data-emotion="16">
									공감
								</label>
							</div>
						</div>
					</div>

					<!-- Modal footer -->
					<div class="modal-footer" style="justify-content: center;">
						<input type="button" class="btn btn-danger" id="submitBtn2" value="확인">
					</div>
				</div>
			</form>
		</div>
	</div>
</div>