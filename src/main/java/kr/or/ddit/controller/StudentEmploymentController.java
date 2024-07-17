package kr.or.ddit.controller;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.executor.ReuseExecutor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.service.StudentEmploymentService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.CertificateVO;
import kr.or.ddit.vo.ComAttachDetVO;
import kr.or.ddit.vo.QuestionVO;
import kr.or.ddit.vo.RecruitmentVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

@Controller
@Slf4j
@RequestMapping("/employment")
public class StudentEmploymentController {
	private String userNo = "";
	@Autowired
	StudentEmploymentService studentEmploymentService;
	
	@GetMapping("/volunteer")
	public ModelAndView volunteer(ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("봉사활동 내역 목록 조회");
		log.info("list->keyword : " + keyword);
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo:"+stNo);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("stNo", stNo);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		int total =this.studentEmploymentService.getTotal(map);
		log.info("list > total:" +total);
		
		//목록
		List<VolunteerVO> vVOList = this.studentEmploymentService.volunteerList(map);
		log.info("vVOList:"+vVOList);
		mav.addObject("articlePage", new ArticlePage<VolunteerVO>(total, currentPage, 10, vVOList, keyword, queGubun));
		
		//봉사 총 시간
		int volTotalTime=studentEmploymentService.volTotalTime(stNo);
		log.debug("volTotalTime{}",volTotalTime);
		mav.addObject("volTotalTime", volTotalTime);
		
		mav.setViewName("employment/volunteer");
		return mav;
	}
	
