 package kr.or.ddit.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.AchService;
import kr.or.ddit.service.LectureService;
import kr.or.ddit.vo.AchExeptionVO;
import kr.or.ddit.vo.LecEvalItemVO;
import kr.or.ddit.vo.LecEvaluationVO;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/achieve") 
@Slf4j
@Controller
public class AchController {
	
	@Autowired
	AchService achService;
	
	@Autowired
	LectureService lectureService;
	
	String stNo;
	
	@GetMapping("/nowAch")
	public String nowAch(Model model) {
		
		stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		
		// 내 학년 정보 가져오기
		StudentVO studentVO = this.lectureService.myInfo(stNo);
		
		// 신청 학점
		int appScore = achService.appScore(stNo);
		// 취득학점 
		int achScore = achService.achScore(stNo);
		// 평점계
		int ttAvg = achService.ttAvg(stNo);
		// 평점평균
		String avgAch = achService.avgAch(stNo);
		// 백분율
		int percentage = achService.percentage(stNo);
		// 석차
		Map<String,Object> rankMap = achService.rank(stNo);
		int rank = ((BigDecimal)rankMap.get("RANK")).intValue();
		int count = ((BigDecimal)rankMap.get("COUNT")).intValue();
		
		// 수강 강의 목록
		List<StuLectureVO> stuLectureVOList = achService.stuLectureVOList(stNo);
		
		// 이의 신청 목록
		List<AchExeptionVO> achExeptionVOList = achService.achExeptionVOList(stNo);
		
		log.info("nowAch >> achExeptionVOList : {}",achExeptionVOList);
		
		model.addAttribute("studentVO", studentVO);
		model.addAttribute("appScore", appScore);
		model.addAttribute("achScore", achScore);
		model.addAttribute("ttAvg", ttAvg);
		model.addAttribute("avgAch", avgAch);
		model.addAttribute("percentage", percentage);
		model.addAttribute("rank", rank);
		model.addAttribute("count", count);
		model.addAttribute("stuLectureVOList", stuLectureVOList);
		model.addAttribute("achExeptionVOList",achExeptionVOList);
		
		//forwarding : /views/success.jsp
	    return "achieve/nowAch";
	}
	
	
	@PostMapping("/lecEvaluation")
	public String lecEvaluation(String stuLecNo, Model model) {
		log.info("강의평가 페이지");
		
		log.info("lecEvaluation >> stuLecNo : {}",stuLecNo);
		
		// 강의 정보
		StuLectureVO stuLectureVO = achService.evalStuLectureVO(stuLecNo);
		log.info("lecEvaluation >> stuLectureVO : {}",stuLectureVO );
		
		// 강의 평가 항목
		List<LecEvalItemVO> lecEvaluationVOList = achService.lecEvaluationVOList();
		model.addAttribute("stuLectureVO", stuLectureVO);
		
		List<LecEvalItemVO> selfEvalItemList = new ArrayList<LecEvalItemVO>();
		List<LecEvalItemVO> multiChoiceEvalItemList = new ArrayList<LecEvalItemVO>();
		List<LecEvalItemVO> subjectiveEvalItemList = new ArrayList<LecEvalItemVO>();
		List<LecEvalItemVO> environmentEvalItemList = new ArrayList<LecEvalItemVO>();
		
		for(LecEvalItemVO lecEvalItemVO : lecEvaluationVOList) {
			String itemNo = lecEvalItemVO.getLecEvalItemNo().substring(0,2);
			log.info("lecEvalItemVO >> itemNo.substring : {}",itemNo);
			
			if((itemNo).equals("e1")) {
				selfEvalItemList.add(lecEvalItemVO);
			}
			else if((itemNo).equals("e2")) {
				multiChoiceEvalItemList.add(lecEvalItemVO);
			}
			else if((itemNo).equals("e3")){
				subjectiveEvalItemList.add(lecEvalItemVO);
			}
			else {
				environmentEvalItemList.add(lecEvalItemVO);
			}
		}
		
		model.addAttribute("selfEvalItemList",selfEvalItemList);
		model.addAttribute("multiChoiceEvalItemList",multiChoiceEvalItemList);
		model.addAttribute("subjectiveEvalItemList",subjectiveEvalItemList);
		model.addAttribute("environmentEvalItemList",environmentEvalItemList);
		
		//forwarding : /views/success.jsp
		return "achieve/lecEvaluation";
	}
	
	@ResponseBody
	@PostMapping("/lecEvaluationCreate")
	public int lecEvaluationCreate(@RequestBody List<LecEvaluationVO> lecEvaluationVOList) {
		int result = 0;
		
		for(LecEvaluationVO lecEvaluationVO : lecEvaluationVOList) {
			log.info("lecEvaluationCreate >> lecEvaluationVO : {}", lecEvaluationVO);
		}
		
		result = achService.lecEvaluationCreate(lecEvaluationVOList);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/lecExeptionCreate")
	public int lecExeptionCreate(@RequestBody AchExeptionVO achExeptionVO) {
		
		
		log.info("lecExeptionCreate >> achExeptionVO : {}", achExeptionVO);
		
		int result = achService.lecExeptionCreate(achExeptionVO); 
		
		log.info("lecExeptionCreate >> result : {}",result);
		
		return result;
	}
	
	/**
	* 전체 성적 조회
	* @author 김다희
	* @return
	*/
	@GetMapping("/totalAch")
	public String totalAch() {
		return "achieve/totalAch";
	}	
	
	@ResponseBody
	@PostMapping("/lecExUpd")
	public int lecExUpd(@RequestBody AchExeptionVO achExeptionVO) {
		log.info("lecExUpd >> achExeptionVO : {}",achExeptionVO);
		
		int result = achService.lecExUpd(achExeptionVO);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/lecExDel")
	public int lecExDel(@RequestBody String stuLecNo) {
		log.info("lecExDel >> stuLecNo : {}",stuLecNo);
		
		int result = achService.lecExDel(stuLecNo);
		
		log.info("lecExDel >> result : {}",result);
		
		return result;
	}
}
