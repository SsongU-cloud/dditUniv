package kr.or.ddit.controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.ConsultingStudentService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CommonNoticeVO;
import kr.or.ddit.vo.ConsultingRequestVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 상담 신청 조회 & 상담 내역_권나현
 * @author PC-31
 *
 */

@Slf4j
@RequestMapping("/student")
@Controller
public class ConsultingStudentController {
	
	@Autowired
	ConsultingStudentService consultingStudentService;
	
	//상담 신청 조회 목록 (requestList)
	@GetMapping("/requestList")
	public ModelAndView list(ModelAndView mav,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue = "") String keyword, 
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun) {
		log.info("list에 왔다");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		// 로그인한 사용자 정보 가져오기
		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("proNo =>" + proNo);
		map.put("proNo", proNo);
		
		//행의 수
		int total = this.consultingStudentService.getTotal(map);
		log.info("list->total: " + total);
		
		List<ConsultingRequestVO> consultingRequestVOList = this.consultingStudentService.list(map);
		log.info("list->ConsultingRequestVO: " + consultingRequestVOList);
		
		mav.addObject("articlePage", new ArticlePage<ConsultingRequestVO>(total, currentPage, 10, consultingRequestVOList, keyword, queGubun));
		
		//jsp
		mav.setViewName("student/requestList");
		
		return mav;
	}
	
	
	//상담 신청 조회 목록 (requestList)
	@ResponseBody
	@PostMapping("/stulistAjax")
	public ArticlePage<ConsultingRequestVO> consultingListAjax(@RequestBody Map<String,Object> map) {
		log.info("listAjax 페이지");
		log.info("list->map : " + map);
		
		// 로그인한 사용자 정보 가져오기
		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("proNo =>" + proNo);
		map.put("proNo", proNo);
		
		//전체 행수
		int total = this.consultingStudentService.getTotal(map);
		log.info("listAjax->total : " + total);
		
		//목록
		List<ConsultingRequestVO> consultingRequestVOList = this.consultingStudentService.list(map);
		log.info("consultingRequestVOList : " + consultingRequestVOList);
		
		return new ArticlePage<ConsultingRequestVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, consultingRequestVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	
	//상담 신청 조회 목록 수정?
	@ResponseBody
	@PostMapping("/updateAjax")
	public int updateAjax(@RequestBody Map<String, Object> map) {
		log.info("updateAjax -> {}", map);
		
		String condi = (String) map.get("condition");
		String consulReqNo = (String) map.get("consulReqNo");
		log.info("condi -> {}", condi);
		log.info("consulReqNo -> {}", consulReqNo);

        ConsultingRequestVO consultingRequestVO = new ConsultingRequestVO();
        consultingRequestVO.setConsulReqCondition(condi);
        consultingRequestVO.setConsulReqNo(consulReqNo);
        log.info("consultingRequestVO -> {}", consultingRequestVO);
        
        int result = consultingStudentService.updateAjax(consultingRequestVO);
        log.info("updateAjax result -> {}", result);
        
        return result;
    }
		
		
	//신청내역///////////////////////////////////////////////////////////////////////////////////////////////////
	
	//신청내역 (requestHistory)
	@GetMapping("/requestHistory")
	public ModelAndView listHis(ModelAndView mav,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue = "") String keyword, 
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun) {
		log.info("list에 왔다");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		// 로그인한 사용자 정보 가져오기
		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("proNo =>" + proNo);
		map.put("proNo", proNo);
		
		//행의 수
		int total = this.consultingStudentService.getTotalHis(map);
		log.info("list->total: " + total);
		
		List<ConsultingRequestVO> consultingRequestVOList = this.consultingStudentService.listHis(map);
		log.info("list->ConsultingRequestVO: " + consultingRequestVOList);
		
		mav.addObject("articlePage", new ArticlePage<ConsultingRequestVO>(total, currentPage, 10, consultingRequestVOList, keyword, queGubun));
		
		//jsp
		mav.setViewName("student/requestHistory");
		
		return mav;
	}
	
	
	//상담 신청 조회 목록 (requestHistory)
	@ResponseBody
	@PostMapping("/hislistAjax")
	public ArticlePage<ConsultingRequestVO> historyListAjax(@RequestBody Map<String,Object> map) {
		log.info("historyListAjax 페이지");
		log.info("list->map : " + map);
		
		// 로그인한 사용자 정보 가져오기
		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("proNo =>" + proNo);
		map.put("proNo", proNo);
		
		//전체 행수
		int total = this.consultingStudentService.getTotalHis(map);
		log.info("historyListAjax->total : " + total);
		
		//목록
		List<ConsultingRequestVO> consultingRequestVOList = this.consultingStudentService.listHis(map);
		log.info("consultingRequestVOList : " + consultingRequestVOList);
		
		return new ArticlePage<ConsultingRequestVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, consultingRequestVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	
	//신청내역 (상세) (requestDetail)
	@GetMapping("/requestDetail")
	public String consultstudetail(@RequestParam("consulReqNo") String consulReqNo
			, Model model) {
		log.info("detail->consulReqNo : " + consulReqNo);
		
		//상세정보 가져오기
		ConsultingRequestVO consultingRequestVO = this.consultingStudentService.consultstudetail(consulReqNo);
		log.info("consultingRequestVO : " + consultingRequestVO);
		
		// Model에 데이터를 담아서 뷰로 전달
	    model.addAttribute("consultingRequestVO", consultingRequestVO);
	    model.addAttribute("consultstudetail", consultingStudentService.consultstudetail(consultingRequestVO.getConsulReqNo()));
	    log.info("consultingRequestVO-> : " + consultingRequestVO);
	    
		return "student/requestDetail";
	}
	
	
	
	
}
