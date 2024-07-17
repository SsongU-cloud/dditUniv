package kr.or.ddit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/studstat")
@Slf4j
@Controller
public class StudentStatController {

	//휴학 신청
	@GetMapping("/rest")
	public String tutionall() {
		//forwarding
		return "studentstat/rest";
	}
	
	//복학 신청
	@GetMapping("/comeback")
	public String comeback() {
		//forwarding
		return "studentstat/comeback";
	}
	
	//자퇴 신청
	@GetMapping("/dropout")
	public String dropout() {
		//forwarding
		return "studentstat/dropout";
	}
	
}
