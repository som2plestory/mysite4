package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.UserDao;
import com.javaex.vo.UserVo;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	
	// 아이디 중복 확인
	public boolean idCheck(String id) {
		System.out.println("UserService > idCheck");
		
		if(userDao.idCheck(id) == false) return false;
		else return true;
	}
	
	// 회원 가입
	public void userInsert(UserVo userVo) {
		System.out.println("UserService > userInsert()");
		
		userDao.userInsert(userVo);
	}
	
	// 로그인 정보
	public UserVo loginUser(UserVo userVo) {
		System.out.println("UserService > loginUser()");
		
		UserVo loginUser = userDao.loginUser(userVo);
		
		return loginUser;
	}
	
	// 회원 정보 가져오기
	public UserVo getUser(int no) {
		System.out.println("UserService > getUser()");
		
		UserVo userVo = userDao.getUser(no);
		
		return userVo;
	}
	
	// 회원 정보 수정
	public void userUpdate(UserVo userVo) {
		System.out.println("UserService > userUpdate");
		
		userDao.userUpdate(userVo);
	}
}
