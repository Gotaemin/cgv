/**
 * 
 */
		console.log("asdasdasdasdas");

		var frm = document.getElementById("frm");

		var userID = document.getElementById("userID");
		var idc = document.getElementById("idc");
		
		var pwd1 = document.getElementById("userPWD");
		var pwd1c = document.getElementById("pwd1c");
		
		var pwd2 = document.getElementById("userPWD2");
		var pwd2c = document.getElementById("pwd2c");
		
		var ch_year = document.getElementById("ch_year");
		var ch_month = document.getElementById("ch_month");
		var ch_date = document.getElementById("ch_date");
		var birthc = document.getElementById("birthc");
		
		var check = document.getElementsByClassName("check");
		var btn = document.getElementById("btn");
		
		var idcheck = false;
		var pwdcheck = false;

		//아이디 기입 조건 설명 출력
		userID.addEventListener("focus",function(){
			if (userID.value.length < 6) {
				idc.innerText = '아이디는 6글자 이상입니다.';
			}
		});
		
		//아이디 조건 체크
		userID.addEventListener("keyup",function(){
//			if(userID.value.length < 6){
//				idc.innerText = '아이디는 6글자 이상입니다.';
//				idc.style.color = "red";
//				idcheck = false;
//			}else{
//				
//					idc.innerText = '사용가능한 아이디입니다. 아이디 중복체크를 해주세요';
//					idc.style.color = "green";
//					idcheck = true;
//			}
			
		});
		
		//패스워드 조건 설명 출력
		pwd1.addEventListener("focus",function(){
			//pwd1c.innerText = '패스워드는는 6글자 이상입니다.';
		});
		
		//패스워드 조건 체크
		pwd1.addEventListener("blur",function(){
			if(pwd1.value.length != 0){
				
				if(pwd1.value.length >= 6 ){
					pwd1c.innerText = '사용 가능한 패스워드 입니다.';
					pwd1c.style.color = "green";
				}else{
					pwd1c.innerText = '사용 불가능한 패스워드 입니다.';
					pwd1c.style.color = "red";
				}
			}
		});

		pwd1.addEventListener("change",function(){
			pwd2.value = "";
			pwd2c.innerText="";
			pwdcheck = false;
		});
		
		//1차 패스워드 2차 패스워드 대조
		pwd2.addEventListener("blur",function(){
			if(pwd2.value.length != 0){
				if(pwd1.value == pwd2.value){
					pwd2c.innerText = '패스워드가 일치합니다.';
					pwd2c.style.color = "green";
					pwdcheck = true;
				}else{
					
					pwd2c.innerText = '패스워드가 불일치합니다.';
					pwd2c.style.color = "red";
					pwd2.value="";
					pwdcheck = false;
				}
			}
			
			
		});
		
//		폼 태그의 빈칸 여부 체크
		btn.addEventListener("click",function(e){
			var flag = false;
			var blankArr = [];
			
			for(i=0;i<check.length;i++){
				if(check[i].value.length == 0){
					flag = true;
					blankArr.push(check[i]);
				}
			}

			if(blankArr.length != 0){
				var blank_go = document.getElementById(blankArr[0].id);
			}
			
			// 성별 입력은 했는지
			var genderFlag = false;
			$(".gender").each(function() {
				genderFlag |= $(this).prop("checked");
			});
		
			console.log(genderFlag);
			if(!genderFlag) {
				flag = true;
			}
			
			if(flag){
				e.preventDefault();
				console.log(flag);
				alert("미기입한 항목이 존재합니다.")
				blank_go.focus();
				return;
			}
			
			// id 인증이 됐는지
			if(!idCheck) {
				e.preventDefault();
				alert("아이디 인증을 해주세요");
				return;
			}
			
			// 핸드폰 인증이 됐는지
			if(!readonlyCheck) {
				e.preventDefault();
				alert("핸드폰 인증을 해주세요");
				return;
			}
			
			
			
			alert("회원가입 성공");
		});

		
