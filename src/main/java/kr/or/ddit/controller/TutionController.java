package kr.or.ddit.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.mapper.TutionMapper;
import kr.or.ddit.util.ArticlePage;
import kr.or.ddit.util.ArticlePage2;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.DeptTuitionPayVO;
import kr.or.ddit.vo.DivPayTermVO;
import kr.or.ddit.vo.ScolarshipHistoryVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.TuitionListVO;
import kr.or.ddit.vo.TuitionVO;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/tution")
@Slf4j
@Controller
public class TutionController {

	/**
	 * author : 박채연 (등록금/장학금)
	 */

	@Autowired
	TutionMapper tutionmapper;

	// 등록금전체납부(학생) - 조회용
	// 요청URI : /tution/tutionpay
	@GetMapping("/tutionall")
	public String tutionall(Principal principal, Model model) {

		log.info("등록금 전체 납부 페이지에 왔다");
		String stNo = principal.getName();
		
		try {
		DivPayTermVO divTerm = this.tutionmapper.fwsysdate();
		String startdate = divTerm.getDivPayStDate();
		String enddate = divTerm.getDivPayEnDate();
		int term = divTerm.getDivPaySq();
		log.info("현재 상태는 : " + term);
		model.addAttribute("term", term);
		model.addAttribute("startdate", startdate);
		model.addAttribute("enddate", enddate);
		TuitionVO tuitionVO = this.tutionmapper.allpay(stNo);
		model.addAttribute("tuitionVO", tuitionVO);
		log.info("전체 납부 일정은 : " + tuitionVO);}
		// 예외처리 (납부일정 아닐때)
		catch(Exception e) {
			e.printStackTrace();
			return "tution/tutionno";
		}
		

		return "tution/tutionall";
	}

//	@ResponseBody
//	@GetMapping("/tutionall2")
//	public TuitionVO tutionall(Principal principal) {
//
//		log.info("등록금 전체 납부 페이지에 왔다");
//		String stNo = principal.getName();
//
//		
//
//		return tuitionVO;
//	}

	// 등록금전체납부 창 조회(학생) - 조회창 ajax
	@ResponseBody
	@PostMapping("/tutionallview")
	public TuitionVO tuitionallview(Principal principal, @RequestBody String test) {

		log.info("등록금 내기 전 알람창");
		String stNo = principal.getName();
		TuitionVO tuitionVO = this.tutionmapper.allpay(stNo);
		log.info("전체 납부 예정 정보는 : " + tuitionVO);

		return tuitionVO;
	}
 //
	// 등록금 전체납부 진행
	@ResponseBody
	@PostMapping("/tuitionallpay")
	public ResponseEntity<String> tuitionallpay(Principal principal, @RequestBody TuitionVO tuitionVO) {

		int result = 0;
		log.info("등록금 내는 ajax에 왔다");
		log.info("tuitionVO :{} ", tuitionVO);
		String stNo = principal.getName();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stNo", stNo);
		map.put("semester", tuitionVO.getSemester());
		map.put("year", tuitionVO.getYear());
		map.put("tuiCost", tuitionVO.getTuiCost());
		map.put("scolAmount", tuitionVO.getScolAmount()); // 장학금
		map.put("realpay", tuitionVO.getRealpay()); // 실납부액
		log.info("map 은 " + map);

		// 1. tution_pay update
		result += this.tutionmapper.allpay1(map);
		log.info("allpay 1 업데이트 결과" + result);

		// 2. tuition_div_pay insert
		result += this.tutionmapper.allpay2(map);
		log.info("allpay 2 insert 결과" + result);

		// 3. tuition update
		result += this.tutionmapper.allpay3(map);
		log.info("allpay 3 업데이트 결과" + result);

		// 4. SCOLAR_HISTORY
		result += this.tutionmapper.allpay4(map);
		log.info("allpay 4 업데이트 결과" + result);

		ResponseEntity<String> entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);

