package com.javaex.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.dao.BoardDao;
import com.javaex.vo.BoardVo;

@Repository
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	
	// // 게시판 리스트(+ 제목 검색)
	public List<HashMap<String, Object>> boardList(String keyword){
		System.out.println("BoardService > BoardList()");
		
		List<HashMap<String, Object>> boardList = boardDao.boardList(keyword);
		
		return boardList;
	}
	
	// 게시글 정보(글 한 개 읽기)
	public HashMap<String, Object> getBoard(int no){
		System.out.println("BoardService > read()");
		
		HashMap<String, Object> boardVo = boardDao.getBoard(no);
		
		return boardVo;
	}
	
	// 다른 사람의 글을 읽을 때: 조회수 1 상승
	public void hitUp(int no) {
		System.out.println("BoardService > hitUp()");
	
		boardDao.hitUp(no);
	}
	
	// 게시글 삭제
	public void boardDelete(BoardVo boardVo) {
		System.out.println("BoardService > boardDelete()");
		
		boardDao.boardDelete(boardVo);
	}
	
	// 게시글 작성
	public void boardWrite(BoardVo boardVo) {
		System.out.println("BoardService > boardWrite()");
		
		boardDao.boardWrite(boardVo);
	}
	
	// 게시글 수정
	public void boardModify(BoardVo boardVo) {
		System.out.println("BoardService > boardModify()");
		
		boardDao.boardModify(boardVo);
	}
}
