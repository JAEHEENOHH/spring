package org.poseidon.service;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Service;

@Service
public class MailSerivce  extends AbstractService {

	// 메일 보내기
	public void sendTextMail(String email, String title, String content) throws EmailException {
		String emailAddr = ""; // 보내는 사람 = 아웃룩
		String name = "서버에서 보냄"; // 보내는 사람 이름 = 아웃룩
		String pw = ""; // 보내는 사람 비번 = 아웃룩
		String host = "smtp-mail.outlook.com"; // 아웃룩 호스트
		int port = 587; // 아웃룩 포트

		SimpleEmail mail = new SimpleEmail();
		mail.setCharset("UTF-8"); // 언어셋
		mail.setDebug(true); // 디버그
		mail.setHostName(host); // 호스트 = 아웃룩
		mail.setAuthentication(emailAddr, pw);// 보내는 사람 이메일 주소, 비밀번호
		mail.setSmtpPort(port); // 보내는 포트
		mail.setFrom(emailAddr, name);// 보내는 사람의 주소, 이름
		mail.setStartTLSEnabled(true);// 인증방법
		mail.addTo(email); // 받는 사람 === 파라미터로
		mail.setSubject(title); //제목 ==== 파라미터로
		mail.setMsg(content); // 내용 ===== 파라미터로
		mail.send(); //발송

	}

	public void sendHTMLMail(String email, String title, String content) throws EmailException {
		String emailAddr = ""; // 보내는 사람 = 아웃룩
		String name = "서버에서 보냄"; // 보내는 사람 이름 = 아웃룩
		String pw = ""; // 보내는 사람 비번 = 아웃룩
		String host = "smtp-mail.outlook.com"; // 아웃룩 호스트
		int port = 587; // 아웃룩 포트
		
		HtmlEmail mail = new HtmlEmail();
		mail.setCharset("UTF-8"); // 언어셋
		mail.setDebug(true); // 디버그
		mail.setHostName(host); // 호스트 = 아웃룩
		mail.setAuthentication(emailAddr, pw);// 보내는 사람 이메일 주소, 비밀번호
		mail.setSmtpPort(port); // 보내는 포트
		mail.setFrom(emailAddr, name);// 보내는 사람의 주소, 이름
		mail.setStartTLSEnabled(true);// 인증방법
		mail.addTo(email); // 받는 사람 === 파라미터로
		mail.setSubject(title); //제목 ==== 파라미터로
		mail.setMsg(content); // 내용 ===== 파라미터로
		
		//첨부파일
		EmailAttachment file = new EmailAttachment();
		file.setPath("c:\\temp\\img.png");
		mail.attach(file);		
		
		mail.send(); //발송
		
	}

}
