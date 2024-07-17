package kr.or.ddit.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.service.AdminStudentService;
import kr.or.ddit.service.DeptMaintenanceService;
import kr.or.ddit.service.ManagerEmpService;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.ScheduleVO;
import kr.or.ddit.vo.SchoolEmployeeVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-11
 * 관리자 - 학생 조회
 */
/**
 * @author PC-11
 *
 */
@Controller
@Slf4j
@RequestMapping("/manager")
public class AdminStudentController {
	
	@Autowired
	AdminStudentService adminStudentService;
	
	@Autowired
	ManagerEmpService managerEmpService;
	
	@Autowired
	DeptMaintenanceService deptMaintenanceService;
	
	// 관리자 - 학생 조회
	@GetMapping("/stuList")
	public String stuList(Model model
			, @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage) {
		log.info("관리자 - 학생 관리 " + currentPage);
		Map<String,Object> map = new HashMap<String, Object>(); 
		map.put("currentPage", currentPage);
		
		List<ComDetCodeVO> deptList = this.adminStudentService.deptList();
//		log.info("deptList >>> " + deptList);
		model.addAttribute("deptList", deptList);
		
		return "manager/stuList";
	}
	
	// 학과 선택 후 학생 리스트 출력 AJAX
	@ResponseBody
	@PostMapping("/listAjax")
	public ArticlePage<StudentVO> listAjax(Model model
			, @RequestBody Map<String, Object> map) {
		log.info("학과 별 학생 Ajax >>>>>>> " + map);
		
		int total = this.adminStudentService.getTotal(map);
//		log.info("total >> " + total);
		
		List<StudentVO> stdList = this.adminStudentService.stdList(map);
//		log.info("stdList >>> " + stdList);
		
		return new ArticlePage<StudentVO>(total, Integer.parseInt(map.get("currentPage").toString()), 10, stdList, null, null);
	}
	
	// 학생 상세 정보 조회
	@GetMapping("/stuDetail")
	public String detail(Model model, String stNo) {
		log.info("detail 페이지 : " + stNo);
		
		StudentVO studentDetail = this.adminStudentService.detail(stNo);
		log.info("학생 상세 정보 >>> " + studentDetail);
		
		model.addAttribute("studentDetail", studentDetail);
		
		return "manager/stuDetail";
	}
	
	// 수정 후 학생 상세 정보 조회 다시 호출할 용도
	@ResponseBody
	@PostMapping("/reDetail")
	public StudentVO reDetail(@RequestBody Map<String, String> map) {
		String stNo = map.get("stNo");
		log.info("detail 페이지 : " + stNo);
		
		StudentVO studentDetail = this.adminStudentService.detail(stNo);
		log.info("학생 상세 정보 >>> " + studentDetail);
		
		
		return studentDetail;
	}
	
	@ResponseBody
	@PostMapping("/getProf")
	public StudentVO getProf(@RequestBody Map<String, Object> map) {
		log.info("담당 교수 출력 : " + map);
		
		StudentVO getProf = this.adminStudentService.getProf(map);
		log.info("getProf >>> " + getProf);
		
		return getProf;
	}
	
	// 학생 정보 수정
	@ResponseBody
	@PostMapping("/updateAjax")
	public int updateAjax(StudentVO studentVO) {
		log.info("updateAjax >> " + studentVO);
		
		int result = this.adminStudentService.updateStd(studentVO);
		log.info("학생 정보 수정 result >>>>>>>>>>>>> " + result);
		
		return result;
	}
	
	// 신입생 추가
	@GetMapping("/stuAdd")
	public String stdAdd(Map<String, Object> map, Model model) {
		log.info("신입생 추가 페이지");
		
		// 단과대학 불러오기
		List<ComCodeVO> comCodeVOList = this.adminStudentService.getCollege();
		model.addAttribute("comCodeVOList",comCodeVOList);
		
		return "manager/stuAdd";
	}
	
	// 학과 교수 목록
	@ResponseBody
	@PostMapping("/getProfList")
	public List<ProfessorVO> getProfList(@RequestBody Map<String, Object> map) {
		log.info("학과 교수 목록 >>> " + map);
		
		List<ProfessorVO> profList = this.adminStudentService.getProfList(map);
		
		return profList;
	}
	
	// 학번 자동 생성
	@ResponseBody
	@PostMapping("/getStNo")
	public String getStNo(@RequestBody Map<String, Object> map) {
		
		String stNo = this.adminStudentService.getStNo(map);
		
		return stNo;
	}
	
