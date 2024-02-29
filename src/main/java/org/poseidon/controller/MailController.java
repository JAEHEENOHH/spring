package org.poseidon.controller;

import org.apache.commons.mail.EmailException;
import org.poseidon.service.MailSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

//20240223 요구사항확인 psd

@Controller
public class MailController {
	
	@Autowired
	private MailSerivce mailSerivce;
	
	//제작순서
	//menu에다가 추가 -> Controller -> jsp -> 화면구성 -> service
	@GetMapping("/mail")
	public String mail() {
		//로그인 한 사용자만 접근가능합니다.
		return "mail";
	}
	
	//jsp -> Controller -> Service 메일발송
	@PostMapping("/mail")
	public String mail(@RequestParam("email") String email, 
				@RequestParam("title") String title, @RequestParam("content") String content) throws EmailException {
		System.out.println("email : " + email);
		System.out.println("title : " + title);
		System.out.println("conent : " + content);

		mailSerivce.sendTextMail(email, title, content);
		mailSerivce.sendHTMLMail(email, title, content);
		
		return "redirect:/mail";
	}
	
}
