package kr.or.ddit.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.service.ProfLectureService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.AchExeptionVO;
import kr.or.ddit.vo.AttendanceVO;
import kr.or.ddit.vo.BuildingInfoVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.LectureDetailVO;
import kr.or.ddit.vo.LectureRoomVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.QuestionVO;
import kr.or.ddit.vo.StuLectureVO;
import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author PC-13
 * 교수의 강의 관리 페이지
 */
@Slf4j
@RequestMapping("/profLecture")
@Controller
public class ProfLectureController {
	private String proNo;
	@Autowired
	ProfLectureService profLectureService;
	
	/**
	 * 강의 등록 페이지 get
	 * @author 김다희
	 * @param model
	 * @return
	 */
	@GetMapping("/lectureCreate")
	public String lectureCreate(Model model) {
		
//		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		
		List<ComCodeVO> collegeList = profLectureService.collegeList();
		log.info("collegeList >>> {}", collegeList);
		log.info("collegeList size : {}",collegeList.size());
		
		List<BuildingInfoVO> bulidList  = profLectureService.buildList();
		log.info("bulidList >>> {}", bulidList);
		log.info("bulidList size : {}",bulidList.size());
		
		model.addAttribute("collegeList",collegeList);
		model.addAttribute("bulidList",bulidList);
		
		return "profLecture/lectureCreate";
	}
	
	/**
	 * 학과 목록
	 * @author 김다희
	 * @param collegeCode
	 * @return
	 */
	@ResponseBody
	@PostMapping("/deptList")
	public List<ComDetCodeVO> deptList(@RequestBody String collegeCode) {
		
		List<ComDetCodeVO> deptList = profLectureService.deptList(collegeCode);
		
		log.info("deptList >>>>>>" + deptList);

		for(ComDetCodeVO dept : deptList) {
			log.info("dept >>>>>>" + dept);
		}
		
		return deptList;
	}
	
	/**
	 * 강의 등록 페이지에서 강의 건물 검색
	 * @author 김다희
	 * @param buildSeaWord 검색 키워드
	 * @return
	 */
	@ResponseBody
	@PostMapping("/bulidSearch")
	public List<BuildingInfoVO> buildSearchList(@RequestBody String buildSeaWord){
		
		List<BuildingInfoVO> buildSearchList  = profLectureService.buildSearchList(buildSeaWord);
		
		log.info("buildSearchList >>> {}", buildSearchList);
		log.info("buildSearchList >>> {}", buildSearchList.size());
		
		return buildSearchList;
	}
	
	/**
	 * 강의등록 페이지에서 강의 건물 선택 했을때 해당 건물에 선택한 요일/교시에 사용 가능한
	 * 강의실 목록 출력
	 * @author 김다희
	 * @param param 강의 건물 코드, 선택한 강의 요일/교시 
	 * @return 건물에 해당하는 강의실 목록 반환
	 */
	@ResponseBody
	@PostMapping("/buildChoice")
	public List<LectureRoomVO> buildChoice(@RequestBody Map<String, Object> param){
        
		String bldNo = (String)param.get("bldNo");
		List<Map<String, Object>> lecTimeVOList = (List<Map<String, Object>>)param.get("lecTimeVOlist");
		
		String lecDay0 = (String)lecTimeVOList.get(0).get("lecDay");
		String lecSt0 = (String)lecTimeVOList.get(0).get("lecSt");
		String lecEnd0 = (String)lecTimeVOList.get(0).get("lecEnd");
		String lecDay1 = "";
		String lecSt1 = "";
		String lecEnd1 = "";
		
		if(lecTimeVOList.size()>1) {
			lecDay1 = (String)lecTimeVOList.get(1).get("lecDay");
			lecSt1 = (String)lecTimeVOList.get(1).get("lecSt");
			lecEnd1 = (String)lecTimeVOList.get(1).get("lecEnd");
		}
		
		//log.info("lecDay0>>>>>>>>>>>{}",lecDay0);
		//log.info("lecDay1 >>>>>>>>>{}",lecDay1);
		
		Map<String,Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("bldNo", bldNo);
		paramMap.put("lecDay0", lecDay0);
		paramMap.put("lecSt0", lecSt0);
		paramMap.put("lecEnd0", lecEnd0);
		paramMap.put("lecDay1", lecDay1);
		paramMap.put("lecSt1", lecSt1);
		paramMap.put("lecEnd1", lecEnd1);
		
		List<LectureRoomVO> lecRoomList = profLectureService.buildChoice(paramMap); 
		
		//profLectureService.buildChoice(param);
		//log.info("lecRoomList >>> {}", lecRoomList);
		
		return lecRoomList;
	}
	
