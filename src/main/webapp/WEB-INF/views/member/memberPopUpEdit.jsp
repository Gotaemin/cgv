<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/css/member/memberPopUpEdit.css" rel="stylesheet" type="text/css">
</head>
<body>
<body>
	<div class="popwrap">
	<div class="title">
		<h1>나의 프로필 수정</h1>
		<button id="btn_close"></button>
	</div>
	<div class="popwrap-box">
	<div class="profile">
		<strong>닉네임 & 프로필사진 수정</strong>
	</div>
	<div class="profile-modify">
		<dl>
			<dt>닉네임</dt>
			<dd>
				<p>한글, 영문, 숫자 혼용 가능(한글 기준 10자 이내)</p>
				<p class="nickname-check">
					<input type="text" id="nick-name" required="required" maxlength="10" value="${sessionScope.memberVO.nick}">
					<span class="check">중복확인</span>
				</p>
			</dd>
		</dl>
		<dl>
			<dt>프로필이미지</dt>
			<dd>
				<div class="profile-box">
					<img id="user_image" name="user_image" alt="" src="/images/member/${sessionScope.memberVO.fileName}">
					<button type="button" id="delete_image" class="btn-del">프로필이미지 삭제</button>
				</div>
				<p class="img-condition">JPG, GIF, BMP 파일만 등록 가능합니다.(최대 3M)</p>
				<!-- 위 : 다중 / 아래 : 단일     파일 전송용 -->
				<!-- <input type="file" id="profile_upload_file" name="profile_upload_file" title="프로필사진 업로드" accept="image/*" multiple/> -->
				<input type="file" id="profile_upload_file" name="profile_upload_file" title="프로필사진 업로드" accept="image/*"/>
				<input type="hidden" id="_csrf" value="${_csrf.token}" />
			</dd>
		</dl>
	</div>
	<div class="set-btn">
		<button class="upload">등록하기</button>
		<button class="cancle">취소</button>
	</div>
</div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

	//닉네임 중복확인
	$(".check").click(function() {
    	var nick = $("#nick-name").val();
        console.log(nick);

		if(nick=="") {
			alert("변경할 닉네임을 입력해주세요");
			return;
		}
        $.ajax({
            url:'./memberNickCheck',
            type:'get',
            data:{ nick:nick },
            success: function(result) {
              	if (result == 0){
					alert('사용가능한 닉네임입니다!');
       	        } else{
					alert('이미 사용중인 닉네임입니다!');
					$("#nick-name").val("");
					$("#nick-name").focus();
				}
            },
            error: function() {
				console.log("연결 실패");
			}
        });
	});
		
	//프로필 이미지 삭제 - 기본이미지로 변경
	$(".btn-del").click(function() {
		$("#user_image").attr('src','/images/member/defaultProfile.png');
	});

	//취소 - 창닫기
	$(".cancle").click(function() {
		window.close();
	});
	$("#btn_closele").click(function() {
		window.close();
	});

	// 파일 확장자 및 크기 체크
	function checkFile(fileName, fileSize) {

		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 3145728; 		// 3MB

		if(fileSize >= maxSize) {
			alert(file.name+" 파일 사이즈 초과");
			return false;
		}
	
		if(regex.test(fileName)) {
			alert(file.name+" 해당 종류의 파일은 업로드 할 수 없습니다");
			return false;
		}
		return true;
	}
	
	// update 요청
	$(".upload").on("click", function(e) {

		var formData = new FormData();
		var inputFile = $("input[name='profile_upload_file']");
		var files = inputFile[0].files;

		console.log(files);

		for(var i=0; i<files.length; i++) {

			if(!checkFile(files[i].name, files[i].size)) {
				return false;
			}

			formData.append("files", files[i]);
		}

		formData.append("nick", $("#nick-name").val());
		formData.append("_csrf", $("#_csrf").val());

		$.ajax({
			url: './edit',
			processData: false,
			contentType: false,
			data: formData,
			type: 'post',
			success: function(result) {
				if(result>0) {
					alert("수정이 완료되었습니다");
					opener.editCallback(result);
					window.close();
				}
			}
		});
	});

</script>

</body>
</html>