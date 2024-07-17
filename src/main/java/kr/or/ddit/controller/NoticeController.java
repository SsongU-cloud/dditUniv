package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.NoticeService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.CommonNoticeVO;
import kr.or.ddit.vo.QuestionVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-10
 * 문의 사항 페이지
 */
@RequestMapping("/notice") 
@Slf4j
@Controller
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;

	
	//목록
	@GetMapping("/list")
	public ModelAndView noticeList(ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("문의사항 조회 페이지");
		log.info("list->keyword : " + keyword);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		//전체 행수
		int total = this.noticeService.getTotal(map);
		log.info("list->total : " + total);
		
		//목록
		List<QuestionVO> nVOList = this.noticeService.noticeList(map);
		log.info("nVOList : " + nVOList);
		
		mav.addObject("articlePage", new ArticlePage<QuestionVO>(total, currentPage, 10, nVOList, keyword, queGubun));
		
		//forwarding : jsp
		mav.setViewName("notice/list");
		
		return mav;
	}
	
	//페이징 처리나 검색의 경우 비동기를 위해 추가
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<QuestionVO> noticeListAjax(@RequestBody Map<String,Object> map) {
		log.info("listAjax 페이지");
		log.info("list->map : " + map);
		
		//전체 행수
		int total = this.noticeService.getTotal(map);
		log.info("listAjax->total : " + total);
		
		//목록
		List<QuestionVO> nVOList = this.noticeService.noticeList(map);
		log.info("nVOList : " + nVOList);
		
		return new ArticlePage<QuestionVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, nVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	//상세 화면
	@GetMapping("/detail")
	public ModelAndView noticeDetail(ModelAndView mav,
				@RequestParam("queNo") String queNo,
				Authentication auth
			) {
		log.info("detail->queNo : " + queNo);
		
		//상세 정보 가져오기
		QuestionVO questionVO = this.noticeService.noticeDetail(queNo);
		log.info("questionVO : " + questionVO);
		
		//로그인한 사용자 정보 가져오기
		String stNo = auth.getName();
		log.info("stNo : " + stNo);
		
		mav.addObject("questionVO", questionVO);
		mav.addObject("stNo", stNo);
		
		//답글 정보 가져오기
		QuestionVO answer = noticeService.ansContent(queNo);
		log.info("answer : {}", answer);
		mav.addObject("answer", answer);
		
		//첨부파일 ID
		String queAttFileId = questionVO.getQueNo();
		
		// 첨부파일
	    List<Map<String, Object>> fileList = noticeService.selectFileList(questionVO.getQueNo());
	    log.debug("fileList {}", fileList);
	    
	    mav.addObject("fileList", fileList);
		log.info("detail->fileList : " + fileList);
	    
		mav.setViewName("notice/detail");
		
	    // 상세 페이지의 뷰 이름 반환
	    return mav;
	}
	
	//문의사항 작성
	@GetMapping("/add")
	public String noticeAddGet() {
		log.info("noticeAddGet 페이지");
		
		return "notice/add";
	}
	
	//문의사항 작성 Post
	@PostMapping("/addPost")
	public String noticeAddPost(QuestionVO questionVO) {
		log.info("noticeAddPost->questionVO : " + questionVO);
	  
		//문의사항 작성
		int result = this.noticeService.noticeAddPost(questionVO);
		log.info("noticeAddPost->result : " + result);
		
		return "redirect:/notice/list?menuId=cybInqUir";
	}
	
	//문의사항 수정get
	@GetMapping("/update")
	public ModelAndView update(@RequestParam String queNo, ModelAndView mav) {
		log.info("update");
		log.info("queNo : " + queNo);
		
		QuestionVO questionVO = this.noticeService.noticeDetail(queNo);
		log.info("update->questionVO : " + questionVO);
		
		mav.addObject("questionVO",questionVO);
		
		mav.setViewName("notice/update");
		
		return mav;
	}
	
	
	//문의사항 수정post
	@PostMapping("/updatePost")
	public String updatePost(@RequestParam String queNo, QuestionVO questionVO, Model model) {
		log.info("updatePost->questionVO : " + questionVO);
		
        // insert, update, delete를 쓰는 맵퍼, 서비스는 기본적으로 return 타입을 int로 해야 함!			
		noticeService.updatePost(questionVO);		
		model.addAttribute("queNo",questionVO.getQueNo());
		model.addAttribute("queNoInsert",questionVO.getQueNo());
		
		log.info("mav : " + model);
		
		return "redirect:/notice/detail?menuId=cybInqUir";
	}
	
	//문의사항 삭제
	@ResponseBody
	@PostMapping("/deleteAjax")
	public int deleteAjax(@RequestBody Map<String,Object> map) {
		
		log.info("deleteAjax->queNo: " + map);
		
		String queNo = (String) map.get("queNo");
		log.info("queNo : {}", queNo);
		
		int result = noticeService.deleteAjax(queNo);
		
		return result;
	}
	
	
	
	//문의사항 관리자 목록
	@GetMapping("/listAdmin")
	public ModelAndView noticeListAdmin(ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("문의사항 조회 페이지");
		log.info("list->keyword : " + keyword);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		//전체 행수
		int total = this.noticeService.getTotal(map);
		log.info("list->total : " + total);
		
		//목록
		List<QuestionVO> nVOList = this.noticeService.noticeList(map);
		log.info("nVOList : " + nVOList);
		
		mav.addObject("articlePage", new ArticlePage<QuestionVO>(total, currentPage, 10, nVOList, keyword, queGubun));
		
		//forwarding : jsp
		mav.setViewName("notice/listAdmin");
		
		return mav;
	}
	
	//문의사항 관리자 페이징 처리나 검색의 경우 비동기를 위해 추가
	@ResponseBody
	@PostMapping("/listAdminAjax")
	public ArticlePage<QuestionVO> noticeListAdminAjax(@RequestBody Map<String,Object> map) {
		log.info("listAjax 페이지");
		log.info("list->map : " + map);
		
		//전체 행수
		int total = this.noticeService.getTotal(map);
		log.info("listAjax->total : " + total);
		
		//목록
		List<QuestionVO> nVOList = this.noticeService.noticeList(map);
		log.info("nVOList : " + nVOList);
		
		return new ArticlePage<QuestionVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, nVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	//문의사항 관리자 상세 화면
	@GetMapping("/detailAdmin")
	public ModelAndView noticeDetailAdmin(ModelAndView mav,
			@RequestParam("queNo") String queNo,
			Authentication auth
			) {
		log.info("detail->queNo : " + queNo);
		
		//상세 정보 가져오기
		QuestionVO questionVO = this.noticeService.noticeDetail(queNo);
		log.info("questionVO : " + questionVO);
		
		//로그인한 사용자 정보 가져오기
		String stNo = auth.getName();
		log.info("stNo : " + stNo);
		
		mav.addObject("questionVO", questionVO);
		mav.addObject("stNo", stNo);
		
		//답글 정보 가져오기
		QuestionVO answer = noticeService.ansContent(queNo);
		log.info("answer : {}", answer);
		mav.addObject("answer", answer);
		
		//첨부파일 ID
		String queAttFileId = questionVO.getQueNo();
		
		// 첨부파일
		List<Map<String, Object>> fileList = noticeService.selectFileList(questionVO.getQueNo());
		log.debug("fileList {}", fileList);
		
		mav.addObject("fileList", fileList);
		log.info("detail->fileList : " + fileList);
		
		mav.setViewName("notice/detailAdmin");
		
		// 상세 페이지의 뷰 이름 반환
		return mav;
	}
	
	//답글 작성
	@ResponseBody
	@PostMapping("/commentCreateAjax")
	public int commentCreateAjax(@RequestBody Map<String,Object> map, Authentication auth) {
		log.info("commentCreateAjax 페이지");
		
		String stNo = auth.getName(); //로그인 사람 사번
		map.put("stNo", stNo);
		
		log.info("map : {}", map);
		
		//답글 작성
		int answer = noticeService.commentCreateAjax(map);
		log.info("answer : {}", answer);
		
		//답글 완료 변경
		String queNo = (String)map.get("queNo");
		int queYn = noticeService.queYn(queNo);
		log.info("queYn : {}", queYn);
		
		int result = answer + queYn;
		
		return result;
	}
	
}
