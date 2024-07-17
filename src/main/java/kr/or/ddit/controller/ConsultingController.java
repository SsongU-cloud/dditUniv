package kr.or.ddit.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.ConsultingService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ConsultingRequestVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author PC-31
 * 학생의 사이버캠퍼스 > 상담내역
 */

@Slf4j
@RequestMapping("/consulting")
@Controller
public class ConsultingController {
	
	@Autowired
	ConsultingService consultingService;
	
	
	//상담내역
	@GetMapping("/list")
	public ModelAndView list(ModelAndView mav,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue = "") String keyword, 
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun,
			Authentication auth) {
		log.info("list에 왔다");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		// 로그인한 사용자 정보 가져오기
		//String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		String stNo = auth.getName();
		log.info("stNo =>" + stNo);
		map.put("stNo", stNo);
		
		//행의 수
		int total = this.consultingService.getTotal(map);
		log.info("list->total: " + total);
		
		List<ConsultingRequestVO> consultingRequestVOList = this.consultingService.list(map);
		log.info("list->ConsultingRequestVO: " + consultingRequestVOList);
		
		mav.addObject("articlePage", new ArticlePage<ConsultingRequestVO>(total, currentPage, 10, consultingRequestVOList, keyword, queGubun));
		
		//jsp
		mav.setViewName("consulting/list");
		
		return mav;
	}
	
	
	//상담내역
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<ConsultingRequestVO> consultingListAjax(@RequestBody Map<String,Object> map) {
		log.info("listAjax 페이지");
		log.info("list->map : " + map);
		
		// 로그인한 사용자 정보 가져오기
//	    String stNo = "";
//		stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo =>" + stNo);
		map.put("stNo", stNo);
		
		//전체 행수
		int total = this.consultingService.getTotal(map);
		log.info("listAjax->total : " + total);
		
		//목록
		List<ConsultingRequestVO> consultingRequestVOList = this.consultingService.list(map);
		log.info("listAjax_consultingRequestVOList : " + consultingRequestVOList);
		
		return new ArticlePage<ConsultingRequestVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, consultingRequestVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	
	//상담신청GET
	@GetMapping("/request")
	public String create(Principal principal, Model model) {
	    if(principal == null) {
	        return "redirect:/login";
	    }
	    
	    // 로그인한 사람 ID(학번)
	    String stNo = principal.getName();
	    log.info("stNo->" + stNo);
	    
	    // 로그인한 사람 ID를 이용하여 담당 교수의 이름 조회
	    String proName = this.consultingService.create(stNo);
	    log.info("proName->" + proName);
	    
	    // 모델에 담당 교수의 이름 추가
	    model.addAttribute("proName", proName);
	    
	    return "consulting/request";
	}

	
	
	//상담 신청POST (버튼 누르면)
	@ResponseBody
	@PostMapping("/createAjax")
	public int createAjax(
			@RequestBody ConsultingRequestVO consultingRequestVO, Authentication auth) {
		log.info("createAjax : " + consultingRequestVO);
		
		// 로그인한 사람 ID(학번)
		String stNo = auth.getName();
	    log.info("stNo->" + stNo);
	    
	    // 사번(작성자)
	    consultingRequestVO.setStNo(stNo);
		
	    // 기본정보 insert
		int result = this.consultingService.createAjax(consultingRequestVO);
		log.info("createAjax->result : " + result);
		
		return result;
	}
	
	
	//상담신청
	@GetMapping("/detail")
	public String detail(@RequestParam("consulReqNo") String consulReqNo
			, Model model) {
		log.info("detail->consulReqNo : " + consulReqNo);
		
		//상세정보 가져오기
		ConsultingRequestVO consultingRequestVO = this.consultingService.detail(consulReqNo);
		log.info("consultingRequestVO : " + consultingRequestVO);
		
		// Model에 데이터를 담아서 뷰로 전달
	    model.addAttribute("consultingRequestVO", consultingRequestVO);
	    model.addAttribute("detail", consultingService.detail(consultingRequestVO.getConsulReqNo()));
	    log.info("consultingRequestVO-> : " + consultingRequestVO);
	    
		return "consulting/detail";
	}
	
}