	@ResponseBody
	@PostMapping("/volunteerAjax")
	public ArticlePage<VolunteerVO> volunteerAjax(@RequestBody Map<String, Object> map) {
		log.info("ajax!");
		log.info("map>"+map);
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		int total =this.studentEmploymentService.getTotal(map);
		log.info("total>>"+total);
		
		//목록
		List<VolunteerVO> vVOList = this.studentEmploymentService.volunteerList(map);
		log.info("vVOList:"+vVOList);
		return new ArticlePage<VolunteerVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, vVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	@GetMapping("/volAdd")
	public String volAdd() {
		log.info("봉사활동 등록");
		return "employment/volAdd";
	}
	@ResponseBody
	@PostMapping("/volAddAjax")
	public String volAddAjax(VolunteerVO volunteerVO) {
		log.info("volAddAjax>volunteerVO>>"+volunteerVO);
		int result = this.studentEmploymentService.volAddAjax(volunteerVO);
		log.info("volAddAjax rslt"+result);
		return "result";
	}
	@GetMapping("/volDetail")
	public String volDetail(Model model
			,Map<String, Object> map
			,VolunteerVO volunteerVO
			,@RequestParam(value="volNo")String volNo) {
		log.info("봉사활동 내역상세 조회");
		map.put("volNo", volNo);
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		
		/*
		{volunteerVO=VolunteerVO(volNo=29, stNo=null, volPlace=null, volStart=null, volEnd=null, volTime=0
		, volCon=null, vonFileStr=null, vonFile=null, comAttachFileVO=null, comAttachDetVO=null)
		, org.springframework.validation.BindingResult.volunteerVO=org.springframework.validation.BeanPropertyBindingResult: 0 errors
		, volNo=29, stNo=1651004}
		 */
		log.info("map>"+map);
		
		volunteerVO = this.studentEmploymentService.volDetail(map);
		log.info("volunteerVO :{}",volunteerVO);
		model.addAttribute("volunteerVO",volunteerVO);
		return "employment/volDetail";
	}
	@ResponseBody
	@PostMapping("/volDetailAjax")
	public int volDetailAjax(VolunteerVO volunteerVO) {
		log.info("봉사활동  ajax");
//		volunteerVO.setVolNo(volNo);`
		log.info("ajax>volunteerVO:{}",volunteerVO);
		
		int result = studentEmploymentService.volDetailAjax(volunteerVO);
		return result;
	}
	@GetMapping("/volunteerVO")
	public String volUpdate() {
		log.info("봉사활동 내역상세 조회");
		
		return "employment/volDetail";
	}
	
	/**
	 * 학생권한 채용정보 list
	 * @author 이수빈
	 * @param mav
	 * @param map
	 * @param currentPage
	 * @param keyword
	 * @param queGubun
	 * @return
	 */
	@GetMapping("/recruitment")
	public ModelAndView recruitment(ModelAndView mav,
			 Map<String, Object> map,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("채용정보목록");
		log.info("list->keyword : " + keyword);
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo:"+stNo);
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("stNo", stNo);
		
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		int recruitmentTotal =this.studentEmploymentService.recruitmentTotal(map);
		log.info("list > total:" +recruitmentTotal);
		
		List<RecruitmentVO> recruitmentVOList = this.studentEmploymentService.recruitmentVOList(map);
		log.info("recruitmentVOList:"+recruitmentVOList);
		mav.addObject("articlePage", new ArticlePage<RecruitmentVO>(recruitmentTotal, currentPage, 10, recruitmentVOList, keyword, queGubun));
		mav.setViewName("employment/recruitment");
		return mav;
	}
	/**
	 * 관리자권한 채용정보 list
	 * @param mav
	 * @param map
	 * @param currentPage
	 * @param keyword
	 * @param queGubun
	 * @return
	 */
	@GetMapping("/recruitmentAdmin")
	public ModelAndView recruitmentAdmin(ModelAndView mav,
			Map<String, Object> map,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("채용정보목록");
		log.info("list->keyword : " + keyword);
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo:"+stNo);
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("stNo", stNo);
		
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		int recruitmentTotal =this.studentEmploymentService.recruitmentTotal(map);
		log.info("list > total:" +recruitmentTotal);
		
		List<RecruitmentVO> recruitmentVOList = this.studentEmploymentService.recruitmentVOList(map);
		log.info("recruitmentVOList:"+recruitmentVOList);
		mav.addObject("articlePage", new ArticlePage<RecruitmentVO>(recruitmentTotal, currentPage, 10, recruitmentVOList, keyword, queGubun));
		mav.setViewName("employment/recruitmentAdmin");
		return mav;
	}
	@ResponseBody
	@PostMapping("/recruitmentAjax")
	public ArticlePage<RecruitmentVO> recruitmentAjax(@RequestBody Map<String, Object> map) {
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		int recruitmentTotal =this.studentEmploymentService.recruitmentTotal(map);
		
		List<RecruitmentVO> recruitmentVOList = this.studentEmploymentService.recruitmentVOList(map);
		log.info("recruitmentVOList:"+recruitmentVOList);
		
		return new ArticlePage<RecruitmentVO>(recruitmentTotal, Integer.parseInt(map.get("currentPage").toString()), 10, recruitmentVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	/**
	 * 채용정보 작성 화면
	 * @author 이수빈
	 * @return
	 */
	@GetMapping("/reCreate")
	public String reCreate(Model model) {
		log.info("채용정보 작성");
		this.userNo=SecurityContextHolder.getContext().getAuthentication().getName();
		String adminName = this.studentEmploymentService.adminName(userNo);
		
		model.addAttribute("adminName", adminName);
		return "employment/recCreate";
	}
	/**
	 * 관리자권한 채용정보 작성 화면
	 * @author 이수빈
	 * @return
	 */
	@GetMapping("/recCreateAdmin")
	public String reCreateAdmin(Model model) {
		log.info("채용정보 작성");
		this.userNo=SecurityContextHolder.getContext().getAuthentication().getName();
		String adminName = this.studentEmploymentService.adminName(userNo);
		
		model.addAttribute("adminName", adminName);
		return "employment/recCreateAdmin";
	}
	
	/**
	 * @author 이수빈
	 * @param map 제목, 내용, 첨부파일 유무
	 * @return
	 */
	@ResponseBody
	@PostMapping("/reCreateAjax")
	public int reCreateAjax(RecruitmentVO recruitmentVO) {
		log.info("reCreateAjax recruitmentVO >{}",recruitmentVO);
		int result = 0;
		result += this.studentEmploymentService.reCreateAjax(recruitmentVO);
		return result;
	}
	/**
	 * 채용정보 detail
	 * @param model
	 * @param recruitmentVO
	 * @param map
	 * @param recDNo
	 * @return
	 * @throws JsonProcessingException 
	 */
	@GetMapping("/recDetail")
	public String recDetail(Model model
			,RecruitmentVO recruitmentVO
			,Map<String, Object> map
			,@RequestParam(value="recuNo")String recuNo) throws JsonProcessingException {
		log.info("채용정보상세 조회");
		log.info("recuNo>>{}",recuNo);
		map.put("recuNo", recuNo);
		recruitmentVO = this.studentEmploymentService.recDetail(map);
		log.info("recruitmentVO>>{}",recruitmentVO);
		//학번/사번
		
		ObjectMapper objMapper = new ObjectMapper();
		String jsonRecruimentVOList = objMapper.writeValueAsString(recruitmentVO);
		model.addAttribute("jsonRecruimentVOList",jsonRecruimentVOList);
		model.addAttribute("recruitmentVO", recruitmentVO);
		
		int viewCnt = this.studentEmploymentService.viewCnt(map);
		log.info("viewCnt>> {}",viewCnt);
		
//		model.addAttribute("recruitmentVO",recruitmentVO);
		return "employment/recDetail";
	}
	/**
	 * 관리자권한 상세조회
	 * @param model
	 * @param recruitmentVO
	 * @param map
	 * @param recuNo
	 * @return
	 * @throws JsonProcessingException
	 */
	@GetMapping("/recDetailAdmin")
	public String recDetailAdmin(Model model
			,RecruitmentVO recruitmentVO
			,Map<String, Object> map
			,@RequestParam(value="recuNo")String recuNo) throws JsonProcessingException {
		log.info("채용정보상세 조회");
		log.info("recuNo>>{}",recuNo);
		map.put("recuNo", recuNo);
		recruitmentVO = this.studentEmploymentService.recDetail(map);
		log.info("recruitmentVO>>{}",recruitmentVO);
		//학번/사번
		
		ObjectMapper objMapper = new ObjectMapper();
		String jsonRecruimentVOList = objMapper.writeValueAsString(recruitmentVO);
		model.addAttribute("jsonRecruimentVOList",jsonRecruimentVOList);
		model.addAttribute("recruitmentVO", recruitmentVO);
		
		int viewCnt = this.studentEmploymentService.viewCnt(map);
		log.info("viewCnt>> {}",viewCnt);
		
//		model.addAttribute("recruitmentVO",recruitmentVO);
		return "employment/recDetailAdmin";
	}
	@ResponseBody
	@PostMapping("/recDetailAjax")
	public RecruitmentVO recDetailAjax(@RequestBody Map<String, Object> map
			,RecruitmentVO recruitmentVO) {
		log.info("recDetailAjax map >>"+map);
		recruitmentVO = this.studentEmploymentService.recDetail(map);
		log.info("recruitmentVO>>{}",recruitmentVO);
		return recruitmentVO;
	}
	/**
	 * 채용정보 상세게시판 삭제
	 * @param map
	 * @return
	 */
	@ResponseBody
	@PostMapping("/recrDeleteAjax")
	public int recrDeleteAjax(@RequestBody Map<String, Object> map) {
		int result =0;
		result += this.studentEmploymentService.recrDeleteAjax(map);
		log.info("recrDeleteAjax>>{}",result);
		return result;
	}
	@ResponseBody
	@PostMapping("/recrUpdateFileDelete")
	public int recrUpdateFileDelete(@RequestBody Map<String, Object> map) {
		int result = 0;
		log.info("map recrUpdateFileDelete>>>{}",map);
		result+=this.studentEmploymentService.recrUpdateFileDelete(map);
		return result;
	}
	
	/**
	 * 채용정보수정
	 * @param recruitmentVO
	 * @param sbFiles
	 * @return
	 */
	@ResponseBody
	@PostMapping("/recrUpdateAjax")
	public int recrUpdateAjax(@RequestPart("recruitmentVO") RecruitmentVO recruitmentVO
			,MultipartFile[] sbFiles) {
		int result = 0;
		log.info("sbFiles{}",sbFiles);
		log.info("map>>>{}",recruitmentVO);
		result+= this.studentEmploymentService.recrUpdateAjax(recruitmentVO,sbFiles);
		return result;
	}
	/**
	 * 자격증 목록
	 * @author 이수빈
	 * @param model
	 * @param map
	 * @param currentPage
	 * @param keyword
	 * @param queGubun
	 * @return
	 */
	@GetMapping("/certificate")
	public String certificate(
			Model model,
			 Map<String, Object> map,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("자격증 목록");
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("stNo", stNo);
		
		int certificateCount = this.studentEmploymentService.certificateCount(stNo);
		model.addAttribute("certificateCount", certificateCount);
		int certificateTotal =this.studentEmploymentService.certificateTotal(map);
		log.info("list > total:" +certificateTotal);
		
		//목록
		List<CertificateVO> certificateVOList = this.studentEmploymentService.certificateVOList(map);
		log.info("certificateVOList:"+certificateVOList);
		
		model.addAttribute("articlePage", new ArticlePage<CertificateVO>(certificateTotal, currentPage, 10, certificateVOList, keyword, queGubun));
		return "employment/certificate";
	}
	@ResponseBody
	@PostMapping("/certificateAjax")
	public ArticlePage<CertificateVO> certificateAjax(@RequestBody Map<String, Object> map) {
		log.info("ajax!");
		log.info("map>"+map);
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		int certificateTotal =this.studentEmploymentService.certificateTotal(map);
		log.info("certificateTotal>>"+certificateTotal);
		
		//목록
		List<CertificateVO> certificateVOList = this.studentEmploymentService.certificateVOList(map);
		log.info("certificateVOList:"+certificateVOList);
		return new ArticlePage<CertificateVO>(certificateTotal, Integer.parseInt(map.get("currentPage").toString()), 10, certificateVOList, map.get("keyword").toString(), map.get("queGubun").toString());		
	}
	@ResponseBody
	@PostMapping("/cerValidation")
	public int cerValidation(@RequestBody CertificateVO certificateVO) {
		log.info("자격증 등록 전 유효성검사>"+certificateVO);
		int result = 0;
		result+= this.studentEmploymentService.cerValidation(certificateVO);
		return result;
	}
	
	@ResponseBody
	@PostMapping("/cerCreateAjax")
	public int cerCreateAjax(@RequestBody CertificateVO certificateVO) {
		log.info("certificateVO>>{}",certificateVO);
		int result = this.studentEmploymentService.cerCreateAjax(certificateVO);
		return result;
	}
	@ResponseBody
	@PostMapping("/cerDeleteAjax")
	public ArticlePage<CertificateVO> cerDeleteAjax(@RequestBody Map<String, Object> map) {
		log.info("delete");
		log.info("map>>"+map);
		int result = this.studentEmploymentService.cerDeleteAjax(map);
		log.info("result"+result);
		int certificateTotal =this.studentEmploymentService.certificateTotal(map);
		log.info("certificateTotal>>"+certificateTotal);
		
		//목록
		List<CertificateVO> certificateVOList = this.studentEmploymentService.certificateVOList(map);
		log.info("certificateVOList:"+certificateVOList);
		return new ArticlePage<CertificateVO>(certificateTotal, Integer.parseInt(map.get("currentPage").toString()), 10, certificateVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	@ResponseBody
	@PostMapping("/cerUpdateAjax")
	public ArticlePage<CertificateVO> cerUpdateAjax(@RequestBody Map<String, Object> map) {
		log.info("cerUpdateAjax>>"+map);
		int result =this.studentEmploymentService.cerUpdateAjax(map);
		log.info("result"+result);
		int certificateTotal =this.studentEmploymentService.certificateTotal(map);
		log.info("certificateTotal>>"+certificateTotal);
		
		//목록
		List<CertificateVO> certificateVOList = this.studentEmploymentService.certificateVOList(map);
		log.info("certificateVOList:"+certificateVOList);
		return new ArticlePage<CertificateVO>(certificateTotal, Integer.parseInt(map.get("currentPage").toString()), 10, certificateVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
}
