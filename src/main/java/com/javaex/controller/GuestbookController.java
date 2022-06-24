package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVo;

@Controller
public class GuestbookController {
	
	@Autowired 
	private GuestbookService guestbookService;

	
	// 방명록 리스트
	@RequestMapping(value = "/guestbook/addList", method = { RequestMethod.GET, RequestMethod.POST })
	public String list(Model model) {
		System.out.println("GuestbookController > addList()");
		
		List<GuestbookVo> guestList = guestbookService.getGuestList();
		model.addAttribute("guestList", guestList);
		
		return "guestbook/addList";
	}

	// 방명록 등록
	@RequestMapping(value = "/guestbook/add", method = { RequestMethod.GET, RequestMethod.POST })
	public String add(@ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("GuestbookController > add()");
		
		guestbookService.guestbookInsert(guestbookVo);
		
		return "redirect:/guestbook/addList";
	}

	// 방명록 삭제폼
	@RequestMapping(value = "/guestbook/deleteForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteForm(Model model, @RequestParam("no") int no) {
		System.out.println("GuestbookController > deleteForm()");
		
		GuestbookVo guestbookVo = guestbookService.getGuest(no);
		model.addAttribute("guestbookVo", guestbookVo);
		
		return "guestbook/deleteForm";
	}
	
	// 방명록 삭제
	@RequestMapping(value = "/guestbook/delete", method = { RequestMethod.GET, RequestMethod.POST })
	public String delete(Model model, @ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("GuestbookController > delete()");

		GuestbookVo guestVo = guestbookService.checkGuest(guestbookVo);
		
		if (guestVo != null) {
			System.out.println("방명록 삭제 성공");
			guestbookService.guestbookDelete(guestVo);
			
			return "redirect:/guestbook/addList";
			
		} else {
			System.out.println("방명록 삭제 실패: 비밀번호 오류");
			guestVo = guestbookService.getGuest(guestbookVo.getNo());
			model.addAttribute("guestbookVo", guestVo);
			
			//실패표시
			model.addAttribute("guestbookDelete", "Fail");
			 
			return "guestbook/deleteForm";
		}
	}

}