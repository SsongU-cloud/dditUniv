package kr.or.ddit.controller;

import java.security.Principal;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.CommonNoticeService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.CommonNoticeVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author PC-31
 * 교수, 학생, 관리자 공지사항
 */

@Slf4j
@RequestMapping("/commonNotice")
@Controller
public class CommonNoticeController {
	
	@Autowired
	CommonNoticeService commonNoticeService;
	
	@Autowired
	UploadUtils  uploadUtils;
	
	
	//학생 공지사항
	@GetMapping("/listStu")    
	public ModelAndView listStu(ModelAndView mav,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue = "") String keyword, 
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun) {
		log.info("listStu에 왔다");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		//행의 수
		int total = this.commonNoticeService.getTotal(map);
		log.info("listStu->total: " + total);
		
		List<CommonNoticeVO> commonNoticeVOList = this.commonNoticeService.list(map);
		log.info("listStu->commonNoticeVO: " + commonNoticeVOList);
		
		mav.addObject("articlePage", new ArticlePage<CommonNoticeVO>(total, currentPage, 10, commonNoticeVOList, keyword, queGubun));
		
		//jsp
		mav.setViewName("commonNotice/listStu");
		
		return mav;
	}
	
	
	//교수 공지사항 목록
	@GetMapping("/list")
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
		
		//행의 수
		int total = this.commonNoticeService.getTotal(map);
		log.info("list->total: " + total);
		
		List<CommonNoticeVO> commonNoticeVOList = this.commonNoticeService.list(map);
		log.info("list->commonNoticeVO: " + commonNoticeVOList);
		
		mav.addObject("articlePage", new ArticlePage<CommonNoticeVO>(total, currentPage, 10, commonNoticeVOList, keyword, queGubun));
		
		//jsp
		mav.setViewName("commonNotice/list");
		
		return mav;
	}
	

	//관리자 공지사항 목록
	@GetMapping("/listAdm")
	public ModelAndView listAdm(ModelAndView mav,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue = "") String keyword, 
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun) {
		log.info("listAdm에 왔다");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		//행의 수
		int total = this.commonNoticeService.getTotal(map);
		log.info("listAdm->total: " + total);
		
		List<CommonNoticeVO> commonNoticeVOList = this.commonNoticeService.list(map);
		log.info("listAdm->commonNoticeVO: " + commonNoticeVOList);
		
		mav.addObject("articlePage", new ArticlePage<CommonNoticeVO>(total, currentPage, 10, commonNoticeVOList, keyword, queGubun));
		
		//jsp
		mav.setViewName("commonNotice/listAdm");
		
		return mav;
	}
		
		
	//목록아작
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<CommonNoticeVO> commonNoticeListAjax(@RequestBody Map<String,Object> map) {
		log.info("listAjax 페이지");
		log.info("list->map : " + map);
		
		//전체 행수
		int total = this.commonNoticeService.getTotal(map);
		log.info("listAjax->total : " + total);
		
		//목록
		List<CommonNoticeVO> commonNoticeVOList = this.commonNoticeService.list(map);
		log.info("commonNoticeVOList : " + commonNoticeVOList);
		
		return new ArticlePage<CommonNoticeVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, commonNoticeVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	
	//교수 등록 get
	@GetMapping(value="/create")
	public String create(Principal principal) {
		if(principal == null) {
			return "redirect:/login";
		}
		
		//forwarding
		return "commonNotice/create";
	}
	
	
	//교수 등록
	@PostMapping("/createPost")
	public String createPost(CommonNoticeVO commonNoticeVO) {
		
		log.info("createPost->commonNoticeVO : " + commonNoticeVO);
		
		int result = this.commonNoticeService.createPost(commonNoticeVO);
		log.info("createPost->result : " + result);
		
		return "redirect:/commonNotice/list?menuId=annNotIce";
	}
	
	
	//관리자 등록get
	@GetMapping(value="/createAdm")
	public String createAdm(Principal principal) {
		if(principal == null) {
			return "redirect:/login";
		}
		
		//forwarding
		return "commonNotice/createAdm";
	}
	
	//관리자 등록
	@PostMapping("/createAdm")
	public String createAdm(CommonNoticeVO commonNoticeVO) {
		
		log.info("createAdm->commonNoticeVO : " + commonNoticeVO);
		
		int result = this.commonNoticeService.createAdm(commonNoticeVO);
		log.info("createAdm->result : " + result);
		
		return "redirect:/commonNotice/listAdm?menuId=manNotIce";
	}
	
	
	//교수 게시판 수정get
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView update(@RequestParam String comNotNo, ModelAndView mav) {
		log.info("update");
		log.info("comNotNo : " + comNotNo);
		
		CommonNoticeVO commonNoticeVO = this.commonNoticeService.detail(comNotNo);
		log.info("update->commonNoticeVO : " + commonNoticeVO);
		
		mav.addObject("commonNoticeVO",commonNoticeVO);
		
		mav.setViewName("commonNotice/update");
		
		return mav;
	}
	
	
	//교수 게시판 수정post
	@RequestMapping(value="/updatePost", method=RequestMethod.POST)
	public String updatePost(@RequestParam String comNotNo, CommonNoticeVO commonNoticeVO, Model model) {
		log.info("updatePost->commonNoticeVO : " + commonNoticeVO);
		
        // insert, update, delete를 쓰는 맵퍼, 서비스는 기본적으로 return 타입을 int로 해야 함!			
		commonNoticeService.updatePost(commonNoticeVO);		
		model.addAttribute("comNotNo",commonNoticeVO.getComNotNo());
		model.addAttribute("comNo",commonNoticeVO.getComNotNo());
		log.info("model : " + model);
		
		return "redirect:/commonNotice/detail?menuId=annNotIce";
	}
	
	
	//관리자 게시판 수정get
	@RequestMapping(value = "/updateAdm", method = RequestMethod.GET)
	public ModelAndView updateAdm(@RequestParam String comNotNo, ModelAndView mav) {
		log.info("updateAdm");
		log.info("comNotNo : " + comNotNo);
		
		CommonNoticeVO commonNoticeVO = this.commonNoticeService.detail(comNotNo);
		log.info("updateAdm->commonNoticeVO : " + commonNoticeVO);
		
		mav.addObject("commonNoticeVO",commonNoticeVO);
		
		mav.setViewName("commonNotice/updateAdm");
		
		return mav;
	}
	
	
	//관리자 게시판 수정post
	@RequestMapping(value="/updateAdm", method=RequestMethod.POST)
	public String updateAdm(@RequestParam String comNotNo, CommonNoticeVO commonNoticeVO, Model model) {
		log.info("updateAdm->commonNoticeVO : " + commonNoticeVO);
		
        // insert, update, delete를 쓰는 맵퍼, 서비스는 기본적으로 return 타입을 int로 해야 함!			
		commonNoticeService.updateAdm(commonNoticeVO);		
		model.addAttribute("comNotNo",commonNoticeVO.getComNotNo());
		model.addAttribute("comNo",commonNoticeVO.getComNotNo());
		log.info("model : " + model);
		
		return "redirect:/commonNotice/detailAdm?menuId=manNotIce";
	}
	
	
	//삭제
	@ResponseBody
	@PostMapping("/deleteAjax")
	public int deleteAjax(@RequestBody CommonNoticeVO commonNoticeVO) {
		log.info("deleteAjax->commonNoticeVO: " + commonNoticeVO);
		
		int result = commonNoticeService.deleteAjax(commonNoticeVO);
		
		return result;
		
	}
	
	
	//학생 상세 보기 페이지
	@GetMapping("/detailStu")
	public String detailStu(@RequestParam("comNotNo") String comNotNo, Model model) {
		//detail->comNotNo : 110
		log.info("detailStu->comNotNo : " + comNotNo);
		
	    // 조회수 업데이트
	    commonNoticeService.ViewCnt(comNotNo);
	    
	    // 공지사항 상세 정보 가져오기
	    CommonNoticeVO commonNoticeVO = this.commonNoticeService.detailStu(comNotNo);
	    log.info("detailStu->commonNoticeVO : " + commonNoticeVO);
	    
	    // Model에 데이터를 담아서 뷰로 전달
	    model.addAttribute("commonNoticeVO", commonNoticeVO);
	    model.addAttribute("detailStu", commonNoticeService.detailStu(commonNoticeVO.getComNotNo()));
	    
	    //일반공지첨부파일ID
	    String comAttFileId = commonNoticeVO.getComNotNo();
	    
	    // 첨부파일
	    List<Map<String, Object>> fileList = commonNoticeService.selectFileList(commonNoticeVO.getComNotNo());
	    log.debug("fileList {}", fileList);
	    
		model.addAttribute("fileList", fileList);
		log.info("detailStu->fileList : " + fileList);
	    
	    // 상세 페이지의 뷰 이름 반환
	    return "commonNotice/detailStu";
	}
	
	
	//교수 상세 보기 페이지
	@GetMapping("/detail")
	public String detail(@RequestParam("comNotNo") String comNotNo, Model model, Authentication auth) {
		//detail->comNotNo : 110
		log.info("detail->comNotNo : " + comNotNo);
		
	    // 조회수 업데이트
	    commonNoticeService.ViewCnt(comNotNo);
	    
	    // 공지사항 상세 정보 가져오기
	    CommonNoticeVO commonNoticeVO = this.commonNoticeService.detail(comNotNo);
	    
	    log.info("detail->commonNoticeVO : " + commonNoticeVO);
	    
		// 로그인한 사용자 정보 가져오기
		String stNo = auth.getName();
		log.info("stNo->" + stNo);
	    
	    // Model에 데이터를 담아서 뷰로 전달
	    model.addAttribute("commonNoticeVO", commonNoticeVO);
	    model.addAttribute("detail", commonNoticeService.detail(commonNoticeVO.getComNotNo()));
	    model.addAttribute("stNo", stNo);
	    
	    //일반공지첨부파일ID
	    String comAttFileId = commonNoticeVO.getComNotNo();
	    
	    // 첨부파일
	    List<Map<String, Object>> fileList = commonNoticeService.selectFileList(commonNoticeVO.getComNotNo());
	    log.debug("fileList {}", fileList);
	    
		model.addAttribute("fileList", fileList);
		log.info("detail->fileList : " + fileList);
	    
	    // 상세 페이지의 뷰 이름 반환
	    return "commonNotice/detail";
	}
		
	
	//관리자 상세 보기 페이지
	@GetMapping("/detailAdm")
	public String detailAdm(@RequestParam("comNotNo") String comNotNo, Model model, Authentication auth) {
		//detail->comNotNo : 110
		log.info("detailAdm->comNotNo : " + comNotNo);
		
	    // 조회수 업데이트
	    commonNoticeService.ViewCnt(comNotNo);
	    
	    // 공지사항 상세 정보 가져오기
	    CommonNoticeVO commonNoticeVO = this.commonNoticeService.detailAdm(comNotNo);
	    log.info("detailAdm->commonNoticeVO : " + commonNoticeVO);
	    
	    // 로그인한 사용자 정보 가져오기
	    String stNo = auth.getName();
	    log.info("stNo->" + stNo);
	    
	    // Model에 데이터를 담아서 뷰로 전달
	    model.addAttribute("commonNoticeVO", commonNoticeVO);
	    model.addAttribute("detailAdm", commonNoticeService.detailAdm(commonNoticeVO.getComNotNo()));
	    model.addAttribute("stNo", stNo);
	    
	    //일반공지첨부파일ID
	    String comAttFileId = commonNoticeVO.getComNotNo();
	    
	    // 첨부파일
	    List<Map<String, Object>> fileList = commonNoticeService.selectFileList(commonNoticeVO.getComNotNo());
	    log.debug("fileList {}", fileList);
	    
		model.addAttribute("fileList", fileList);
		log.info("detailAdm->fileList : " + fileList);
	    
	    // 상세 페이지의 뷰 이름 반환
	    return "commonNotice/detailAdm";
	}

	

}
