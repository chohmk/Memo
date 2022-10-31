<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex justify-content-center">
	<div class="w-50">
		<h1>글 상세/수정</h1>
		
		<input type="text" id="subject" class="form-control" placeholder="제목을 입력해주세요" value="${post.subject}">
		<textarea class="form-control" id="content" rows="15" cols="100" placeholder="내용을 입력해주세요">${post.content}</textarea>
		
		<%-- 이미지가 있을 때만 이미지 영역 추가 --%>
		<c:if test="${not empty post.imagePath}">
			<div class="mt-3">
				<img src="${post.imagePath}" alt="업로드 이미지" width="300">
			</div>
		</c:if>
		
		<div class="d-flex justify-content-end my-3">
			<input type="file" id="file" accept=".jpg,.jpeg,.png,.gif">
		</div>
		
		<div class="d-flex justify-content-between my-4">
			<button type="button" id="postDeleteBtn" class="btn btn-secondary" data-post-id="${post.id}">삭제</button>
			
			<div class="d-flex justify-content-end">
				<a href="/post/post_list_view" class="btn btn-dark">목록으로</a>
				<button type="button" id="postUpdateBtn" class="btn btn-warning" data-post-id="${post.id}">수정</button>
			</div>
		</div>
	</div>
</div>
<script>
$(document).ready(function() {
	// 수정 버튼 클릭
	$('#postUpdateBtn').on('click', function() {
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
			console.log(file.split('.').pop());    // 파일명을 . 기준으로 나눈다. => 확장자만 뽑아낸다.
			let ext = file.split('.').pop().toLowerCase(); // 확장자를 소문자로 변경
			if ($.inArray(ext, ['gif', 'jpg', 'jpeg', 'png']) == -1) {
				alert("gif, jpg, jpeg, png 파일만 업로드 할 수 있습니다.");
				$('#file').val('');  // 파일을 비운다.
				return;
			}
		}
		
		// 폼 태그를 자바스크립트에서 만든다.
		let postId = $(this).data('post-id');
		//alert(postId);
		
		let formData = new FormData();
		formData.append("postId", postId)
		formData.append("subject", subject);
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);
		
		// AJAX 통신 => 서버 전송
		$.ajax({
			// request
			type:"PUT"
			, url:"/post/update"
			, data:formData
			, enctype:"multipart/form-data"  // 파일 업로드를 위한 필수 설정
			, processData:false   // 파일 업로드를 위한 필수 설정
			, contentType:false   // 파일 업로드를 위한 필수 설정
			
			// response
			, success:function(data) {
				if (data.code == 100) { // 성공
					alert("메모가 수정되었습니다.");
					location.reload();
				} else {
					alert(data.errorMessage); // 실패
				}
			}
		});
	});
	// 삭제
	$('#postDeleteBtn').on('click', function() {
		let postId = $(this).data('post-id');
		
		// 삭제 ajax
		$.ajax({
			type:"DELETE"
			, url:"/post/delete"
			, data:{"postId":postId}
			, success: function(data) {
				if (data.code == 100) {
					alert("삭제되었습니다.");
					location.href="/post/post_list_view"	// 성공하면 글 목록으로 이동
				} else {
					alert(data.errorMessage);
				}
			}
			, error: function(e) {
				alert("메모 삭제에 실패했습니다.");
			}
		}) ;
	});	// 삭제버튼 끝
	
}); // ready 끝
</script>
