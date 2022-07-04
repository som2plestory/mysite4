package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.ReplyboardVo;

@Repository
public class ReplyboardDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	/**************************************** 게시판 리스트(+ 제목 검색) *****************************************/
	public List<ReplyboardVo> boardList(String keyword){
		System.out.println("ReplyboardDao > boardList()");
		
		List<ReplyboardVo> boardList = sqlSession.selectList("replyboard.boardList", keyword);
		
		return boardList;
	}
	
	
	/******************************************** 게시글 읽기(1개) *********************************************/
	public ReplyboardVo getBoard(int no){
		System.out.println("ReplyboardDao > getBoard()");
		
		ReplyboardVo boardVo = sqlSession.selectOne("replyboard.getBoard", no);
		
		return boardVo;
	}
	
	
	/*********************************** 다른 사람의 글을 읽을 때: 조회수 1 상승 ************************************/
	public void hitUp(int no) {
		System.out.println("ReplyboardDao > hitUp()");
	
		sqlSession.insert("replyboard.hitUp", no);
	}
	
	
	/********************************************** 게시글 삭제 ***********************************************/
	public int delete(ReplyboardVo boardVo) {
		System.out.println("ReplyboardDao > delete()");
		
		int count = sqlSession.delete("replyboard.delete", boardVo);
		
		return count;
	}
	
	
	/********************************************** 게시글 작성 ***********************************************/
	public void write(ReplyboardVo boardVo) {
		System.out.println("ReplyboardDao > write()");
		
		sqlSession.insert("replyboard.write", boardVo);
	}
	
	
	/********************************************* 게시글 수정폼 **********************************************/
	public ReplyboardVo modifyForm(ReplyboardVo writeVo) {
		System.out.println("ReplyboardDao > modifyForm()");	
		
		ReplyboardVo boardVo = sqlSession.selectOne("replyboard.modifyForm", writeVo);
		
		return boardVo;
	}
	
	
	/********************************************** 게시글 수정 ***********************************************/
	public int modify(ReplyboardVo writeVo) {
		System.out.println("ReplyboardDao > modify()");
		
		int count = sqlSession.update("replyboard.modify", writeVo);
		
		return count;
	}

}
