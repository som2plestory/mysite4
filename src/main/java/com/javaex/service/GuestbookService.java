package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.GuestbookDao;
import com.javaex.vo.GuestbookVo;

@Service
public class GuestbookService {

	@Autowired
	private GuestbookDao guestbookDao;


	// 방명록 리스트
	public List<GuestbookVo> getGuestList() {
		System.out.println("GuestbookService > getGuestList()");
		
		List<GuestbookVo> guestList = guestbookDao.getGuestList();

		return guestList;
	}

	// 방명록 등록
	public void guestbookInsert(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService > getGuestInsert()");
		
		guestbookDao.guestbookInsert(guestbookVo);
	}

	// 방명록 1개 정보(삭제 정보)
	public GuestbookVo getGuest(int no) {
		System.out.println("GuestbookService > getGuest()");
		
		GuestbookVo guestbookVo = guestbookDao.getGuest(no);
		
		return guestbookVo;
	}

	// 방명록 1개 정보(비밀번호 확인)
	public GuestbookVo checkGuest(GuestbookVo guestbookVo) {
		System.out.println("GuestbookService > checkGuest()");
		
		GuestbookVo guestVo = guestbookDao.checkGuest(guestbookVo);

		return guestVo;
	}

	// 방명록 삭제
	public void guestbookDelete(GuestbookVo guestVo) {
		System.out.println("GuestbookService > guestbookDelete()");
		
		guestbookDao.guestbookDelete(guestVo);
	}

}