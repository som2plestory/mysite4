package com.javaex.api.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVo;

@Controller
public class ApiGuestbookController {

	
	@Autowired 
	private GuestbookService guestbookService;

	
	//방명록 첫페이지(등록폼+리스트(ajax))
	@RequestMapping(value="/api/guestbook/addList", method = {RequestMethod.GET, RequestMethod.POST})
	public String addList() {
		System.out.println("ApiGuestbookController > addList()");
		
		
		return "apiGuestbook/addList";
	}
	
	
	//방명록 리스트 데이터만 보내줘
	@ResponseBody
	@RequestMapping(value="/api/guestbook/list", method = {RequestMethod.GET, RequestMethod.POST})
	public List<GuestbookVo> list() {
		System.out.println("ApiGuestbookController > List()");
		
		List<GuestbookVo> guestList = guestbookService.getGuestList();
		
		return guestList;
	}
	
	
	//방명록 저장(ajax)
	@ResponseBody
	@RequestMapping(value="/api/guestbook/add", method = {RequestMethod.GET, RequestMethod.POST})
	public GuestbookVo add(@ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("ApiGuestbookController > add()");
		
		GuestbookVo gVo = guestbookService.addGuest(guestbookVo);
	
		return gVo;
	}
	
	
	//방명록 삭제폼(ajax)
	//no을 model없이 어떻게 삭제 정보로 가게끔 해야할지 모르겠어 
	@RequestMapping(value="/api/guestbook/deleteForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteForm(Model model, @RequestParam("no") int no) {
		System.out.println("ApiGuestbookController > deleteForm()");
		
		model.addAttribute("no", no);
		
		return "apiGuestbook/deleteForm";
	}
		
		
	//방명록 삭제 정보 불러오기(ajax)
	@ResponseBody
	@RequestMapping(value="/api/guestbook/deleteInfo", method = {RequestMethod.GET, RequestMethod.POST})
	public GuestbookVo deleteInfo(@RequestParam("no") int no) {
		System.out.println("ApiGuestbookController > deleteInfo()");
		
		GuestbookVo guestbookVo = guestbookService.getGuest(no);
		
		return guestbookVo;
	}
}
