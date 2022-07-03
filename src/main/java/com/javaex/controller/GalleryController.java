package com.javaex.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.GalleryService;
import com.javaex.vo.GalleryVo;
import com.javaex.vo.UserVo;

@Controller
public class GalleryController {
	
	@Autowired
	private GalleryService galleryService;

	
	// 갤러리 리스트
	@RequestMapping(value="/gallery/list")
	public String list(Model model) {
		System.out.println("GalleryController > list()");
		
		//리스트 받아오기
		List<GalleryVo> galleryList = galleryService.getGalleryList();
		model.addAttribute("galleryList", galleryList);
		System.out.println(galleryList);
		
		return "gallery/list";
	}
	
	
	// 이미지 업로드
	@RequestMapping(value="/gallery/upload", method = {RequestMethod.GET, RequestMethod.POST})
	public String upload(@RequestParam("file") MultipartFile file, HttpSession session, GalleryVo galleryVo) {
		System.out.println("GalleryController > upload()");
		
		UserVo authUser =(UserVo)session.getAttribute("authUser");
		
		if(authUser != null) {
		System.out.println(galleryVo);
		galleryVo.setUserNo(authUser.getNo());
		
		galleryService.upload(file, galleryVo);
		}
		
		return "redirect:/gallery/list";
	}
	
	
	// 이미지 삭제(ajax)
	@ResponseBody
	@RequestMapping(value="/gallery/delete", method = {RequestMethod.GET, RequestMethod.POST})
	public String delete(@RequestBody int no) {
		System.out.println("GalleryController > delete()");
		
		String result = galleryService.deleteImage(no);
		
		return result;
	}

}
