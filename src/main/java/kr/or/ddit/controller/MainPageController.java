package kr.or.ddit.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.MainPageService;
import kr.or.ddit.vo.CommonNoticeVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("mainPage")
@Slf4j
@Controller
public class MainPageController {
	
	@Autowired
	MainPageService mainPageService;
	
	@GetMapping("/mainAdmin")
	public String mainAdmin(Model model) {
		
		List<CommonNoticeVO> noticeList = this.mainPageService.getNoticeList();
		log.info("noticeList >>>> " + noticeList);
		
		model.addAttribute("noticeList",noticeList);
		
		return "mainPage/mainAdmin";
	}
	
	@GetMapping("/mainPro")
	public String mainPro(Model model) {
		
		List<CommonNoticeVO> noticeList = this.mainPageService.getNoticeList();
		log.info("noticeList >>>> " + noticeList);
		
		model.addAttribute("noticeList",noticeList);
		
		return "mainPage/mainPro";
	}                                                                                                                                                                                                                                                                                                                                         
	
	@GetMapping("/mainStu")
	public String mainStu(Model model) {
		log.info("main Student");
		
		List<CommonNoticeVO> noticeList = this.mainPageService.getNoticeList();
		log.info("noticeList >>>> " + noticeList);
		
		model.addAttribute("noticeList",noticeList);
		
		return "mainPage/mainStu";
	}
	
	@ResponseBody
	@GetMapping("/loginSessionPlus")
	public int loginSessionPlus(HttpSession session) {
		
		int sessionTime = session.getMaxInactiveInterval();
//		log.info("session 시간1 : ", sessionTime);
		
		session.setMaxInactiveInterval(1800);
		
		log.info("session 시간2 : ", sessionTime);
		
		return sessionTime;
	}
}
