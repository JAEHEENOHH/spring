package org.poseidon.controller;

import org.apache.ibatis.annotations.Param;
import org.poseidon.dto.BoardDTO;
import org.poseidon.service.BoardService;
import org.poseidon.service.RestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestFullController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private RestService restService;

	@PostMapping("/restDetail")
	public BoardDTO restDetail(@Param("no") int no) {
		BoardDTO detail = boardService.detail(no);
		return detail;
	}
	
	@PostMapping("/emailAuth")
	public int emailAuth() {
		return restService.sendEmail();
	}
	
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam("id") String id) {
		int result = restService.idCheck(id);
		// {key:value a:{a:b}}
		return "result : {count : " + result + "}";
	}
}
