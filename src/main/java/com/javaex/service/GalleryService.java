package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.GalleryDao;
import com.javaex.vo.GalleryVo;

@Service
public class GalleryService {

	@Autowired
	private GalleryDao galleryDao;
	
	
	// 갤러리 리스트
	public List<GalleryVo> getGalleryList(){
		System.out.println("GalleryService > getGalleryList()");
		
		List<GalleryVo> galleryList = galleryDao.selectList();
		return galleryList;
	}
	
	
	// 이미지 업로드
	public void upload(MultipartFile file, GalleryVo galleryVo) {
		System.out.println("GalleryService > upload()");
		
		String saveDir = "C:\\javaStudy\\upload";
		String orgName = file.getOriginalFilename();
		String exName = orgName.substring(orgName.lastIndexOf("."));
		String saveName = System.currentTimeMillis()+UUID.randomUUID().toString()+exName;
		String filePath = saveDir + "\\" + saveName;
		long fileSize = file.getSize();
		
		galleryVo.setFilePath(filePath);
		galleryVo.setOrgName(orgName);
		galleryVo.setSaveName(saveName);
		galleryVo.setFileSize(fileSize);
		
		galleryDao.insertImage(galleryVo);
		
		try {
			byte[] fileData = file.getBytes();
			OutputStream os = new FileOutputStream(filePath);
			BufferedOutputStream bos = new BufferedOutputStream(os);
			
			bos.write(fileData);
			bos.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	// 이미지 삭제(ajax)
	public String deleteImage(int no) {
		System.out.println("GalleryService > deleteImage()");
		
		String state;
		
		int count = galleryDao.deleteImage(no);
		
		if(count == 1) {
			state = "success";
		}else {
			state = "fail";
		}
		
		return state;
	}
	
}
