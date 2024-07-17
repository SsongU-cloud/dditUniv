package kr.or.ddit.controller;



import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.mapper.ProCheckMapper;
import kr.or.ddit.service.AdminStudentService;
import kr.or.ddit.service.ProCheckService;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;
import lombok.extern.slf4j.Slf4j;


/**
 *
 * @author PC-06
 *  관리자  > 교수 / 교직원 > 교수정보조회  or 교수정보 추가
 *
 */

@Controller
@Slf4j
@RequestMapping("/manager")
public class ManagerProController {

	@Autowired
	AdminStudentService adminStudentService;

	@Autowired
	ProCheckService proCheckService;

	 @Autowired
	 String uploadFolder;

	 @Autowired
	 String uploadPath;

	 @Autowired
	 ProCheckMapper proCheckMapper;



	/*
	 * // 신입생 추가
	 *
	 * @GetMapping("/profAdd") public String stdAdd(Map<String, Object> map, Model
	 * model) { log.info("교수 추가 페이지"); List<ComDetCodeVO> deptList =
	 * this.adminStudentService.deptList(); log.info("deptList >>>> " + deptList);
	 * model.addAttribute("deptList", deptList);
	 *
	 * return "manager/profAdd"; }
	 */


	// 관리자 - 교수 추가 페이지
	@RequestMapping(value="/profAdd",method=RequestMethod.GET)
	public ModelAndView profAdd(ProfessorVO professorVO) {
		ModelAndView mav = new ModelAndView();
		log.info("교수 추가 페이지");

		List<ComDetCodeVO> deptList = this.adminStudentService.deptList();
		log.info("deptList >>>> " + deptList);

		mav.addObject("title","교수정보 등록 ");
		mav.addObject("deptList",deptList);

		mav.setViewName("manager/profAdd");

		return mav;
	}


	// 관리자 - 교수 추가 AJAX

	@ResponseBody
	@PostMapping("/profAddAjax")
	public String profAddAjax(@ModelAttribute ProfessorVO professorVO){
		log.debug("proAddAjax  -> professorVO {}",professorVO);
		log.debug("proAddAjax  -> uploadFile",professorVO.getUploadFile());
		professorVO.setComAttMId(professorVO.getUploadFile().getOriginalFilename());

		//교수 추가
		int result = proCheckService.profAddAjax(professorVO);
		log.debug("proAddAjax -> result : {}" , result);

		return "SUCCESS";
		

  }


	// 관리자 - 교수 리스트 첫 페이지 출력
	@GetMapping("/profList")
	public String proList(Model model) {
		log.info("proList로 접속");

		List<ComDetCodeVO> deptList = this.adminStudentService.deptList();
		log.info("deptList >>>> " + deptList);

		model.addAttribute("deptList", deptList);

		return "manager/profList";
	}


	// 관리자 - 교수 리스트 조회 페이지 [학과 선택시 해당 과 교수로 넘어감]
	@ResponseBody
	@PostMapping("/listAjaxs")
	public List<ProfessorVO> listAjaxs(@RequestBody Map<String, Object> map) {
		log.info("merong >>> {}", map);

		List<ProfessorVO> searchList = this.proCheckService.searchList(map);
		log.info("listAjaxs searchList >>>>>>> " + searchList);

		return searchList;
	}


	// 관리자 - 교수 상세 정보 [교수 클릭시 나오는 화면]
	@GetMapping("/profDetail")
	public String profDetail(ProfessorVO professorVO, Model model) {
		// studentVO.stNo = 학번
		// studentVO >>>>>>> StudentVO(stNo=A002, stGender=null, stPostno=0,
		// stAddr=null, stAddrDet=null, stAcount=null, stBank=null,
		// militaryService=null, stEmail=null, proChaNo=null, admissionDate=null,
		// stGradDate=null, deptCode=null, stGrade=0, userInfoVO=null,
		// comDetCodeVO=null, stuAttachFileVO=null)
		log.info("학번 : professorVO >>>>>>> {}", professorVO);

		professorVO = this.proCheckService.profDetail(professorVO);
		log.info("학번 : professorVO(후) >>>>>>> {}", professorVO);
		log.info("학번 : professorVO(후) >>>>>>> {}", professorVO.getEmpDate());
		log.info("학번 : professorVO(후) >>>>>>> {}", professorVO.getComAttachDetVO());

		model.addAttribute("professorVO", professorVO);

	// forwarding
		return "manager/profDetail";
	}
	//교수 정보 수정 
	@ResponseBody
	@PostMapping(value="/updateProfAjax")
	public int updateProfAjax(ProfessorVO professorVO, Principal principal) {
		/*
		ProfessorVO(proNo=null, proAddr=10, empDate=5, salary=8, deptCode=null, proStudy=4
		, proAddrDet=11, proPostno=9, proWorkYn=null, proRetireDate=6, proPosition=2, comAttMId=null
		, proEmail=7, proTel=3, userInfoVO=null, comCodeVO=null, comDetCodeVO=null, comAttachDetVO=null
		, comAttachFileVO=null, UploadFile=null)
		 */
		log.info("updateProfAjax -> ProfessorVO : " + professorVO);
		
		int result = 0;
		
		result = this.proCheckService.updateProfPost(professorVO);
		log.info("updateProfAjax -> result : " + result);

		return result; 
	}
}