//		월 옵션 생성
		var month_arr = '<option class="opt" selected="selected">월</option>';
		for(i=1;i<=12;i++){
			month_arr += '<option class="opt" value='+ i +'>'+i+'</option>';
		}
		ch_month.innerHTML = month_arr;
		var opt = document.getElementsByClassName("opt");
	
		var year_flag = false;
		var month_flag = false;
		var date_flag = false;
		
		birthc.style.color = "red";
		
		for(i=0;i<opt.length;i++){
			if(opt[i].selected){
				if(opt[i].innerText == "월"){
					month_flag = false;
				}else{
					month_flag = true;
				}
				break;
			}
		}
		
		
		
		ch_year.addEventListener("blur",function(){
			var num = ch_year.value*1;
			
			if(ch_year.value.length < 4){
				birthc.innerText = "year :태어난 년도 4자리를 정확히 입력하세요."
			}else{
				console.log(num);
				if(isNaN(num)){
					birthc.innerText = 'year :정확한 년도를 입력해주세요.';
				}else{
					year_flag = true;
					if(!month_flag){
						birthc.innerText = "year :태어난 월을 선택하세요."
					}else{
						if(!date_flag){
							//birthc.innerText = "year :태어난 일(날짜) 2자리를 정확하게 입력하세요."
						}else{
							birthc.innerText = "";
						}
					}
				}
			}
		});
		
		ch_month.addEventListener("click",function(){
			if(year_flag){
				for(i=0;i<opt.length;i++){
					if(opt[i].selected){
						if(opt[i].innerText == "월"){
							month_flag = false;
						}else{
							month_flag = true;
						}
					}
				}
			}
		});
		
		ch_date.addEventListener("blur",function(){
			
			console.log(year_flag);
			console.log(month_flag);
			
			if(ch_date.value.length != 2){
				console.log("pont1");
				if(year_flag){
					console.log("pont2");
					if(month_flag){
						console.log("pont3");
						
					}else{
						birthc.innerText = "date : 태어난 월을 선택하세요."
					}
				}else{
					birthc.innerText = "date : 태어난 년도 4자리를 정확히 입력하세요.";
				}
			}else{
				console.log("elseselsef");
				date_flag = true;
				birthc.innerText = "";
			}
		});
		
		// ID 중복 체크
		$("#idCheck").click(function() {

			var id = $("#userID").val();

			$.get("./memberIdCheck",{
					username:id
				},function(result){
				if(result == 1){
					alert("이미 존재하는 아이디 입니다.");
					$("#userID").val("");
				}else{
					alert("사용가능한 아이디 입니다.");
				}
			});
		});
		
		// 전화번호 및 입력번호 입력시 유효성(숫자만 들어가도록) 검사
		var readonlyCheck = false;
		function keyinCheck(id) {

			if(readonlyCheck) {
				return;
			}
			
			// keyUp/Down 기준, (keyPress는 아예 한글 인식 X)
			// event.keyCode = 229가 한글
			if(event.keyCode == 229 || (64<event.keyCode && event.keyCode<91)) {
				alert("숫자만 입력해주세요");
			} 
			
			// 값가져오기
			var value = $("#"+id).val();
			value = value.replace(/[^0-9]/g,'');
			$("#"+id).val(value);
		}

		// 전화번호 인증 준비
		var phone = "";
		$("#phoneBtn").click(function() {

			// 번호 입력이 안되었을 때, focus 시키고 return
			phone = $("#phone").val();
			if(phone == "")
				return;

			// 전화번호 패턴이 아니라면 (010으로 시작하지 않는다던지) alert띄우고 return
			// /(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/g; // 일반 / 휴대 전화번호 정규식
			var regPattern = /^(?:(010-?\d{4})|(01[1|6|7|8|9]-?\d{3,4}))-?\d{4}$/
			console.log(regPattern);
			if(!regPattern.test(phone)) {
				alert("잘못된 전화번호 형식입니다");
				return;
			}
			
			// ajax로 서버에 전화번호 전송 (select 해서 이미 인증된 핸드폰 번호가 있다면, 해당 id ****로 보여주자)
			$.get(
				"/member/phoneAuth",{ 
					phone: phone
				}, function(data) { 

					console.log("data : "+data);
					// data = 입력한 전화번호, 또는 ""
					if(data != "none") {

						alert("이미 등록된 전화번호입니다");
						location.href = "/member/showId?phone="+phone;
					} else {

						// 인증입력칸 및 인증확인 버튼 생성
						alert("인증번호를 발송했습니다");
						$("#phoneAuth").attr("style","display: inline-block;");
						$("#phoneAuthBtn").attr("style","display: inline-block; color:#ffffff; height:38px; width: 85px; margin-top: 0px;margin-right: 200px;");
						$(".box_login").attr("style","height: 870px;");
					}
				});
		});

		// 전화번호 인증
		$("#phoneAuthBtn").click(function() {

			// 인증번호를 안적었거나 6자리가 아니라면, alert 이후 내용 지우고 포커스
			var authCode = $("#phoneAuth").val();

			console.log("member/phoneConfirm");
			if(authCode.length < 6) {

				alert("인증번호를 다시 입력해주세요");
				$("#phoneAuth").val("");
				$("#phoneAuth").focus();
				return;
			}

			//phone = "01071679549";	// test code
			// ajax로 인증으로 번호 보내기 /member/phoneConfirm
			$.get(
				"/member/phoneConfirm",{ 	
					phone: phone,
					authCode: authCode 
				}, function(data) { 
					console.log("data : "+data);
					// data = true : success / false : fail
					if(data) {

						// 인증입력칸 및 인증확인 버튼 지우기
						alert("휴대폰 인증이 완료되었습니다");
						$("#phoneAuth").attr("style","display: none;");
						$("#phoneAuthBtn").attr("style","display: none;");

						// 전화번호칸 readonly 및 인증번호 버튼 비활성화
						readonlyCheck = true;
						$("#phone").attr("readonly", true);
						$("#phoneBtn").attr("disabled", true);	// 버튼 호버라도 지워야하나
						
					} else {

						// 사실 오면 안되므로, 데이터를 위로 올려서 버그리포팅을 하던 대책 필요
						alert("인증에 실패하였습니다");
					}
				});
		});

		
		
		