	/**
	 * 강의 등록
	 * @author 김다희
	 * @param lectureVO
	 * @return
	 */
	@ResponseBody 
	@PostMapping("/lecCreate")
	public int lecCreate(LectureVO lectureVO) {
		log.info("lecCreate >>>>>>>lectureVO :"+ lectureVO);
		String fileName = lectureVO.getLecFile().getOriginalFilename();
		log.info("lecture>>파일이름 : {}",fileName);
		
		log.info("lectuerDet >>> {}",lectureVO.getLectureDetailVOList());
		int result = profLectureService.lecCreate(lectureVO);
		
		log.info("result>>>{}",result);
		
		return result;
	}
	
	// 강의등록 계획서 조회
	@GetMapping("/achList")
	public String achList(Model model,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		
		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("proNo", proNo);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		
		//전체 행수 
		int total = profLectureService.achListPCnt(proNo);
		//int total = this.noticeService.getTotal(map);
		//log.info("list->total : " + total);
		
		//목록
		List<LectureVO> lectureVOList = profLectureService.lectureList(map);
		
		
		model.addAttribute("lectureVOList", lectureVOList);
		model.addAttribute("articlePage", new ArticlePage<LectureVO>(total, currentPage, 10, lectureVOList, keyword, queGubun));
		
		
		return "profLecture/achList";
	}

	// 강의등록 계획서 조회
	@GetMapping("/lecList")
	public String lecList(Model model,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		
		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		
		int total = profLectureService.lecListPCnt(proNo);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("proNo", proNo);
		log.info("keyword >> " + keyword);
		log.info("currentPage >> " + currentPage);
		
		//전체 행수
		log.info("list->total : " + total);
		
		//목록
		List<LectureVO> lectureVOList = profLectureService.lecList(map);
		log.info("list->lectureVOList : " + lectureVOList);
		model.addAttribute("lectureVOList", lectureVOList);
		
		model.addAttribute("articlePage", new ArticlePage<LectureVO>(total, currentPage, 10, lectureVOList, keyword, queGubun));
		
		
		return "profLecture/lecList";
	}
	
	// 강의 상세 회차별 내용
	@ResponseBody
	@PostMapping("/lecDetail")
	public List<LectureDetailVO> lecDetail(@RequestBody String lecNo) {
		
		log.info("lecDetail >> lecNo : {}",lecNo);
		
		List<LectureDetailVO> lecDetailVOList = this.profLectureService.lecDetail(lecNo);
		log.info("lecDetail >> lecDetailVOList :{}",lecDetailVOList);
		return lecDetailVOList;
	}
	
	/**
	 * 학생 성적을 등록하는 페이지로 연결
	 * @author 김다희
	 * @param model 
	 * @return 해당 학기의 내 강의 목록, 해당 강의의 수강생 목록, 출결 점수를 가지고 페이지 이동
	 */
	@GetMapping("/achievement")
	public String achievement(Model model) {
		
		String proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		
		List<LectureVO> lectureVOList = profLectureService.achiLectureList(proNo);
		
		log.info("profLecture/achievement >>>>>lectureVOList : {}",lectureVOList);
		
		model.addAttribute("lectureVOList",lectureVOList);
		
		return "profLecture/achievement";
	}
	
