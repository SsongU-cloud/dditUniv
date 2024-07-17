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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.service.StuLectureService;
import kr.or.ddit.service.TimePostService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.TimeBoastCommVO;
import kr.or.ddit.vo.TimeDeclareVO;
import kr.or.ddit.vo.TimeExchangeBoardVO;
import kr.or.ddit.vo.TimeLectureRecomVO;
import kr.or.ddit.vo.TimeLecutreBoastVO;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.proxy.annotation.Post;

/**
*
* @author PC-31 신고 조회 내역_권나현
*/

@Slf4j
@RequestMapping("/timePost")
@Controller
public class TimePostController {

	@Autowired
	TimePostService timePostService;
	@Autowired
	StuLectureService stuLectureService;

	// 신고 내역 목록
	@GetMapping("/reportDetails")
	public ModelAndView list(ModelAndView mav,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
			@RequestParam(value = "queGubun", required = false, defaultValue = "") String queGubun) {
		log.info("list에 왔다");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);

		// 행의 수
		int total = this.timePostService.getTotal(map);
		log.info("list->total: " + total);

		List<TimeDeclareVO> timeDeclareVOList = this.timePostService.list(map);
		log.info("list->timeDeclareVO: " + timeDeclareVOList);

		mav.addObject("articlePage",
				new ArticlePage<TimeDeclareVO>(total, currentPage, 10, timeDeclareVOList, keyword, queGubun));

		// jsp
		mav.setViewName("timePost/reportDetails");

