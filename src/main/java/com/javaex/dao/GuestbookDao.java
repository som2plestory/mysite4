package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GuestbookVo;

@Repository
public class GuestbookDao {

	@Autowired
	private SqlSession sqlSession;

	// 방명록 리스트
	public List<GuestbookVo> getGuestList() {
		System.out.println("GuestbookDao > getGuestList()");
		
		List<GuestbookVo> guestList = sqlSession.selectList("guestbook.selectList");
		
		return guestList;
	}

	// 방명록 등록
	public void guestbookInsert(GuestbookVo guestbookVo) {
		System.out.println("GuestbookDao > guestbookInsert()");
		
		sqlSession.insert("guestbook.guestbookInsert", guestbookVo);
	}

	// 방명록 정보 가져오기(방명록 삭제 폼- 삭제할 방명록 정보 확인) no name password content reg_date
	public GuestbookVo getGuest(int no) {
		System.out.println("GuestbookDao > getGuest()");
		
		GuestbookVo guestbookVo = sqlSession.selectOne("guestbook.getGuest", no);
		
		return guestbookVo;
	}

	// 방명록 작성자 정보 가져오기(비밀번호 확인용)
	public GuestbookVo checkGuest(GuestbookVo guestbookVo) {
		System.out.println("GuestbookDao > checkGuest");
		
		GuestbookVo guestVo = sqlSession.selectOne("guestbook.checkGuest", guestbookVo);
		//guestbookVo = sqlSession.selectOne("guestbook.checkGuest", guestbookVo);
		
		return guestVo;
	}

	// 방명록 삭제
	public void guestbookDelete(GuestbookVo guestVo) {
		System.out.println("GuestbookDao > guestbookDelete()");
		
		sqlSession.delete("guestbook.guestbookDelete", guestVo);
	}

}