	/**
	 * 성적등록을 위한 수강생 목록
	 * @author 김다희
	 * @param lecNo
	 * @return
	 */
	@ResponseBody
	@PostMapping("/stuLetureList")
	public List<StuLectureVO> stuLetureList(@RequestBody String lecNo){
		log.info("stuLetureList >> lecNo : {}",lecNo);
		
		List<StuLectureVO> stuLectureVoList = profLectureService.stuLetureList(lecNo); 
		log.info("stuLetureList >> stuLectureVoList : {}",stuLectureVoList);
		return stuLectureVoList;
		
	}
	
	/**
	 * 성적등록 - 강의 상세 정보
	 * @param lecNo
	 * @return
	 */
	@ResponseBody
	@PostMapping("/achLectureDetail")
	public LectureVO achLectureDetail(@RequestBody String lecNo) {
		LectureVO lectureVO = profLectureService.achLectureDetail(lecNo);
		log.info("lectureVO : {}",lectureVO);
		
		return lectureVO;
	}
	
	/**
	 * 성적입력 > 등록 or 업데이트
	 * @author 김다희
	 * @param stuLectureVOList
	 * @return
	 */
	@ResponseBody
	@PostMapping("/achieveInsert")
	public int achieveInsert(@RequestBody List<StuLectureVO> stuLectureVOList) {
	    log.info("achieveInsert : 컨트롤러 왔다");
	    for (StuLectureVO stuLectureVO : stuLectureVOList) {
	        log.info("체킁 : {}", stuLectureVO.getAssigSituVO().getAssigScore());
	    }
	    
	    int result = profLectureService.achieveInsert(stuLectureVOList);
	    
	    return result;
	}
	
	@GetMapping("/achExeption")
	public String achExeption(Model model) {
		log.info("교수 - 성적이의 페이지");
		this.proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		
		List<AchExeptionVO> achExeptionVOList = profLectureService.achExeptionVOList(proNo);
		
		log.info("achExeption >> achExeptionVOList {}",achExeptionVOList);
		
		model.addAttribute("achExeptionVOList", achExeptionVOList);
		
		return "profLecture/achExeption";
	}
	
	// 이의신청 학생 성적
	@ResponseBody
	@PostMapping("/achExepDetail")
	public StuLectureVO achExepDetail(@RequestBody String stuLecNo){
		StuLectureVO stuLectureVO = profLectureService.achExepDetail(stuLecNo);
		
		log.info("achExepDetail >> stuLectureVO {}",stuLectureVO);
		
		return stuLectureVO;
	}
	
	/**
	 * 이의신청 성적 변경
	 * @param stuLectureVOList
	 * @return
	 */
	@ResponseBody
	@PostMapping("/achExepUpdate")
	public int achExepUpdate(@RequestBody StuLectureVO stuLectureVO) {
		log.info("achExepUpdate>> {}",stuLectureVO);
		int result = profLectureService.achExepUpdate(stuLectureVO);
		
		return result;
	}

	/**
	 * 이의신청 테이블 변경
	 * @param stuLectureVOList
	 * @return
	 */
	@ResponseBody
	@PostMapping("/achExepStatUpdate")
	public int achExepStatUpdate(@RequestBody AchExeptionVO achExeptionVO) {
		log.info("achExepStatUpdate>> {}",achExeptionVO);
		int result = profLectureService.achExepStatUpdate(achExeptionVO);
		
		return result;
	}
	
