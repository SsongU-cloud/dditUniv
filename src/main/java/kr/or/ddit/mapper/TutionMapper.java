package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.DeptTuitionPayVO;
import kr.or.ddit.vo.DivPayTermVO;
import kr.or.ddit.vo.ScolarshipHistoryVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.TuitionListVO;
import kr.or.ddit.vo.TuitionVO;

public interface TutionMapper {

	// 한 학생의 장학금 수혜 내역
	List<ScolarshipHistoryVO> list(String stNo);

	// 학생의 학과별 등록금
	StudentVO depttui(String stNo);

	// 조건별 장학금 수혜 내역
	List<ScolarshipHistoryVO> conlist(ScolarshipHistoryVO scolarshipHistoryVO);

	// 등록금 납부 내역 + 장학금
	List<TuitionListVO> payList(String stNo);

	// 등록금 상세 내역 - 모달
	TuitionListVO paydetail(Map<String, Object> map);

	// 학생 개인 정보 (등록금 상세 모달)
	StudentVO stuinfo(String stNo);

	// 현재 날짜  > 기간
	DivPayTermVO fwsysdate();

	// 전체 납부 목록 리스트 현재 시점만
	TuitionVO allpay(String stNo);

	// 전체납부1 > 업데이트
	int allpay1(Map<String, Object> map);

	
	// 전체납부2 > 인서트
	int allpay2(Map<String, Object> map);

	// 전체납부3 > 업데이트
	int allpay3(Map<String, Object> map);

	// 전체납부 4 > 업데이트
	int allpay4(Map<String, Object> map);

	// 화면 조회
	List<TuitionVO> partview(TuitionVO stNo);

	// 관리자 > 학과 이름 조회
	List<ComDetCodeVO> deptname();

	// 등록금 고지 리스트
	List<DeptTuitionPayVO> deptlist(Map<String, Object> map);

	// 전체 개수
	int getTotal(Map<String, Object> map);

	// 단과대학 이름 조회
	List<ComCodeVO> deptcode();

	// 등록금 고지 추가 1
	int inserttui1(DeptTuitionPayVO deptTuitionPayVO);

	// 등록금 고지 추가 2
	int inserttui2(DeptTuitionPayVO deptTuitionPayVO);

	int getTotal2(Map<String, Object> map);

	List<TuitionListVO> deptlist2(Map<String, Object> map);

	List<String> findst(String comDetCodeName);

	// 등록금 고지 추가 3 > tuition table
	int inserttui3(DeptTuitionPayVO deptTuitionPayVO);


	String finddept(String comDetCodeName);


	int inserttui4(DeptTuitionPayVO deptTuitionPayVO);


	

}
