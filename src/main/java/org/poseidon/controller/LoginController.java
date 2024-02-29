package org.poseidon.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.poseidon.dto.LoginDTO;
import org.poseidon.dto.MemberDTO;
import org.poseidon.service.LoginService;
import org.poseidon.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@Autowired
	private Util util;

	// get /login 2024-02-20 psd
	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@PostMapping("/login")
	public String login(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		// System.out.println("id : " + id + " / pw : " + pw);//id : weaeaf / pw :
		// fwfewf234234234

		LoginDTO loginDTO = new LoginDTO();
		loginDTO.setId(id);
		loginDTO.setPw(pw);

		LoginDTO login = loginService.login(loginDTO);
		if (login.getCount() == 1 && login.getMcount() < 5) {
			if (login.getPw().equals(loginDTO.getPw())) {// 비밀번호 비교
				// 세션만들기
				HttpSession session = request.getSession();
				session.setAttribute("mid", id);
				session.setAttribute("mname", login.getMname());
				// 해당 id의 mcount를 1으로 만들기
				loginService.mcountReset(loginDTO);
				return "redirect:/index";
			} else {
				// mcountUP
				loginService.mcountUp(loginDTO);
				return "redirect:/login?count=" + login.getMcount();
			}
		} else {
			// 잘못된 로그인일 경우 로그인 창으로 이동하기 = 5번 시도했으면 잠그기.
			// 해당 id의 mcount를 +1시키기
			loginService.mcountUp(loginDTO);
			return "redirect:/login?count=" + login.getMcount();
		}

	}

	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("mid") != null) {
			session.removeAttribute("mid");
		}
		if (session.getAttribute("mname") != null) {
			session.removeAttribute("mname");// 이거와
		}
		session.invalidate();// 이거 꼭 확인하세요.
		return "redirect:/login";
	}

	// http://172.30.1.75/myInfo@poseidon
	// http://172.30.1.75/detail?no=456
	// http://172.30.1.75/detail/456
	// http://172.30.1.75/detail/{no}/{pageNo}

	@GetMapping("/myInfo@{id}")
	public String myInfo(@PathVariable("id") String id) throws EmailException {
		// System.out.println("id : " + id);
		// 로그인 했어?
		if (util.getSession().getAttribute("mid") != null) {

			// 인증요청하기 = ajax용으로 빼두기
			// loginService.myInfo();

			return "myinfo";
		} else {
			return "redirect:/login?error=error";
		}

	}
	
	//2024-02-28 psd 애플리케이션 테스트 수행
	/*
	 * 스케치 -> 와이어프레임 -> 목업 -> 프로토타입 -> 스토리보드
	 * 
	 * 와이어프레임 : 기획 단계의 기초를 제작하는 단계. 페이지의 레이아웃이나 UI요소 등
	 * 					뼈대
	 * 목업         : 와이어프레임보다 조금 더 설계 화면과 유사하게 만다는 것.
	 * 					정적 모델링
	 * 프로토타입   : 다양한 인터렉션이 결합되어 실제 서비스처럼 동작하는 것.
	 * 
	 * 스토리보드   : 설명, 기능 명세서, 와이어프레임, 프로세스, 정책 등등
	 * 					설계 문서
	 */
	
	//아이디 -> 중복검사
	//비밀번호1
	//비밀번호2
	//이메일 -> 중복 불가
	//닉네임
	
	@GetMapping("/join")
	public String join() {
		return "join";
	}
	
	@PostMapping("/join")
	public String join(HttpServletRequest request) {
		System.out.println(request.getParameter("id"));
		System.out.println(request.getParameter("pw"));
		System.out.println(request.getParameter("name"));
		System.out.println(request.getParameter("email"));
		
		MemberDTO join = new MemberDTO();
		join.setMid(request.getParameter("id"));
		join.setMpw(request.getParameter("pw"));
		join.setMname(request.getParameter("name"));
		join.setMemail(request.getParameter("email"));
		
		int result = loginService.join(join);
		System.out.println("회원가입 결과 " + result);
		
		return "redirect:/login";
	}
}