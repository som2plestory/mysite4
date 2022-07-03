package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GalleryVo;

@Repository
public class GalleryDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	// 갤러리 리스트
	public List<GalleryVo> selectList(){
		System.out.println("GalleryDao > selectList()");
		
		List<GalleryVo> galleryList = sqlSession.selectList("gallery.selectList");
		
		return galleryList;
	}
	
	
	// 이미지 업로드
	public void insertImage(GalleryVo galleryVo) {
		System.out.println("GalleryDao > inserImage()");
		
		sqlSession.insert("gallery.insertImage", galleryVo);
	}
	
	
	// 이미지 삭제
	public int deleteImage(int no) {
		System.out.println("GalleryDao > deleteImage()");
		
		int count = sqlSession.delete("gallery.deleteImage", no);
		
		return count;
	}
}