		return entity;
	}

	// 등록금분할납부(학생) - 전체 납부 기간 이후
	@GetMapping("/tutionpart")
	public String tutionpart(Principal principal, Model model) {

		log.info("분할 납부에 왔다");
		String stNo = principal.getName();
//		try {
//		DivPayTermVO divTerm = this.tutionmapper.fwsysdate();
//		String startdate = divTerm.getDivPayStDate();
//		String enddate = divTerm.getDivPayEnDate();
//		int term = divTerm.getDivPaySq();
//		log.info("현재 상태는 : " + term);
//		model.addAttribute("term", term);
//		model.addAttribute("startdate", startdate);
//		model.addAttribute("enddate", enddate);
//
//		return "tution/tutionpart";
//		}
//		
//		catch(Exception e) {
//			e.getStackTrace();
//			return "tution/tutionno2";
//		}
		
		return "tution/tutionno2";
	}

	// 등록금분할납부(학생) - 전체 납부 기간 이후
	@ResponseBody
	@GetMapping("/tutionpart2")
	public List<TuitionVO> tutionpart2(Principal principal) {

		int result = 0;

		log.info("분할 납부 ajax에 왔다");

		String stNo = principal.getName();
		TuitionVO tuitionVO = new TuitionVO();
		tuitionVO.setStNo(stNo);

		log.info("stNo : " + tuitionVO.getStNo());
		log.info("tuitionVO.getStNo() : " + tuitionVO.getStNo());

		// 화면 조회용
		List<TuitionVO> tuitionVOList = this.tutionmapper.partview(tuitionVO);
		log.info("tuitionVO : " + tuitionVOList);
		
		for (TuitionVO tuitionVO2 : tuitionVOList) {
			
			log.info("tuitionVO.scolarshipHistoryVO : {}", tuitionVO2.getScolarshipHistoryVO());
		}
		

		
		for (TuitionVO tuitionVOList2 : tuitionVOList) {
			result++;
			log.info("tuitionVOList2 : " + tuitionVOList2);
		}

		log.info("결과 data 개수 : " + result);

		return tuitionVOList;
	}

	// 등록금납부내역(학생)
	@GetMapping("/tutionlist")
	public String tutionlist(Principal principal, Model model) {

		String stNo = principal.getName();
		int result = 0;

		log.info("등록금 납부 내역에 왔다");

		// 등록금 납부 내역
		List<TuitionListVO> TuitionList = this.tutionmapper.payList(stNo);
		// 등록금 납부 학생 정보
		StudentVO stuinfo = this.tutionmapper.stuinfo(stNo);
		log.info("TuitionList" + TuitionList);
		log.info("stuinfo" + stuinfo);
		for (TuitionListVO TuitionList2 : TuitionList) {
			result++;
		}

		model.addAttribute("result", result);
		model.addAttribute("stuinfo", stuinfo);
		model.addAttribute("TuitionList", TuitionList);

		return "tution/tutionlist";
	}

	// 등록금 상세 내역 - 납부 모달
	@ResponseBody
	@PostMapping("/tutiondetail")
	public TuitionListVO paydetail(@RequestBody Map<String, Object> map, Principal principal, Model model) {

		log.info("등록금 상세 모달에 왔다");
		String stNo = principal.getName();
//		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stNo", stNo);
		// 가져온 map은 : {semester=2023, year=2, seq=0, stNo=A006}
		log.info("가져온 map은 : " + map);

		TuitionListVO listdetail = this.tutionmapper.paydetail(map);
		log.info("상세 결과는 : " + listdetail);
		model.addAttribute("listdetail", listdetail);

		return listdetail;
	}

	@GetMapping("/scolarship")
	public String scolarship(Principal principal, Model model) {

		return "tution/scolarship";
	}

	// 장학금내역(학생)
	@ResponseBody
	@PostMapping("/scolarship2")
	public List<ScolarshipHistoryVO> scolarshipajax(Principal principal, Model model) {
		log.info("장학금 전체 내역 ajax에 왔다");
		String stNo = principal.getName();

		// 한 학생의 장학금 내역 리스트(전체)
		List<ScolarshipHistoryVO> scolarShipHistoryVOList = this.tutionmapper.list(stNo);

		int result3 = 0;

		// 한 학생의 장학금 내역 건수(전체)
		for (ScolarshipHistoryVO scolarShipHistoryVOList2 : scolarShipHistoryVOList) {
			result3++;
		}
		log.info("result3 : " + result3);
		log.info("scolarShipHistoryVOList : " + scolarShipHistoryVOList);

		// 한 학생의 학과 등록금
		StudentVO depttui = this.tutionmapper.depttui(stNo);
		int depttuipay = depttui.getDeptTuitionPayVO().getDeptTuiPay() / 2;
		log.info("학생의 학과 등록금은 " + depttuipay);

		model.addAttribute("scolarShipHistoryVOList", scolarShipHistoryVOList);

		model.addAttribute("result3", result3);

		return scolarShipHistoryVOList;
	}

	// 장학금내역-조건(학생)
	@ResponseBody
	@PostMapping("/scolarcon")
	public List<ScolarshipHistoryVO> scolarcon(Principal principal,
			@RequestBody ScolarshipHistoryVO scolarshipHistoryVO, Model model) {

		log.info("장학금 조건 조회에 왔다");
		log.info("scolarshipHistoryVO ajax : " + scolarshipHistoryVO);
		String stNo = principal.getName();
		scolarshipHistoryVO.setStNo(stNo);

		int result2 = 0;

		// 한 학생의 조건별 장학금 내역 리스트
		List<ScolarshipHistoryVO> scolarShipConditionVOList = this.tutionmapper.conlist(scolarshipHistoryVO);
		for (ScolarshipHistoryVO scolarShipConditionVOList2 : scolarShipConditionVOList) {
			result2++;
		}

		model.addAttribute("scolarShipConditionVOList", scolarShipConditionVOList);
		model.addAttribute("result2", result2);

		log.info("result2 : " + result2);
		log.info("ajax scolarShipConditionVOList : " + scolarShipConditionVOList);

		return scolarShipConditionVOList;
	}

	// 등록금고지(관리자)
	@GetMapping("/manConfirmation")
	public String tutionadd(Principal principal, Model model) {
		
		log.info("관리자 등록금 고지 페이지에 왔다");
		//로그인 안되었다면 처리
		if(principal == null) {
			return "redirect:/login";
		}
		String stNo = principal.getName();
		List<ComDetCodeVO> deptName = this.tutionmapper.deptname();
		List<ComCodeVO> deptcode = this.tutionmapper.deptcode();
		log.info("deptName" + deptName);
		model.addAttribute("deptName", deptName);
		model.addAttribute("deptcode", deptcode);
		
		return "tution/tutionadd";
	}
	
	// 과마다 select 해서 보여주는 list ajax
	@ResponseBody
	@PostMapping("/deptlist")
	public ArticlePage<DeptTuitionPayVO> deptlist(Principal principal, @RequestBody ComDetCodeVO comDetCodeVO,
			ModelAndView mav, @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun){
		
		int result = 0;
		
		currentPage = comDetCodeVO.getCurrentPage();
		
		log.info("학과별 고지내역 ajax에 왔다");		
		log.info("currentPage : " + currentPage);
		log.info("comDetCodeVO" + comDetCodeVO);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("queGubun", queGubun);
		map.put("comDetCodeName", comDetCodeVO.getComDetCodeName());
		map.put("currentPage", currentPage);
		int retotal = this.tutionmapper.getTotal(map);
		log.info("해당 학과 deptlist retotal" + retotal);
		List<DeptTuitionPayVO> deptlist = this.tutionmapper.deptlist(map);
		for(DeptTuitionPayVO deptlist2 : deptlist) {
			result++;
		}
		log.info("해당 학과 deptlist" + deptlist);
		log.info("결과 갯수 deptlist" + result);
		
		mav.addObject("articlePage", new ArticlePage<DeptTuitionPayVO>(retotal, currentPage, 5, deptlist, keyword, queGubun));
//		mav.addObject("articlePage", new ArticlePage2(retotal, currentPage, 10, deptlist, keyword));
		mav.setViewName("tution/tuitionadd");
		
//		return new ArticlePage<DeptTuitionPayVO>(result, currentPage, 5, deptlist, keyword, queGubun);
		return new ArticlePage<DeptTuitionPayVO>(retotal, currentPage, 10, deptlist, comDetCodeVO.getComDetCodeName(), queGubun);
	}
	
	@ResponseBody
	@PostMapping("/inserttui")
	public ResponseEntity<String> inserttui(Principal principal, @RequestBody DeptTuitionPayVO deptTuitionPayVO){
		
		log.info("등록금 등록 ajax에 왔다");
		log.info("deptTuitionPayVO : " + deptTuitionPayVO);
// 		"year": year,
//		"semester": semester,
//		"comDetCodeName": comDetCodeName,
//		"deptTuiPay": tuipay,
//		"divPayStDate": divPayStDate,
//		"divPayEnDate": divPayEnDate
		int result = 0;
		int result2 = 0;
		String word = "";
		try {
		
		result += this.tutionmapper.inserttui1(deptTuitionPayVO);
		result += this.tutionmapper.inserttui2(deptTuitionPayVO);
		// 학번 list
		List<String> stNoList = this.tutionmapper.findst(deptTuitionPayVO.getComDetCodeName());
		String comDetCode = this.tutionmapper.finddept(deptTuitionPayVO.getComDetCodeName());
		deptTuitionPayVO.setComDetCode(comDetCode);
		
		log.info("stNoList 크기 " + stNoList.size());
		log.info("comDetCode 는 " + comDetCode);
		
		if(stNoList.size() > 0) {
		for(int i=0; i<stNoList.size(); i++) {
			
			// DeptTuitionPayVO deptTuitionPayVO
			word = stNoList.get(i);
			deptTuitionPayVO.setStNo2(word);

			result2 += this.tutionmapper.inserttui3(deptTuitionPayVO);
			
			}
		
		for(int i=0; i<stNoList.size(); i++) {
			word = stNoList.get(i);
			deptTuitionPayVO.setStNo2(word);

			result2 += this.tutionmapper.inserttui4(deptTuitionPayVO);
			
			}
		
		log.info("최종 result2 값 : " + result2);
		
		}
		log.info("최종 result 값 : " + result);
		
		} catch(Exception e) {
			e.printStackTrace();
			
			ResponseEntity<String> entity = new ResponseEntity<String>("ERROR", HttpStatus.BAD_REQUEST);
			return entity;
			
		}
		
		ResponseEntity<String> entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		return entity;
		}

	// 납부내역(관리자)
	@GetMapping("/tutionNotice")
	public String tutionlistadmin() {
		return "tution/tutionlistadmin";
	}
	
	// 과마다 select 해서 보여주는 list ajax
	@ResponseBody
	@PostMapping("/tutionNoticeList")
	public ArticlePage<TuitionListVO> deptlist2(Principal principal, @RequestBody ComDetCodeVO comDetCodeVO,
			ModelAndView mav, @RequestParam(value="currentPage",required=false,defaultValue="1") int currentPage,
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword,
			@RequestParam(value="queGubun", required=false, defaultValue = "") String queGubun){
		
		int result = 0;
		
		currentPage = comDetCodeVO.getCurrentPage();
		
		log.info("학과별 납부내역 ajax에 왔다");		
		log.info("currentPage : " + currentPage);
		log.info("comDetCodeVO" + comDetCodeVO);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("queGubun", queGubun);
		map.put("comDetCodeName", comDetCodeVO.getComDetCodeName());
		map.put("currentPage", currentPage);
		int retotal = this.tutionmapper.getTotal2(map);
		log.info("해당 학과 deptlist retotal" + retotal);
		List<TuitionListVO> deptlist = this.tutionmapper.deptlist2(map);
		for(TuitionListVO deptlist2 : deptlist) {
			result++;
		}
		log.info("해당 학과 deptlist" + deptlist);
		log.info("결과 갯수 deptlist" + result);
		log.info("결과 갯수 retotal" + retotal);
		
		mav.addObject("articlePage", new ArticlePage<TuitionListVO>(retotal, currentPage, 5, deptlist, keyword, queGubun));
//		mav.addObject("articlePage", new ArticlePage2(retotal, currentPage, 10, deptlist, keyword));
		mav.setViewName("tution/tutionlistadmin");
		
//		return new ArticlePage<DeptTuitionPayVO>(result, currentPage, 5, deptlist, keyword, queGubun);
		return new ArticlePage<TuitionListVO>(retotal, currentPage, 10, deptlist, comDetCodeVO.getComDetCodeName(), queGubun);
	}

}