	@GetMapping("/evaluation")
	public String evaluation() {
		return "profLecture/evaluation";
	}
	//======================================================= 다희씨 구역 끝
	
	
	//=======================================================  수빈씨 구역 시작
	/**
	 * @author 이수빈
	 * 학생 출결 get
	 * @return
	 * @throws Exception 
	 */
	@GetMapping("/attendance")
	public String attendance(Model model) throws Exception {
		log.info("학생출결 관리");
		this.proNo = SecurityContextHolder.getContext().getAuthentication().getName();
		//강의 목록
		List<LectureVO> lectureVOList = profLectureService.LectureVOList(this.proNo);
		log.info("LectureVOList>>{}",lectureVOList);
		
		List<StuLectureVO> stuLectureVOCountList = new ArrayList();
		for (int i = 0; i < lectureVOList.size(); i++) {
			String lectureNo = lectureVOList.get(i).getLecNo();
			log.info(lectureVOList.get(i).getLecNo());
			
			StuLectureVO  stuLectureVOCount = new StuLectureVO();//강의 인원 담기 위한 값
			stuLectureVOCount.setLecNo(lectureNo);
			stuLectureVOCount=profLectureService.stuLectureCount(stuLectureVOCount);
			log.info("stuLectureVOCount>{}",stuLectureVOCount);
			stuLectureVOCountList.add(stuLectureVOCount);
		}
		log.info("stuLectureVOCountList>>{}",stuLectureVOCountList);
		
		//선택상자
		String comCode = "AD001";
		List<ComCodeVO> comCodeVOList = this.profLectureService.attendanceComCode(comCode);
		log.info("comCodeVOList>{}",comCodeVOList);
		
		
		ObjectMapper sbMapper = new ObjectMapper();
		
		String jsonStr = sbMapper.writeValueAsString(comCodeVOList); // 자바스크립트가 JSON으로 해석할 수 있는 문자열로 변환
		log.info("jsonStr>{}",jsonStr);
		
		//당일 어떤 수업인지 표시
			//당일날짜
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy/MM/dd");
		LocalDate date = LocalDate.now();
		String nowAttLecNoDate = date.format(formatter);
		log.info("nowAttLecNoDate>>{}", nowAttLecNoDate);
		//테스트용
//		nowAttLecNoDate = "24/06/05";

		Map<String, Object> nowAttData = new HashMap<String,Object>();
		nowAttData.put("proNo", proNo);
		nowAttData.put("nowAttLecNoDate", nowAttLecNoDate);
		List<StuLectureVO> nowlecNoList = this.profLectureService.nowlecNoList(nowAttData);
		log.info("nowlecNoList>>{}",nowlecNoList);
		
		//jsp 데이터 전송
//		model.addAttribute("comCodeVOList",comCodeVOList);
		model.addAttribute("comCodeVOList",jsonStr);
		model.addAttribute("lectureVOList",lectureVOList);
		model.addAttribute("stuLectureVOCountList",stuLectureVOCountList);
		model.addAttribute("nowlecNoList",nowlecNoList);
		return "profLecture/attendance";
	}
	/**
	 * 강의 목록 클릭시 당일 출석 학생 정보 목록들
	 * 출석 결과 유무
	 * @author 이수빈
	 * @param nowStudentListParams 
	 * 		 {lecNo, lecSemester, lecYear, lecName, lecRoNo, dateString=, keyword=}
	 * @return
	 */
	@ResponseBody
	@PostMapping("/nowAttendStudList")
	public Map<String, Object> nowAttendStudList (@RequestBody Map<String, Object> nowStudentListParams) {
		log.info("nowStudentList map>{}",nowStudentListParams);
		//당일출석 학생리스트
		List<StuLectureVO> stuLectureVOList = this.profLectureService.nowAttendStudList(nowStudentListParams);
		log.info("StuLectureVOList>>{}",stuLectureVOList);
		
		List<AttendanceVO> attendanceVOList = this.profLectureService.nowAttendStudComCode(nowStudentListParams);
		log.info("attendanceVOList>>{}",stuLectureVOList);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("stuLectureVOList", stuLectureVOList);
		map.put("attendanceVOList", attendanceVOList);
		
		return map;
	}
	/**
	 * 강의 목록 클릭시 학생 정보 목록들
	 * @author 이수빈
	 * @param map
	 * @return
	 */
	@ResponseBody
	@PostMapping("/attendStuList")
	public List<StuLectureVO> attendStuList(@RequestBody Map<String, Object> map) {
		log.info("attendStuList map>>{}",map);
		List<StuLectureVO> stuLectureVO = this.profLectureService.attendStuList(map);
		log.info("stuLectureVO>>{}",stuLectureVO);
		return stuLectureVO;
	}
	/**
	 * List<AttendanceVO> attendanceVOList
	 * @author 이수빈
	 * @param attendanceVOList 출석 여러개
	 * @return 횟수
	 */
	@ResponseBody
	@PostMapping("/attendanceInsert")
	public int attendanceInsert(@RequestBody List<AttendanceVO> attendanceVOList) {
//		log.info("attendanceVOList>>{}",attendanceVOList);
		int result = 0;
		
		for(AttendanceVO attendanceVO :attendanceVOList) {
			result += profLectureService.attendanceInsert(attendanceVO);
		}
		return result;
	}
	/**
	 * @author 이수빈
	 * @param map 학번/사번,강의번호
	 * @return
	 */
	@ResponseBody
	@PostMapping("/attStudList")
	public List<AttendanceVO> attStudList(@RequestBody Map<String, Object> map) {
		log.info("attStudList map>>{}",map);
		List<AttendanceVO> attendanceVOList = this.profLectureService.attStudList(map);
		log.info("attendanceVOList>>>",attendanceVOList);
		return attendanceVOList;
	}
	
