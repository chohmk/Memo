package com.memo.post;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.memo.post.bo.PostBO;
import com.memo.post.model.Post;

@RequestMapping("/post")
@Controller
public class PostController {
	
	@Autowired
	private PostBO postBO;

	/**
	 * 글 목록 화면
	 * @param model
	 * @return
	 */
	@RequestMapping("/post_list_view")
	public String postListView(HttpSession session, Model model) {
		Integer userId = (Integer)session.getAttribute("userId"); // 로그인이 풀려있으면 null이기 때문에 Integer
		if (userId == null) {
			// 로그인이 풀려있으면 로그인 페이지로 리다이렉트
			return "redirect:/user/sign_in_view";
		}
		
		List<Post> postList = postBO.getPostListByUserId(userId);
		
		model.addAttribute("viewName", "post/postList");
		model.addAttribute("postList", postList);
		return "template/layout";
	}
	
	@RequestMapping("/post_create_view")
	public String postCreateView(HttpSession session, Model model) {
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		
		model.addAttribute("viewName", "post/postCreate");
		return "template/layout";
	}
	
	@RequestMapping("/post_detail_view")
	public String postDetailView(
			@RequestParam("postId") int postId,
			HttpSession session,
			Model model) {
		
		// 로그인이 됐는지 확인 -> 안됐으면 로그인 페이지로 이동
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/user/sign_in_view";
		}
		
		// postId에 해당하는 데이터를 가져와서 model에 담는다.
		Post post = postBO.getPostByPostIdAndUserId(postId, userId);
		model.addAttribute("post", post);
		
		// layout 화면으로 이동
		model.addAttribute("viewName", "post/postDetail");
		return "template/layout";
	}
}








