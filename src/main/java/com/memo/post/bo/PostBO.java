package com.memo.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.memo.common.FileManagerService;
import com.memo.post.dao.PostDAO;
import com.memo.post.model.Post;

@Service
public class PostBO {
	@Autowired
	private PostDAO postDAO;
	
	@Autowired 
	private FileManagerService fileManagerService;
	
	public int addPost(int userId, String userLoginId, 
			String subject, String content, MultipartFile file) {
		
		String imagePath = null;
		if (file != null) {
			// 파일이 있을 때만 업로드 처리 => 서버에 업로드
			imagePath = "fileManagerService.saveFile(userLoginId, file)";
			
		}
		
		// DB insert => DAO
		return postDAO.insertPost(userId, subject, content, imagePath);
		
	}
	
	// select
	public List<Post> getPostListByUserId(int userId) {
		
		return postDAO.selectPostListByUserId(userId);
	}
	
	public Post getPostByPostIdAndUserId(int postId, int userId) {
		return postDAO.selectPostByPostIdAndUserId(postId, userId);
	}
}
