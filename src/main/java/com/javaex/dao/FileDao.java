package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.FileVo;

@Repository
public class FileDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	// 첨부파일 저장
	public void insertFile(FileVo fileVo) {
		System.out.println("FileDao > insertFile()");
		
		sqlSession.insert("file.insertFile", fileVo);
	}
}
