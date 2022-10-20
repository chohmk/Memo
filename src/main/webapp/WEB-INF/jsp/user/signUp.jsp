<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="sign-up-box">
		<h1 class="mb-4">회원가입</h1>
		<form id="signUpForm" method="post" action="/user/sign_up">
			<table class="sign-up-table table table-bordered">
				<tr>
					<th>* 아이디(4자 이상)<br></th>
					<td>
						<%-- 인풋박스 옆에 중복확인을 붙이기 위해 div를 하나 더 만들고 d-flex --%>
						<div class="d-flex">
							<input type="text" id="loginId" name="loginId" class="form-control" placeholder="아이디를 입력하세요.">
							<button type="button" id="loginIdCheckBtn" class="btn btn-success">중복확인</button><br>
						</div>
						
						<%-- 아이디 체크 결과 --%>
						<%-- d-none 클래스: display none (보이지 않게) --%>
						<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
						<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
						<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
					</td>
				</tr>
				<tr>
					<th>* 비밀번호</th>
					<td><input type="password" id="password" name="password" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th>* 비밀번호 확인</th>
					<td><input type="password" id="confirmPassword" class="form-control" placeholder="비밀번호를 입력하세요."></td>
				</tr>
				<tr>
					<th>* 이름</th>
					<td><input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요."></td>
				</tr>
				<tr>
					<th>* 이메일</th>
					<td><input type="text" id="email" name="email" class="form-control" placeholder="이메일 주소를 입력하세요."></td>
				</tr>
			</table>
			<br>
		
			<button type="submit" id="signUpBtn" class="btn btn-primary float-right">회원가입</button>
		</form>
	</div>
</div>


<script>
	$(document).ready(function() {
		// 중복확인
		$('#loginIdCheckBtn').on('click', function() {
			let loginId = $('#loginId').val().trim();
			
			if (loginId.length < 4) {
				// 4자 이하일 때 경고문구 노출하고 끝.
				$('#idCheckLength').removeClass('d-none');	// 경고문구 노출
				$('#idCheckDuplicated').addClass('d-none');	// 숨김
				$('#idCheckOk').addClass('d-none');	// 숨김
				
				return;
			}
			
			// ajax 중복 확인
			$.ajax({
				url:"/user/is_duplicated_id"
				, data:{"loginId":loginId}
				, success:function(data) {
					if (data.result) {
						// 중복일 때
						$('#idCheckDuplicated').removeClass('d-none');	// 경고문구 노출
						$('#idCheckLength').addClass('d-none');	// 숨김
						$('#idCheckOk').addClass('d-none');	// 숨김
						
					} else {
						// 중복 아닐 때
						$('#idCheckOk').removeClass('d-none');	// 사용가능 문구 노출
						$('#idCheckDuplicated').addClass('d-none');	// 숨김
						$('#idCheckLength').addClass('d-none');	// 숨김
					}
				}
				, error: function(e) {
					alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		// 회원가입
		$('#signUpForm').on('submit', function(e) {
			e.preventDefault(); 	// submit 기능 중단.
			// alert("회원가입");
			// validation
			let loginId = $('#loginId').val().trim();
			let password = $('#password').val().trim();
			let confirmPassword = $('#confirmPassword').val().trim();
			let name = $('#name').val().trim();
			let email = $('#email').val().trim();
			
			if (loginId == "") {
				alert("아이디를 입력하세요");
				return false;
			}
			
			if (password == "" || confirmPassword == "") {
				alert("비밀번호를 입력하세요");
				return false;
			}
			
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			
			if (name == "") {
				alert("이름을 입력하세요");
				return false;
			}
			
			if (email == "") {
				alert("이메일을 입력하세요");
				return false;
			}
			// 아이디 중복확인이 완료되었는지 확인. -> idCheckOk d-none이 없으면 사용 가능으로 본다.
			if ($('#idCheckOk').hasClass('d-none') == true) {
				alert("아이디 중복확인을 다시 해주세요");
				return false;
			}
			
			// 1) submit
			// $(this)[0].submit();	// 서브밋 이후에 다른 화면으로 넘길 때 사용 (action 주소 -> 뷰화면)
			
			// 2) ajax
			let url = $(this).attr('action');
			let params = $(this).serialize();	// name 속성 값들을 파라미터로 구성, form태그랑 같이 써야함.
			// console.log(params);
			$.post(url, params)
			.done(function(data) {
				if (data.code == 100) {
					alert("가입을 환영합니다!!! 로그인 해주세요.");
					location.href="/user/sign_in_view";
				} else {
					alert("가입에 실패했습니다.");
				}
			});
			
		});
	});

</script>





