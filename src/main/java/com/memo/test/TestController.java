package com.memo.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.memo.test.dao.TestDAO;

@Controller
public class TestController {
	@Autowired
	private TestDAO testDAO;
	
	@ResponseBody
    @RequestMapping("/test1")
    public String helloWorld() {
        return "Hello world!";
    }
	
	@ResponseBody
    @RequestMapping("/test2")
    public Map<String, Object> helloWorld2() {
		Map<String, Object> map = new HashMap<>();
		map.put("aaa", 111);
		map.put("bbb", 222);
		map.put("ccc", 333);
        return map;
    }
	
	@RequestMapping("/test3")
	public String helloWorld3() {
		return "test/test";
	}
	
	@ResponseBody
	@RequestMapping("/test4")
	public List<Map<String, Object>> helloWrild4() {
		List<Map<String, Object>> map = testDAO.selectTest();
		return map;
	}
}
