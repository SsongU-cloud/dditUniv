package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.StudentCheckService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.TimeExchangeManageVO;
import lombok.extern.slf4j.Slf4j;



/**
 * 
 * @author PC-06
 * 교수 > 학생 > 담당 학생 관리 > 담당 학생 정보 조회 or 디테일까지 	
 *
 */
@Controller
@RequestMapping("/student")
@Slf4j
public class StudentCheckController {
	
	@Autowired
	StudentCheckService studentCheckService;
	
	String userNo = "";
	//교수 - 학생 조회 페이지  
	//멜렁
	@GetMapping("/stuList")
	public String stdlist(Map<String,Object> map, Model model, Authentication auth) {
		userNo = auth.getName();
		// map = 교수번호(담당 학생)
		map.put("userNo", userNo);
		log.info("map >>>>>>> " + map);
		List<StudentVO> studentVOList 
		= this.studentCheckService.list(map);
		
		int allCount = studentVOList.size();
		log.info("allCount>>{}",allCount);
//		for (StudentVO studentVO : studentVOList) {
//			allCount ++;
//		}
		log.info("list-> studentVOList : " + studentVOList);
		
		model.addAttribute("studentVOList" , studentVOList);
		model.addAttribute("allCount" , allCount);
		//forwarding
		return "stdcheck/stdchk";
	}
	
	//요청URI : /stdcheck/stdDetail?stNo=A002
	//요청파라미터 :  stNo=A002
	//요청방식 : get
	//정보 조회 
	
	// 교수 - 학생 상세 정보 확인 페이지 
	@GetMapping("/stdDetail")
	public String stdDetail(StudentVO studentVO, Model model) {
		// studentVO.stNo = 학번
		//studentVO >>>>>>> StudentVO(stNo=A002, stGender=null, stPostno=0, stAddr=null, stAddrDet=null, stAcount=null, stBank=null, militaryService=null, stEmail=null, proChaNo=null, admissionDate=null, stGradDate=null, deptCode=null, stGrade=0, userInfoVO=null, comDetCodeVO=null, stuAttachFileVO=null)
		log.info("학번 : studentVO >>>>>>> " + studentVO);
		
		studentVO = this.studentCheckService.stdDetail(studentVO);
		log.info("학번 : studentVO(후) >>>>>>> " + studentVO);
		
		model.addAttribute("studentVO" , studentVO);
		
		//forwarding
		return "stdcheck/stdDetail";
	}
	
	// 교수 - 정렬조건 [이름순 , 학년순] 서순 학생 정보 출력 
	@ResponseBody
	@PostMapping("/listAjax")
	public List<StudentVO> listAjax(@RequestBody Map<String, Object> map){
		log.info("listAjax >>> " + map);
		map.put("userNo", userNo);
		
		List<StudentVO> searchList = this.studentCheckService.searchList(map);
		log.info("listAjax searchList >>>>>>> " + searchList);
		return searchList;
	}
	
	
	
	/**
	 * 학과 학생 조회
	 * @author 송유진
	 * @return
	 */
	@GetMapping("/stuTotalList")
	public ModelAndView stuTotalList(ModelAndView mav, 
			Authentication auth,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		
		//교수 번호
		String proNo = auth.getName();

		//학과 코드
		String deptCode = studentCheckService.stuDeptCode(proNo);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("deptCode", deptCode);
		
		log.info("stuTotalList -> map : {}", map);
		
		//학과 코드에 맞는 학생 전체 행수
		int total = studentCheckService.stuGetTotal(map);
		log.info("stuTotalList -> total : {}", total);
		
		//학과 코드에 맞는 학생 출력
		List<StudentVO> stuTotalList = studentCheckService.stuTotalList(map);
		log.info("stuTotalList : {}", stuTotalList);
		
		mav.addObject("articlePage", new ArticlePage<StudentVO>(total, currentPage, 10, stuTotalList, keyword, queGubun));
		mav.setViewName("student/stuTotalList");
		
		return mav;
	}
	
	/**
	 * 학과 학생 조회 Ajax
	 * @author 송유진
	 * @return
	 */
	@ResponseBody
	@PostMapping("/stuTotalListAjax")
	public ArticlePage<StudentVO> stuTotalListAjax(@RequestBody Map<String,Object> map, Authentication auth) {
		
		//교수 번호
		String proNo = auth.getName();
		
		//학과 코드
		String deptCode = studentCheckService.stuDeptCode(proNo);
		
		map.put("deptCode", deptCode);
		log.info("stuTotalList -> map : {}", map);
		
		//학과 코드에 맞는 학생 전체 행수
		int total = studentCheckService.stuGetTotal(map);
		log.info("stuTotalList -> total : {}", total);
		
		//학과 코드에 맞는 학생 출력
		List<StudentVO> stuTotalList = studentCheckService.stuTotalList(map);
		log.info("stuTotalList : {}", stuTotalList);
		
		return new ArticlePage<StudentVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, stuTotalList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	/**
	 * 학과 학생 상세 조회
	 * @author 송유진
	 * @return
	 */
	@ResponseBody
	@GetMapping("/stuTotalDetail")
	public ModelAndView stuTotalDetail(ModelAndView mav, 
				@RequestParam("stNo") String stNo) {
		log.info("stuTotalDetail -> stNo : {}", stNo);
		
		//학과 학생 상세 조회 재학/휴학/자퇴 여부
		String stStat = studentCheckService.stuStat(stNo);
		log.info("stStat >> {}", stStat);
		
		//학과 학생 상세 조회
		StudentVO stuTotalDetail = studentCheckService.stuTotalDetail(stNo);
		log.info("stuTotalDetail : ", stuTotalDetail);
		
		mav.addObject("stStat", stStat);
		mav.addObject("stuTotalDetail", stuTotalDetail);
		
		mav.setViewName("student/stuTotalDetail");
		
		return mav;
	}
	
	/**
	 * 휴학 신청 목록
	 * @author 송유진
	 * @return
	 */
	@GetMapping("/leaveOfAbsList")
	public String leaveOfAbsList() {
		return "student/leaveOfAbsList";
	}
	
	/**
	 * 복학 신청 목록
	 * @author 송유진
	 * @return
	 */
	@GetMapping("/leaveOfCbaList")
	public String leaveOfCbaList() {
		return "student/leaveOfCbaList";
	}
	
	/**
	 * 자퇴 신청 목록
	 * @author 송유진
	 * @return
	 */
	@GetMapping("/leaveOfDouList")
	public String leaveOfDouList() {
		return "student/leaveOfDouList";
	}
}
	
	

