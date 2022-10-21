<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<div class="login-box">
		<h1 class="mb-4">로그인</h1>

		<%-- 키보드 Enter키로 로그인이 될 수 있도록 form 태그를 만들어준다.(submit 타입의 버튼이 동작됨) --%>
		<form id="loginForm" action="/user/sign_in" method="post">
			<div class="input-group mb-3">
				<%-- input-group-prepend: input box 앞에 ID 부분을 회색으로 붙인다. --%>
				<div class="input-group-prepend">
					<span class="input-group-text">ID</span>
				</div>
				<input type="text" class="form-control" id="loginId" name="loginId">
			</div>

			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">PW</span>
				</div>
				<input type="password" class="form-control" id="password" name="password">
			</div>

			<%-- btn-block: 로그인 박스 영역에 버튼을 가득 채운다. --%>
			<input type="submit" class="btn btn-block btn-primary" value="로그인">
			<a class="btn btn-block btn-dark" href="/user/sign_up_view">회원가입</a>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		$('#loginForm').on('submit', function(e) {
			e.preventDefault();	// submit 중단


			let loginId = $('input[name=loginId]').val().trim();
			let password = $('input[name=password]').val().trim();
			if (loginId == "") {
				alert("아이디를 입력해주세요.");
				return false;
			}
			
			if (password == "") {
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			
			// ajax
			let url = $(this).attr('action');
			let params = $(this).serialize();	// loginId=aaa&password=aaa
			
			$.post(url, params)
			.done(function(data) {
				if (data.code == 100) {	// 성공
					location.href = "/post/post_list_view";	// 글 목록 화면으로 이동.
				} else {
					alert(data.errorMessage);	
				}
			});
		});
	});
</script>








