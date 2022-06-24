package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	
	// 회원 가입폼
	@RequestMapping(value = "/user/joinForm")
	public String joinForm() {
		System.out.println("UserController > joinForm()");
		
		return "user/joinForm";
	}
	
	
	// 아이디 중복 확인
	//@RequestMapping(value = "/user/idCheck")
	
	
	// 회원 가입
	@RequestMapping(value = "/user/join", method = { RequestMethod.GET, RequestMethod.POST})
	public String join(Model model, @ModelAttribute UserVo userVo) {
		System.out.println("UserContoller > join()");
		
		//약관동의
		
		//아이디 중복이거나 입력하지 않았으면
		if(userService.idCheck(userVo.getId())==false) {
			System.out.println("회원가입 실패: 아이디가 중복입니다.");
			model.addAttribute("userVo", userVo);
			model.addAttribute("idCheck", "Fail");
			
			return "user/joinForm";
			
		//입력한 아이디가 중복이 아니지만 비밀번호/이름 중에 하나라도 입력하지 않았을 때
		}else if(userVo.getId().equals("") ||userVo.getPassword().equals("") || userVo.getName().equals("")) {
			System.out.println("회원가입 실패: 아이디/비밀번호/이름 중 한 가지 이상 입력되지 않았습니다.");
			model.addAttribute("userVo", userVo);
			
			return "user/joinForm";
		
		//아이디 미중복 /비밀번호/이름 모두 입력 > 회원가입
		}else {
			System.out.println("회원가입 성공");
			userService.userInsert(userVo);
			
			return "redirect:/user/joinOk";
		}
	}
	
	
	// 회원 가입 성공폼
	@RequestMapping(value = "/user/joinOk") public String joinOk() {
	System.out.println("UserController > joinOk()");
	
	return "/user/joinOk"; 
	}
	
	
	// 로그인폼
	@RequestMapping(value = "/user/loginForm")
	public String loginForm() {
		System.out.println("UserController > loginForm()");
		
		return "user/loginForm";
	}
	
	
	// 로그인
	@RequestMapping(value = "/user/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(HttpSession session, UserVo userVo) {
		System.out.println("UserController > login()");

		UserVo authUser = userService.loginUser(userVo);
		
		if(authUser != null) {
			System.out.println("로그인 성공");
			session.setAttribute("authUser", authUser);

			return "redirect:/main";
			
		}else {
			System.out.println("로그인 실패");
			
			return "redirect:/user/loginForm?result=fail";
		}
		
	}
	
	
	// 로그아웃
	@RequestMapping(value = "/user/logout")
	public String logout(HttpSession session) {
		System.out.println("UserController > login()");
		
		session.removeAttribute("authUser");
		session.invalidate();
		
		return "redirect:/main";
	}
	
	
	// 회원 정보 수정폼
	@RequestMapping(value = "/user/modifyForm")
	public String modifyForm(Model model, HttpSession session, UserVo userVo) {
		System.out.println("UserController > modifyForm()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		//세션에서 불러온 정보가 없을 때
		if(authUser == null) {
			System.out.println("회원정보 수정불가: 로그인이 되어있지않음");
			
			return "redirect:/user/loginForm";
			
		//로그인이 되어있을 때
		}else {
			model.addAttribute("userVo", userService.getUser(authUser.getNo()));
			
			return "/user/modifyForm";
		}
		
	}
	
	
	// 회원 정보 수정
	@RequestMapping(value = "/user/modify")
	public String modify(Model model, HttpSession session, @ModelAttribute UserVo userVo) {
		System.out.println("UserController > modify()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		//로그인이 풀리면
		if(authUser == null) {
			System.out.println("회원정보 수정불가: 로그인이 되어있지않음");
			
			return "redirect:/user/loginForm";
			
		//비밀번호 또는 이름이 입력되지 않았을 때
		}else if(userVo.getPassword().equals("") || userVo.getName().equals("")) {
			System.out.println("회원정보 수정 실패");
			userVo = userService.getUser(authUser.getNo());
			model.addAttribute("userVo", userVo);
			
			return "redirect:/user/modifyForm?result=fail";
			
		}else {
			System.out.println("회원정보 수정 성공");
			System.out.println(userVo);
			userService.userUpdate(userVo);
			session.setAttribute("authUser", userService.loginUser(userVo));
			
			return "redirect:/user/modifyOk";
		}
	}
	
	
	// 회원 정보 수정 성공폼
	@RequestMapping(value = "/user/modifyOk")
	public String modifyOk() {
		System.out.println("UserController > modifyOk()");
		
		return "user/modifyOk";
	}
}