	// 단과대학 코드를 통해 학과 출력
	@ResponseBody
	@PostMapping("/getDept")
	public List<ComDetCodeVO> getDept(@RequestBody Map<String, Object> map){
		log.info("getDept >>> " + map);
		
		List<ComDetCodeVO> deptList = this.adminStudentService.getDept(map);
//		log.info("deptList >>>>>> " + deptList);
		
		return deptList;
	}
	
	@ResponseBody
	@PostMapping("/stuAdd")
	public int stuAdd(StudentVO studentVO) {
		log.info("stuAdd >>>>> " + studentVO);
		
		int result = this.adminStudentService.stuAdd(studentVO);
		log.info("신입생 추가 성공 >>> " + result);
		
		return result;
	}
	
	// 교직원 조회
	@GetMapping("/schEmployeeList")
	public String schEmployeeList(Model model
			, @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage
			, @RequestParam(value="keyword",required=false,defaultValue="") String keyword
			, @RequestParam(value="searchCnd", required = false, defaultValue = "") String searchCnd) {
		log.info("교직원 조회 페이지 >>>>> ");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("keyword", keyword);
		map.put("searchCnd", searchCnd);
		
//		log.info("schEmpList - Map >> " + map);
		
		List<SchoolEmployeeVO> empList = this.managerEmpService.empList(map);
		int getTotal = this.managerEmpService.getTotal(map);
//		log.info("empList >>> " + empList);
//		log.info("getTotal >>> " + getTotal);
		
		model.addAttribute("articlePage", new ArticlePage<SchoolEmployeeVO>(getTotal, currentPage, 10, empList, keyword, searchCnd));
		
		return "manager/schEmployeeList";
	}
	
	@ResponseBody
	@PostMapping("/emplistAjax")
	public ArticlePage<SchoolEmployeeVO> emplistAjax(@RequestBody Map<String,Object> map) {
		log.info("listAjax");
		log.info("list->map : " + map);
		
		//전체 행수
		int getTotal = this.managerEmpService.getTotal(map);
//		log.info("listAjax->total : " + getTotal);
		
		//목록
		List<SchoolEmployeeVO> empList = this.managerEmpService.empList(map);
//		log.info("nVOList : " + empList);
		
		return new ArticlePage<SchoolEmployeeVO>(getTotal, Integer.parseInt(map.get("currentPage").toString()), 10, empList, map.get("keyword").toString(), map.get("queGubun").toString());
	}
	
	// 교직원 추가
	@GetMapping("/schEmployeeAdd")
	public String schEmployeeAdd(Model model) {
		log.info("교직원 추가 페이지");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
//		log.info("univList >>>>>> " + univList);
		
		model.addAttribute("univList",univList);
		
		return "manager/schEmployeeAdd";
	}
	
	// 교직원 번호 자동 입력
	@ResponseBody
	@PostMapping("/schEmNo")
	public String schEmNo(@RequestBody Map<String, Object> map) {
		log.info("교직원 번호 자동 완성" + map);
		
		String schEmNo = this.managerEmpService.schEmNo(map);
//		log.info("교직원 번호 자동 완성 : " + schEmNo);
		
		return schEmNo;
	}
	
	// 교직원 추가
	@ResponseBody
	@PostMapping("/createSchEmAjax")
	public int createSchEmAjax(@RequestBody Map<String, Object> map) {
		log.info("교직원 추가" + map);
		
		int result = this.managerEmpService.createAjax(map);
//		log.info("교직원 추가 : " + result);
		
		return result;
	}
	
	// 교직원 통계
	@GetMapping("/schEmployeeStat")
	public String schEmployeeStat(Model model) throws JsonProcessingException {
		log.info("교직원 통계 페이지");
		
		List<Map<String, Object>> salaryList = this.managerEmpService.salaryList();
//		log.info("salaryList >>>>>>>>>> " + salaryList);
		
		List<Map<String, Object>> univList = this.managerEmpService.univList();
//		log.info("univList >>>>>>>>>> " + univList);
		
		ObjectMapper objectMapper = new ObjectMapper();
        String salaryListJson = objectMapper.writeValueAsString(salaryList);
        String univListJson = objectMapper.writeValueAsString(univList);
//        log.info("salaryListJson >>>>>>>>>> " + salaryListJson);
//        log.info("univListJson >>>>>>>>>> " + univListJson);

        model.addAttribute("salaryListJson", salaryListJson);
        model.addAttribute("univListJson", univListJson);
		
		return "manager/schEmployeeStat";
	}
	
