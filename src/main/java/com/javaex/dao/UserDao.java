package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVo;

@Repository
public class UserDao {

		@Autowired
		private SqlSession sqlSession;
		
		
		// 아이디 중복 확인
		public boolean idCheck(String id) {
			System.out.println("UserDao > idCheck");
			
			if(sqlSession.selectOne("users.idCheck", id) == null) return true;
			else return false;
		}
		
		
		// 회원 가입
		public void userInsert(UserVo userVo) {
			System.out.println("UserDao > userInsert()");
			
			sqlSession.insert("users.userInsert", userVo);
		}
		
		// 로그인 정보 (no, name)
		public UserVo loginUser(UserVo userVo) {
			System.out.println("UserDao > loginUser()");
			
		UserVo loginUser = sqlSession.selectOne("users.loginUser", userVo);
			
			return loginUser;
		}
		
		// 회원 정보 가져오기
		public UserVo getUser(int no) {
			System.out.println("UserDao > getUser()");
			
			UserVo userVo = sqlSession.selectOne("users.getUser", no);
			
			return userVo;
		}
		
		// 회원 정보 수정
		public void userUpdate(UserVo userVo) {
			System.out.println("UserDao > userUpdate()");
			
			sqlSession.update("users.userUpdate", userVo);
		}
		

}