		return mav;
	}

	// 목록아작
	@ResponseBody
	@PostMapping("/reportDetailsAjax")
	public ArticlePage<TimeDeclareVO> timedeclareListAjax(@RequestBody Map<String, Object> map) {
		log.info("reportDetailsAjax 페이지");
		log.info("list->map : " + map);

		// 전체 행수
		int total = this.timePostService.getTotal(map);
		log.info("reportDetailsAjax->total : " + total);

		// 목록
		List<TimeDeclareVO> timeDeclareVOList = this.timePostService.list(map);
		log.info("timeDeclareVOList : " + timeDeclareVOList);

		return new ArticlePage<TimeDeclareVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10,
				timeDeclareVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}

	// ======================================================= 나현씨 구역 끝

	// ======================================================= 유진씨 구역 시작


	// 학생 강의 거래 게시글 목록
	@GetMapping("/exchaBoard")
	public ModelAndView exchaBoard(ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("list->keyword : " + keyword);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		//강의 거래 게시글 전체 행수
		int total = this.timePostService.getTotalExc(map);
		log.info("list->total : " + total);
		
		//강의 거래 목록(양도)
		List<TimeExchangeBoardVO> exchaBoardAssList = this.timePostService.exchaBoard(map);
		log.info("exchaBoardAssList : " + exchaBoardAssList);
		
		//강의 거래 목록(구함)
		List<TimeExchangeBoardVO> exchaBoardWanList = this.timePostService.exchaBoardWan(map);
		log.info("exchaBoardWanList : " + exchaBoardWanList);
		
		mav.addObject("articlePageAss", new ArticlePage<TimeExchangeBoardVO>(total, currentPage, 10, exchaBoardAssList, keyword, queGubun));
		mav.addObject("articlePageWan", new ArticlePage<TimeExchangeBoardVO>(total, currentPage, 10, exchaBoardWanList, keyword, queGubun));
		
		//forwarding : jsp
		mav.setViewName("timePost/exchaBoard");
		
		return mav;
	}

	// 학생 강의 거래 게시글 상세
	@GetMapping("/excBoaDetail")
	public ModelAndView excBoaDetail(ModelAndView mav,
			Authentication auth,
			@RequestParam("timeExBNo") String timeExBNo) {

		log.info("timeExBNo >> {}", timeExBNo);
		
		//로그인한 사용자 정보 가져오기
		String stNo = auth.getName();
		mav.addObject("stNo", stNo);
		
		TimeExchangeBoardVO tecbList = timePostService.excBoaDetail(timeExBNo);
		mav.addObject("tecbList", tecbList);

		log.info("tecbList >> {}", tecbList);
		
		mav.setViewName("timePost/excBoaDetail");
		
		return mav;
	}

	// 학생 강의 거래 게시글 추가
	@GetMapping("/excBoaAdd")
	public String excBoaAdd() {
		return "timePost/excBoaAdd";
	}

	// 관리자 강의 거래 게시글 목록
	@GetMapping("/exchaBoardAdmin")
	public ModelAndView exchaBoardAdmin(ModelAndView mav,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		log.info("list->keyword : " + keyword);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		log.info("queGubun >> " + queGubun);
		
		//강의 거래 게시글 전체 행수
		int total = this.timePostService.getTotalExcAdmin(map);
		log.info("list->total : " + total);
		
		//강의 거래 목록(양도)
		List<TimeExchangeBoardVO> exchaBoardAssList = this.timePostService.exchaBoardAdmin(map);
		log.info("exchaBoardAssList : " + exchaBoardAssList);
		
		//강의 거래 목록(구함)
		List<TimeExchangeBoardVO> exchaBoardWanList = this.timePostService.exchaBoardWanAdmin(map);
		log.info("exchaBoardWanList : " + exchaBoardWanList);
		
		mav.addObject("articlePageAss", new ArticlePage<TimeExchangeBoardVO>(total, currentPage, 10, exchaBoardAssList, keyword, queGubun));
		mav.addObject("articlePageWan", new ArticlePage<TimeExchangeBoardVO>(total, currentPage, 10, exchaBoardWanList, keyword, queGubun));
		
		//forwarding : jsp
		mav.setViewName("timePost/exchaBoardAdmin");
		
		return mav;
	}

	// 관리자 강의 거래 게시글 상세
	@GetMapping("/excBoaDetailAdmin")
	public ModelAndView excBoaDetailAdmin(ModelAndView mav,
			Authentication auth,
			@RequestParam("timeExBNo") String timeExBNo) {

		log.info("timeExBNo >> {}", timeExBNo);
		
		//로그인한 사용자 정보 가져오기
		String stNo = auth.getName();
		mav.addObject("stNo", stNo);
		
		TimeExchangeBoardVO tecbList = timePostService.excBoaDetailAdmin(timeExBNo);
		mav.addObject("tecbList", tecbList);

		log.info("tecbList >> {}", tecbList);
		
		mav.setViewName("timePost/excBoaDetailAdmin");
		
		return mav;
	}
	
	// 관리자 블라인드 처리
	@ResponseBody
	@PostMapping("/deleteAdminAjax")
	public int deleteAdminAjax(@RequestBody Map<String, Object> map) {
		log.info("deleteAjax->timeExBNo: " + map);
		
		String timeExBNo = (String) map.get("timeExBNo");
		log.info("timeExBNo : {}", timeExBNo);
		
		int result = timePostService.deleteAdminAjax(timeExBNo);
		
		return result;
	}

	// ======================================================= 유진씨 구역 끝

	// ======================================================= 종진씨 구역 시작 (자 두개제)

	// 인재타임 자유게시판 -> 게시글 목록 조회
	@GetMapping("/freeBoard")
	public String freeBoard() {
		log.info("인재타임 게시글 목록 조회 출력");

		return "timePost/freeBoard";
	}

	// 인재타임 자유게시판 -> 게시글 등록

	@GetMapping("/freBoaAdd")
	public String freBoaAdd() {

		log.info("인태타임 게시글 등록 출력");

		return "timePost/freBoaAdd";
	}

	// 인재타임 자유게시판 -> 상세정보
	@GetMapping("/freeBoaDetail")
	public String freeBoaDetail() {

		log.info("인태타임 게시글 등록 출력");

		return "timePost/freeBoaDetail";
	}
	
	// 인재타임 자유게시판[관리자] -> 게시판 목록 조회 
	@GetMapping("/freeBoardAdmin")
	public String freeBoardAdmin() {

		log.info("인태타임 게시글 관리자 출력");

		return "timePost/freeBoardAdmin";
	}
	
	// 인재타임 자유게시판 -> 상세정보
	@GetMapping("/freeBoaDetailAdmin")
	public String freeBoaDetailAdmin() {

		log.info("인태타임 게시글 관리자 상세정보 ");

		return "timePost/freeBoaDetailAdmin";
	}
	
	// ======================================================= 종진씨 구역 끝

	// ======================================================= 수빈씨 구역 시작
	/**
	 * 강의자랑게시글
	 * @author 이수빈
	 * @param model
	 * @param currentPage
	 * @param keyword
	 * @param queGubun
	 * @return
	 */
	@GetMapping("/lecutreBoast")
	public String lecutreBoast(Model model,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue = "") String keyword, 
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun) {
		log.info("강의추천게시글조회");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> {}" , keyword);
		log.info("currentPage >> {}" , currentPage);
		log.info("queGubun >> {}" ,queGubun);
		//행의 수
		int total= this.timePostService.getTotalLecBoa(map);
		log.info("lecboa total>{}",total);
		//학생권한[일반]게시물 list
		List<TimeLecutreBoastVO> timeLecutreBoastVOList = this.timePostService.timeLecBoastList(map);
		log.info("lecboa timeLecutreBoastVOList>{}",timeLecutreBoastVOList);
		
		
		
		model.addAttribute("articlePage", new ArticlePage<TimeLecutreBoastVO>(total, currentPage, 10, timeLecutreBoastVOList, keyword, queGubun));
		model.addAttribute("articlePageAdmin", new ArticlePage<TimeLecutreBoastVO>(total, currentPage, 10, timeLecutreBoastVOList, keyword, queGubun));
		
		return "timePost/lecutreBoast";
	}
	
	/**
	 * 학생권한강의추천게시글조회 
	 * @param map
	 * @return
	 */
	@ResponseBody
	@PostMapping("/lecutreBoastAjax")
	public ArticlePage<TimeLecutreBoastVO> lecutreBoastAjax(@RequestBody Map<String,Object> map){
		log.info("강의추천게시글조회ajax");
		log.info("lecutreBoastAjax ajax >{}",map);
		
		int total= this.timePostService.getTotalLecBoa(map);
		log.info("lecboa total>{}",total);
		
		List<TimeLecutreBoastVO> timeLecutreBoastVOList = this.timePostService.timeLecBoastList(map);
		log.info("lecboa timeLecutreBoastVOList>{}",timeLecutreBoastVOList);
		
		return new ArticlePage<TimeLecutreBoastVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, timeLecutreBoastVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	@ResponseBody
	@GetMapping("/mostLikeList")
	public List<TimeLecutreBoastVO> mostLikeList(){
		log.info("좋아요 많은 리스트");
		List<TimeLecutreBoastVO> timeLecutreBoastVOList = this.timePostService.mostLikeList();
		log.info("mostLikeList "+timeLecutreBoastVOList);
		return timeLecutreBoastVOList;
	}
	
	/**
	 * 강의자랑게시글 작성페이지
	 * @param model 
	 * @param auth
	 * @return
	 */
	@GetMapping("/lecBoaAdd")
	public String lecBoaAdd(Model model,Authentication auth) {
		log.info("강의자랑 작성");
		model.addAttribute("stNo", auth.getName());
		return "timePost/lecBoaAdd";
	}
	/**
	 * 작성시 강의시간표 출력
	 * @param auth
	 * @return 강의시간표 출력
	 */
	@ResponseBody
	@GetMapping("/myLectureAjax")
	public List<StuLectureVO> myLectureAjax(Authentication auth){
		log.info("수강조회 페이지");
		
		String stNo = auth.getName();
//		System.out.println("myLecture >> stNo : " + stNo);
		
		//수강 중인 강의 목록
		List<StuLectureVO> myLecture = this.stuLectureService.myLecture(stNo);
//		log.info("list > myLecture : " + myLecture);
		
		//forwarding : jsp
		return myLecture;
	}
	/**
	 * lecBoaDetail 시간표
	 * @param map 학번/사번
	 * @return
	 */
	@ResponseBody
	@PostMapping("/LectureAjax")
	public List<StuLectureVO> LectureAjax(@RequestBody Map<String,Object> map){
		log.info("LectureAjax"+map);
		
		String stNo =(String) map.get("stNo");
//		log.info("LectureAjax stNo"+stNo);
		//수강 중인 강의 목록
		List<StuLectureVO> myLecture = this.stuLectureService.myLecture(stNo);
//		log.info("list > myLecture : " + myLecture);
		
		//forwarding : jsp
		return myLecture;
	}
	/**
	 * 강의자랑게시글 추가
	 * @author 이수빈
	 * @param timeLecutreBoastVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/lecBoaAddAjax")
	public int lecBoaAddAjax(@RequestBody TimeLecutreBoastVO timeLecutreBoastVO) {
//		log.info("수강 작성 추가>{}",timeLecutreBoastVO);
		int result = 0;
		result += this.timePostService.lecBoaAddAjax(timeLecutreBoastVO);
		return result;
	}
	/**
	 * 강의자랑게시글 상세조회& 조회수
	 * @return
	 * @throws Exception 
	 */
	@GetMapping("/lecBoaDetail")
	public String lecBoaDetail(Model model
			,TimeLecutreBoastVO timeLecutreBoastVO
			,Map<String, Object> map
			,@RequestParam(value="timeLecBoNo")String timeLecBoNo
			) throws Exception {
		log.info("강의자랑상세>{}",timeLecBoNo);
		map.put("timeLecBoNo", timeLecBoNo);
		//조회수
		int lecBoastViewCnt = this.timePostService.lecBoastViewCnt(map);
		
		timeLecutreBoastVO = this.timePostService.lecBoaDetail(map);
		log.info("timeLecutreBoastVO"+timeLecutreBoastVO);
		
		List<TimeLectureRecomVO> timeLectureRecomVOList =timeLecutreBoastVO.getTimeLectureRecomVOList();
		log.info("lecBoaDetail_timeLectureRecomVOList>"+timeLectureRecomVOList);
		ObjectMapper timeLectureRecomVOMapper = new ObjectMapper();
		String jsonstr = timeLectureRecomVOMapper.writeValueAsString(timeLectureRecomVOList);
		
		//공통상세코드
		String comCode= "RP001";
		List<ComDetCodeVO> comDetCodeVOList= this.timePostService.declarationComDetCode(comCode);
		
		model.addAttribute("timeLectureRecomVOList",jsonstr);
		model.addAttribute("timeLecutreBoastVO",timeLecutreBoastVO);
		model.addAttribute("comDetCodeVOList",comDetCodeVOList);
		return "timePost/lecBoaDetail";
	}

	/**
	 * 강의자랑상세조회 수정할때 가져오는데이터
	 * @param timeLecutreBoastVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/updateMode")
	public TimeLecutreBoastVO updateMode(@RequestBody TimeLecutreBoastVO timeLecutreBoastVO) {
		log.info("updateMode_timeLecutreBoastVO"+timeLecutreBoastVO);
		timeLecutreBoastVO=this.timePostService.updateMode(timeLecutreBoastVO);
		return timeLecutreBoastVO;
	}
	/**
	 * 강의자랑상세조회 수정 후 가져오는 데이터
	 * @param timeLecutreBoastVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/detailMode")
	public TimeLecutreBoastVO detailMode(@RequestBody TimeLecutreBoastVO timeLecutreBoastVO) {
		log.info("detailMode_timeLecutreBoastVO"+timeLecutreBoastVO);
		timeLecutreBoastVO = this.timePostService.detailMode(timeLecutreBoastVO);
		return timeLecutreBoastVO;
	}
	@ResponseBody
	@GetMapping("/lecBoaDetailGetAjax/{timeLecBoNo}")
	public TimeLecutreBoastVO lecBoaDetailGetAjax(
			TimeLecutreBoastVO timeLecutreBoastVO
			,Map<String, Object> map
			,@PathVariable String timeLecBoNo) {
		log.info("lecBoaDetailGetAjax>timeLecBoNo"+timeLecBoNo);
		map.put("timeLecBoNo", timeLecBoNo);
		
		timeLecutreBoastVO = this.timePostService.lecBoaDetail(map);
		log.info("timeLecutreBoastVO"+timeLecutreBoastVO);
		
		return timeLecutreBoastVO;
	}
	
	@ResponseBody
	@PostMapping("/likeList")
	public List<TimeLectureRecomVO> likeList(@RequestBody TimeLectureRecomVO timeLectureRecomVO) {
		log.info("likeList_timeLectureRecomVO>"+timeLectureRecomVO);
		List<TimeLectureRecomVO>timeLectureRecomVOList = this.timePostService.likeList(timeLectureRecomVO);
		log.info("likeList_timeLectureRecomVOList"+timeLectureRecomVOList);
		return timeLectureRecomVOList;
	}
	/**
	 * 추천 삭제
	 * @author 이수빈
	 * @param timeLectureRecomVO 학번/사번, 게시물번호
	 * @param timeLecutreBoastVO
	 * @param map
	 * @return timeLectureRecomVO list
	 */
	@ResponseBody
	@PostMapping("/likeDelete")
	public List<TimeLectureRecomVO> likeDelete(@RequestBody TimeLectureRecomVO timeLectureRecomVO
										,TimeLecutreBoastVO timeLecutreBoastVO
										,Map<String, Object> map) {
		
		log.info("좋아요 삭제 timeLectureRecomVO>"+timeLectureRecomVO);
		int likeDelCnt = this.timePostService.likeDelCnt(timeLectureRecomVO);
//		log.info("likeDelCnt"+likeDelCnt);
		
		String timeLecBoNo= timeLectureRecomVO.getTimeLecBoNo();
//		log.info("timeLecBoNo"+timeLecBoNo);
		
		map.put("timeLecBoNo", timeLecBoNo);
		timeLecutreBoastVO = this.timePostService.lecBoaDetail(map);
//		log.info("timeLecutreBoastVO"+timeLecutreBoastVO);
		
		List<TimeLectureRecomVO> timeLectureRecomVOList =timeLecutreBoastVO.getTimeLectureRecomVOList();
//		log.info("timeLectureRecomVOList>"+timeLectureRecomVOList);
		
		return timeLectureRecomVOList;
	}
	/**
	 * 추천 추가
	 * @param timeLectureRecomVO
	 * @param timeLecutreBoastVO
	 * @param map
	 * @return
	 */
	@ResponseBody
	@PostMapping("/likeInsert")
	public List<TimeLectureRecomVO> likeInsert(@RequestBody TimeLectureRecomVO timeLectureRecomVO
										,TimeLecutreBoastVO timeLecutreBoastVO
										,Map<String, Object> map) {
		log.info("좋아요추가>"+timeLectureRecomVO);
		int result = 0;
		result += this.timePostService.likeInsert(timeLectureRecomVO);
		log.info("likeInsert result"+result);
		
		String timeLecBoNo= timeLectureRecomVO.getTimeLecBoNo();
//		log.info("timeLecBoNo"+timeLecBoNo);
		
		map.put("timeLecBoNo", timeLecBoNo);
		timeLecutreBoastVO = this.timePostService.lecBoaDetail(map);
//		log.info("timeLecutreBoastVO"+timeLecutreBoastVO);
		
		List<TimeLectureRecomVO> timeLectureRecomVOList =timeLecutreBoastVO.getTimeLectureRecomVOList();
//		log.info("timeLectureRecomVOList>"+timeLectureRecomVOList);
		
		return timeLectureRecomVOList;
	}
	
	@ResponseBody
	@PostMapping("/lecBoaDelete")
	public int lecBoaDelete(@RequestBody TimeLecutreBoastVO timeLecutreBoastVO,Authentication auth) {
		log.info("강의자랑 삭제"+timeLecutreBoastVO);
		int result =0;
		result += this.timePostService.lecBoaDelete(timeLecutreBoastVO, auth);
		return result;
	}
	/**
	 * 강의추천게시글 댓글
	 * @param timeBoastCommVO
	 * @return List<TimeBoastCommVO>
	 */
	@ResponseBody
	@PostMapping("/timeBoastComm")
	public Map<String,Object> timeBoastComm(@RequestBody TimeBoastCommVO timeBoastCommVO
			, Principal principal) {
		log.info("timeBoastComm_timeBoastCommVO"+timeBoastCommVO);
		List<TimeBoastCommVO> timeBoastCommVOList =this.timePostService.timeBoastComm(timeBoastCommVO);
		log.info("timeBoastComm_timeBoastCommVOList"+timeBoastCommVOList);
		
		/*
		 let timeBDiv = "BB001002";
   		let timeDeId = userLoggedIn;
		 */
		TimeDeclareVO timeDeclareVO = new TimeDeclareVO();
		timeDeclareVO.setTimeBDiv("BB001002");
		timeDeclareVO.setTimeDeId(principal.getName());
		List<TimeDeclareVO> timeDeclareVOList = this.timePostService.timeBoastCommDeclare(timeDeclareVO);
		log.info("timeBoastComm_timeDeclareVOList : "+timeDeclareVOList);
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("timeBoastCommVOList", timeBoastCommVOList);
		map.put("timeDeclareVOList", timeDeclareVOList);
		
		return map;
	}
	/**
	 * 강의자랑게시글 상세조회 댓글 등록
	 * @param timeBoastCommVO timeLecBoNo,timeBoaCommCon
	 * @return
	 */
	@ResponseBody
	@PostMapping("/timeBoastCommInsert")
	public int timeBoastCommInsert(@RequestBody TimeBoastCommVO timeBoastCommVO) {
		int result = 0;
		result += this.timePostService.timeBoastCommInsert(timeBoastCommVO);
		return result;
	}
	/**
	 * 강의자랑게시글 상세조회 댓글삭제
	 * @param timeBoastCommVO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/timeBoastCommDelete")
	public int timeBoastCommDelete(@RequestBody TimeBoastCommVO timeBoastCommVO) {
		log.info("timeBoastCommDelete_timeBoastCommVO"+timeBoastCommVO);
		int result = 0;
		result += this.timePostService.timeBoastCommDelete(timeBoastCommVO);
		return result;
	}
	@ResponseBody
	@PostMapping("/timeBoastCommDeclare")
	public List<TimeDeclareVO> timeBoastCommDeclare(@RequestBody TimeDeclareVO timeDeclareVO){
		log.info("댓글 신고 조회>"+timeDeclareVO);
		List<TimeDeclareVO> timeDeclareVOList = this.timePostService.timeBoastCommDeclare(timeDeclareVO);
		return timeDeclareVOList;
	}
	
	/**
	 * 강의자랑게시글 수정 
	 * @return
	 */
	@ResponseBody
	@PostMapping("/lecBoaUpdate")
	public int lecBoaUpdate(@RequestBody TimeLecutreBoastVO timeLecutreBoastVO) {
		log.info("강의자랑수정"+timeLecutreBoastVO);
		int result =0;
		result += this.timePostService.lecBoaUpdate(timeLecutreBoastVO);
		return result;
	}
	@ResponseBody
	@PostMapping("/lecBoaDeclaration")
	public int lecBoaDeclaration(@RequestBody TimeDeclareVO timeDeclareVO) {
		log.info("lecBoaDeclaration_timeDeclareVO"+timeDeclareVO);
		int result = 0;
		result += this.timePostService.lecBoaDeclaration(timeDeclareVO);
		return result;
	}
//학생권한 강의자랑게시글end
//관리자권한 강의자랑게시글start
	/**
	 * 권리자 권한 강의자랑게시글List
	 * @param model
	 * @param currentPage
	 * @param keyword
	 * @param queGubun
	 * @return
	 */
	@GetMapping("/lecutreBoastAdmin")
	public String lecutreBoastAdmin(Model model,
			@RequestParam(value="currentPage", required = false, defaultValue = "1") int currentPage,
			@RequestParam(value="keyword", required=false, defaultValue = "") String keyword, 
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun) {
		log.info("강의추천게시글조회");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		log.info("keyword >> {}" , keyword);
		log.info("currentPage >> {}" , currentPage);
		log.info("queGubun >> {}" ,queGubun);
		//행의 수
		int total= this.timePostService.getTotalLecBoaAdmin(map);
		log.info("lecboaAdmin total>{}",total);
		
		//관리자권한[일반]게시물list
		List<TimeLecutreBoastVO> timeLecutreBoastAdminVOList = this.timePostService.lecutreBoastAdminAjax(map);
		log.info("lecboaAdmin timeLecutreBoastVOList>{}",timeLecutreBoastAdminVOList);
		
		model.addAttribute("articlePageAdmin", new ArticlePage<TimeLecutreBoastVO>(total, currentPage, 10, timeLecutreBoastAdminVOList, keyword, queGubun));
		
		return "timePost/lecutreBoastAdmin";
	}
	/**
	 * 관리자 권한 [추천]강의자랑게시글 list
	 * @return
	 */
	@ResponseBody
	@GetMapping("/mostLikeListAdmin")
	public List<TimeLecutreBoastVO> mostLikeListAdmin(){
//		log.info("좋아요 많은 리스트");
		List<TimeLecutreBoastVO> timeLecutreBoastVOList = this.timePostService.mostLikeListAdmin();
		log.info("mostLikeList "+timeLecutreBoastVOList);
		return timeLecutreBoastVOList;
	}
	
	/**
	 * 관리자권한 [일반]강의자랑게시글 list 
	 * @param map
	 * @return
	 */
	@ResponseBody
	@PostMapping("/lecutreBoastAdminAjax")
	public ArticlePage<TimeLecutreBoastVO> lecutreBoastAdminAjax(@RequestBody Map<String,Object> map){
		log.info("강의추천게시글조회ajax");
		log.info("lecutreBoastAjax ajax >{}",map);
		
		int total= this.timePostService.getTotalLecBoa(map);
		log.info("lecboa total>{}",total);
		
		List<TimeLecutreBoastVO> timeLecutreBoastVOList = this.timePostService.lecutreBoastAdminAjax(map);
		log.info("lecboa timeLecutreBoastVOList>{}",timeLecutreBoastVOList);
		
		return new ArticlePage<TimeLecutreBoastVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, timeLecutreBoastVOList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	/**
	 * 강의자랑게시글 상세조회& 조회수 뺌
	 * @return
	 * @throws Exception 
	 */
	@GetMapping("/lecBoaDetailAdmin")
	public String lecBoaDetailAdimin(Model model
			,TimeLecutreBoastVO timeLecutreBoastVO
			,Map<String, Object> map
			,@RequestParam(value="timeLecBoNo")String timeLecBoNo
			) throws Exception {
		log.info("강의자랑상세>{}",timeLecBoNo);
		map.put("timeLecBoNo", timeLecBoNo);
		//조회수
//		int lecBoastViewCnt = this.timePostService.lecBoastViewCnt(map);
		
		timeLecutreBoastVO = this.timePostService.lecBoaDetail(map);
		log.info("timeLecutreBoastVO"+timeLecutreBoastVO);
		
		List<TimeLectureRecomVO> timeLectureRecomVOList =timeLecutreBoastVO.getTimeLectureRecomVOList();
		log.info("lecBoaDetail_timeLectureRecomVOList>"+timeLectureRecomVOList);
		ObjectMapper timeLectureRecomVOMapper = new ObjectMapper();
		String jsonstr = timeLectureRecomVOMapper.writeValueAsString(timeLectureRecomVOList);
		
		//공통상세코드
		String comCode= "RP001";
		List<ComDetCodeVO> comDetCodeVOList= this.timePostService.declarationComDetCode(comCode);
		
		model.addAttribute("timeLectureRecomVOList",jsonstr);
		model.addAttribute("timeLecutreBoastVO",timeLecutreBoastVO);
		model.addAttribute("comDetCodeVOList",comDetCodeVOList);
		return "timePost/lecBoaDetailAdmin";
	}
	
	@ResponseBody
	@PostMapping("/timeBoastCommAdmin")
	public List<TimeBoastCommVO> timeBoastCommAdmin(@RequestBody TimeBoastCommVO timeBoastCommVO) {
		List<TimeBoastCommVO> timeBoastCommVOList = this.timePostService.timeBoastCommAdmin(timeBoastCommVO);
		return timeBoastCommVOList;
	}
	
	@ResponseBody
	@PostMapping("/lecBoaAdminBlindUpdateY")
	public int lecBoaAdminBlindUpdateY(@RequestBody TimeLecutreBoastVO timeLecutreBoastVO) {
		int result =0;
		result += this.timePostService.lecBoaAdminBlindUpdateY(timeLecutreBoastVO);
		return result ; 
	}
	@ResponseBody
	@PostMapping("/lecBoaAdminCommBlindUpdateY")
	public int lecBoaAdminCommBlindUpdateY(@RequestBody TimeBoastCommVO timeBoastCommVO) {
		int result =0;
		result += this.timePostService.lecBoaAdminCommBlindUpdateY(timeBoastCommVO);
		return result;
	}
//관리자권한 강의자랑게시글end
	// ======================================================= 수빈씨 구역 끝
	
	//======================================================= 래현씨 구역 시작
	@GetMapping("/lostItem")
	public String lostItem(Model model) {
		log.info("분실물 게시판데스~");
		
		return "timePost/lostItem";
	}
	
	@GetMapping("/lostItemDetail")
	public String lostItemDetail() {
		log.info("분실물 상세 게시판데스~");
		
		return "timePost/lostItemDetail";
	}
	
	@GetMapping("/lostItemAdd")
	public String lostItemAdd() {
		log.info("분실물 게시글 추가페이지데스~");
		
		return "timePost/lostItemAdd";
	}
	
	@GetMapping("/lostItemAdmin")
	public String lostItemAdmin(Model model) {
		log.info("분실물 게시판 관리자");
		
		return "timePost/lostItemAdmin";
	}
	
	@GetMapping("/lostItemDetailAdmin")
	public String lostItemDetailAdmin() {
		log.info("분실물 상세 게시판 관리자");
		
		return "timePost/lostItemDetailAdmin";
	}
	//======================================================= 래현씨 구역 끝
}