	@GetMapping("/profSalary")
	public String profSalary(Model model) {
//		log.info("학과 별 교수 연봉");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
//		log.info("univList >>>>>> " + univList);
		
		model.addAttribute("univList",univList);
		
		return "manager/profSalary";
	}
	
	@ResponseBody
	@PostMapping("/deptAjax")
	public List<ComDetCodeVO> deptAjax(@RequestBody Map<String, Object> map){
		log.info("deptAjax" + map);
		
		List<ComDetCodeVO> deptList = this.deptMaintenanceService.getDeptList(map);
		log.info("deptList" + deptList);
		
		return deptList;
	}
	
	@ResponseBody
	@PostMapping("/dataAjax")
	public List<ProfessorVO> dataAjax(@RequestBody Map<String, Object> map){
		log.info("dataAjax" + map);
		
		List<ProfessorVO> dataList = this.deptMaintenanceService.getDataList(map);
		log.info("dataList >>> " + dataList);
		
		return dataList;
	}
	
	@GetMapping("/supportCost")
	public String supportCost(Model model) {
		log.info("항목 별 시설 지원 비용(유지비용)");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
		log.info("univList >>> " + univList);
		
		model.addAttribute("univList",univList);
		
		return "manager/supportCost";
	}
	
	@GetMapping("empRate")
	public String empRate(Model model) {
		log.info("학과 별 취업률 페이지");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
		
		model.addAttribute("univList",univList);
		
		return "manager/empRate";
	}
	
	@GetMapping("/admRate")
	public String admRate(Model model) {
		log.info("학과 별 입학 페이지");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
		
		model.addAttribute("univList",univList);
		
		return "manager/admRate";
	}
	
	@GetMapping("/sexRatio")
	public String sexRatio(Model model) {
		log.info("학과 별 성비 페이지");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
		
		model.addAttribute("univList",univList);
		
		return "manager/sexRatio";
	}
	
	@GetMapping("/stuStat")
	public String stuStat(Model model) {
		log.info("학과 별 학생상태 페이지");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
		
		model.addAttribute("univList",univList);
		
		return "manager/stuStat";
	}
	
	@GetMapping("/graRate")
	public String graRate(Model model) {
		log.info("학과 별 졸업률 페이지");
		
		List<ComCodeVO> univList = this.adminStudentService.getCollege();
		
		model.addAttribute("univList",univList);
		
		return "manager/graRate";
	}
	
	//=================================================수빈씨 구역 시작
		@GetMapping("/schduleList")
		public ModelAndView schduleList(ModelAndView mv) {
			log.info("학사일정 조회");
			
			mv.setViewName("manager/schduleList");
			
			return mv;
		}
		
		@ResponseBody
		@GetMapping("/getschduleList")
		public List<ScheduleVO> getschduleList(){
			
			List<ScheduleVO> getschduleList = this.managerEmpService.getScheduleList();
			
			return getschduleList;
		}
		
		/**
		 * 학사 일정 추가 메소드
		 * @param map
		 * @param auth
		 * @return
		 */
		@ResponseBody
		@PostMapping("/insertSchedule")
		public int insertSchedule(@RequestBody Map<String, Object> map, Authentication auth){
			String userNo = auth.getName();
			map.put("userNo", userNo);
			
			int result = this.managerEmpService.insertSchedule(map);
			
			return result;
		}
		
		
		/**
		 * 학사 일정 삭제 메소드
		 * @param map
		 * @return
		 */
		@ResponseBody
		@PostMapping("/deleteSchedule")
		public int deleteSchedule(@RequestBody Map<String, String> map){
			
			Object scheNoObj = map.get("scheNo");
			String scheNo = "";
			int result = 0;
			
			// 캘린더 학사 일정 번호가 없을 때(만들자 마자 삭제할 때)
			if(scheNoObj.equals("0")) {
				// 방금 들어간 scheNo(마지막 번호) 구해오기
				scheNo = this.managerEmpService.getScheNo();
				
				result += this.managerEmpService.deleteScheduleString(scheNo);
			} else {
				result += this.managerEmpService.deleteSchedule(map);
			}
			
			log.info("삭제 결과 >>>>>>> " + result);
			return result;
		}
		
		
		@GetMapping("/schduleDetail")
		public String schduleDetail() {
			log.info("학사일정 상세보기, 삭제");
			
			return "manager/schduleDetail";
		}
	//=================================================수빈씨 구역 끝

}