	//======================================================= 수빈씨 구역 끝
   
   
	//======================================================= 유진씨 구역 시작
	
	/** 수강 학생 조회 전 교수의 강의 목록 리스트
	 * @author 송유진
	 */
	@GetMapping("/stuList")
	public ModelAndView stuList(ModelAndView mav, 
			Authentication auth) {
		//로그인한 교수 사번
		String proNo = auth.getName();
		log.info("proNo : {}", proNo);
		
		List<LectureVO> stuList = profLectureService.stuList(proNo);
		log.info("stuList : {}", stuList);
		
		mav.addObject("stuList", stuList);
		mav.setViewName("profLecture/stuList");
		
		return mav; 
	}
	
	/**
	 * 수강 학생 조회 (강의 목록 리스트 클릭 후)
	 * @author 송유진
	 */
	@GetMapping("/stuDetail")
	public ModelAndView stuDetail(ModelAndView mav,
			@RequestParam("lecNo") String lecNo,
			@RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun",required=false,defaultValue="") String queGubun) {
		
		log.info("lecNo : {}", lecNo);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("keyword", keyword);
		map.put("currentPage", currentPage);
		map.put("queGubun", queGubun);
		map.put("lecNo", lecNo);
		
		//특정 강의에 대한 학생 목록 전체 행수
		int total = this.profLectureService.stuGetTotal(map);
		log.info("stuDetail->stuGetTotal : " + total);
		
		//특정 강의에 대한 학생 목록
		List<LectureVO> stuDetail = profLectureService.stuDetail(map);
		log.info("stuDetail {}", stuDetail);
		
		mav.addObject("lecNo", lecNo);
		mav.addObject("articlePage", new ArticlePage<LectureVO>(total, currentPage, 10, stuDetail, keyword, queGubun));
		mav.setViewName("profLecture/stuDetail");
		
		return mav;
	}
	
	/**
	 * 수강 학생 조회 (강의 목록 리스트 클릭 후) Ajax
	 * @author 송유진
	 */
	@ResponseBody
	@PostMapping("/stuDetailAjax")
	public ArticlePage<LectureVO> stuDetailAjax(@RequestBody Map<String,Object> map) {
		log.debug("map : {}", map);
		
		//특정 강의에 대한 학생 목록 전체 행수
		int total = this.profLectureService.stuGetTotal(map);
		log.info("stuDetail->stuGetTotal : " + total);
		
		//특정 강의에 대한 학생 목록
		List<LectureVO> stuDetail = profLectureService.stuDetail(map);
		log.info("stuDetailAjax -> stuDetail : {}", stuDetail);
		
		return new ArticlePage<LectureVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, stuDetail, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	
	//======================================================= 유진씨 구역 끝
}
