package com.javaex.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;
import com.javaex.vo.UserVo;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	
	// 게시판 리스트(+ 제목 검색)
	@RequestMapping(value = "/board/list", method = {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model, String keyword) {
		System.out.println("BoardController > list()");
		
		//검색값이 없을 때
		if(keyword == null) {
			System.out.println("전체 리스트");
			keyword = "%%";
		
		//검색값이 있을 때
		}else {
			System.out.println("검색: "+keyword);
			keyword = "%" + keyword + "%";
		}
		
		List<HashMap<String, Object>> boardList = boardService.boardList(keyword);
		model.addAttribute("boardList", boardList);
		
		return "board/list";
	}
	
	
	// 게시글 읽기(1개)
	@RequestMapping(value = "/board/read", method = {RequestMethod.GET, RequestMethod.POST})
	public String read(Model model, HttpSession session, @RequestParam("no") int no) {
		System.out.println("BoardController > read()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		HashMap<String, Object> boardVo = boardService.getBoard(no);
		int userNo = Integer.parseInt(String.valueOf(boardVo.get("userNo")));
		
		//조회수
		//다른 사람의 글을 읽을 때 : 로그인 상태가 아니거나 글쓴이와 로그인한 유저가 다를 때
		if(authUser == null || (authUser.getNo()) != userNo) {
			System.out.println("게시글 조회수 상승");
			boardService.hitUp(no);
		
		//내 글을 읽을 때
		}else {
			System.out.println("게시글 조회수 그대로");
		}
		
		boardVo = boardService.getBoard(no);
		model.addAttribute("boardVo", boardVo);
		
		return "board/read";
	}
	
	
	// 게시글 삭제
	@RequestMapping(value = "/board/delete", method = {RequestMethod.GET, RequestMethod.POST})
	public String delete(HttpSession session, @RequestParam("no") int no) {
		System.out.println("BoardController > delete()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		if(authUser != null) {
			BoardVo boardVo = new BoardVo();
			boardVo.setNo(no);
			boardVo.setUserNo(authUser.getNo());
			
			//로그인한 사용자(userNo)가 작성한글(no)이 맞을 때 삭제
			boardService.boardDelete(boardVo);
		}
		
		return "redirect:/board/list";
	}
	
	
	// 게시글 작성폼
	@RequestMapping(value = "/board/writeForm") 
	public String writeForm(HttpSession session) {
		System.out.println("BoardController > writeForm()");

		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		//주소 접근 : 로그인이 상태가 아닐 때
		if(authUser == null) {
			System.out.println("접근 불가: 로그인 상태가 아님");
			
			return "redirect:/user/loginForm";

		}else {
			return "board/writeForm"; 
		}
	}
	
	
	// 게시글 작성
	@RequestMapping(value = "/board/write", method = {RequestMethod.GET, RequestMethod.POST})
	public String write(Model model, HttpSession session, BoardVo boardVo) {
		System.out.println("BoardController > write()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");

		//로그인이 상태가 아닐 때(로그인이 풀린 경우)
		if(authUser == null) {
			System.out.println("접근 불가: 로그인 상태가 아님");
			
			return "redirect:/user/loginForm";
			
		//제목 또는 내용을 작성하지 않은 경우
		}else if(boardVo.getTitle().equals("") || boardVo.getContent().equals("")){
			System.out.println("게시글 작성 실패");
			model.addAttribute("boardVo", boardVo);
			model.addAttribute("write", "Fail");
			
			return "board/writeForm";
			
		//제목/내용 모두 작성 > 게시글 작성
		}else {
			System.out.println("게시글 작성 성공");
			boardVo.setUserNo(authUser.getNo());
			boardService.boardWrite(boardVo);
			return "redirect:/board/list";
		}
	}
	
	
	// 게시글 수정폼
	@RequestMapping(value = "/board/modifyForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String modifyForm(Model model, HttpSession session, @RequestParam("no") int no) {
		System.out.println("BoardController > modifyForm()");
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		HashMap<String, Object> boardVo = boardService.getBoard(no);
		
		//주소 접근: 로그인이 되어있지 않을 때
		if(authUser == null) {
			System.out.println("게시글 수정 불가: 로그인 상태 확인");
			
			return "user/loginForm";
			
		}else {
			model.addAttribute("boardVo", boardVo);

			return "board/modifyForm"; 
		}
	}
	
	
	// 게시글 수정
	@RequestMapping(value = "board/modify", method = {RequestMethod.GET, RequestMethod.POST})
	public String modify(Model model, HttpSession session, BoardVo writeVo) {
		System.out.println("BoardController > modify()");
		 
		UserVo authUser = (UserVo)session.getAttribute("authUser");

		//주소 접근: 로그인이 되어있지 않을 때
		if(authUser == null) {
			System.out.println("게시글 수정 불가: 로그인 상태 확인");
			
			return "user/loginForm";
			
		//제목 또는 내용을 작성하지 않은 경우
		}else if(writeVo.getTitle().equals("") || writeVo.getContent().equals("")){
			System.out.println("게시글 작성 실패");
			
			HashMap<String, Object> boardVo = boardService.getBoard(writeVo.getNo());
			model.addAttribute("boardVo", boardVo);
			model.addAttribute("writeVo", writeVo);
			model.addAttribute("modify", "Fail");
			
			return "board/modifyForm";
			
		//제목/내용 모두 작성 > 게시글 작성
		}else {
			System.out.println("게시글 작성 성공");
			writeVo.setUserNo(authUser.getNo());
			boardService.boardModify(writeVo);
			
			return "redirect:/board/list";
		}
	 }
	
}
