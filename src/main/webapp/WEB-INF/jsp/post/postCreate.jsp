<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글쓰기</h1>

		<input type="text" id="subject" class="form-control" placeholder="제목을 입력해주세요">
		<textarea class="form-control" id="content" rows="15" cols="100" placeholder="내용을 입력해주세요"></textarea>
		<div class="d-flex justify-content-end my-3">
			<input type="file" id="file" accept=".jpg,.jpeg,.png,.gif">
		</div>

		<div class="d-flex justify-content-between my-4">
			<button type="button" id="postListBtn" class="btn btn-dark">목록</button>

			<div class="d-flex justify-content-end">
				<button type="button" id="clearBtn" class="btn btn-secondary">모두 지우기</button>
				<button type="button" id="postCreateBtn" class="btn btn-warning">저장</button>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
	// 목록 버튼 클릭 => 글 목록 화면으로 이동
	$('#postListBtn').on('click', function() {
		location.href = "/post/post_list_view";
	});
	
	// 모두 지우기 버튼 클릭 => 제목, 글 지운다.
	$('#clearBtn').on('click', function() {
		// 제목과 textarea를 빈칸으로 만든다.
		$('#subject').val('');
		$('#content').val('');
	});
	
	// 글 저장
	$('#postCreateBtn').on('click', function() {
		let subject = $('#subject').val().trim();
		if (subject == '') {
			alert("제목을 입력하세요");
			return;
		}
		
		let content = $('#content').val();
		
		let file = $('#file').val(); // 파일의 경로 스트링   C:\fakepath\스크린샷(1).png
		//alert(file);
		// 파일이 업로드 된 경우 확장자 체크
		if (file != '') {
			console.log(file.split('.').pop());	// 파일명을 . 기준으로 나눈다. => 확장자만 뽑아온다.
			let ext = file.split('.').pop().toLowerCase();	// toLowerCase() 확장자를 모두 소문자로 변경.
			if ($.inArray(ext, ['gif','jpg', 'jpeg', 'png']) == -1) {
				alert("gif, jpg, jpeg, png 파일만 업로드 할 수 있습니다.");
				$('#file').val('');	// 파일을 비운다.
				return;
			}
		}

		// 폼태그를 자바스크립트에서 만든다.
		let formData = new FormData();
		formData.append("subject", subject);	// form태그에 name으로 넣는 것과 같다.(request param 구성)
		formData.append("content", content);	
		formData.append("file", $('#file')[0].files[0]);
		
		// ajax 통신으로 formData에 있는 데이터 전송
		$.ajax({
			type:"POST"
			, url:"/post/create"
			, data:formData
			, enctype:"multipart/form-data"	// 파일 업로드를 위한 필수 설정.
			, processData: false	// 파일 업로드를 위한 필수 설정.
			, contentType: false	// 파일 업로드를 위한 필수 설정.
			
			// response
			, success:function(data) {
				if (data.code == 100) {	// 성공
					alert("메모가 저장되었습니다.");
					location.href = "/post/post_list_view";
				} else {	// 실패
					alert(data.errorMessage);
				}
			}
			, error:function(e) {
				alert("메모 저장에 실패했습니다.");
			}
		});
	});
});
</script>







