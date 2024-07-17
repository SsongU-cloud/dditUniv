package kr.or.ddit.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AchExeptionVO;
import kr.or.ddit.vo.AttendanceVO;
import kr.or.ddit.vo.BuildingInfoVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.LectureDetailVO;
import kr.or.ddit.vo.LectureRoomVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StuLectureVO;

public interface ProfLectureService {

	List<ComCodeVO> collegeList();

	List<ComDetCodeVO> deptList(String collegeCode);
	
	// 건물목록
	List<BuildingInfoVO> buildList();
	
	// 건물 검색 목록
	List<BuildingInfoVO> buildSearchList(String buildSeaWord);
	
	// 강의실목록
	List<LectureRoomVO> buildChoice(Map<String, Object> param);
	
	// 강의 등록
	int lecCreate(LectureVO lectureVO);
	
	// 강의 계획서 목록 (전체 학기 강의)
	List<LectureVO> lectureList(Map<String, Object> map);
	
	// 강의 내역 목록 갯수 ( 페이징 )
	int achListPCnt(String proNo);
	
	// 강의 내역 - 이번 학기 강의 목록
	List<LectureVO> lecList(Map<String, Object> map);
	
	// 강의 상세 회차 , 내용
	List<LectureDetailVO> lecDetail(String lecNo);
	
	// 강의 내역 목록 갯수
	int lecListPCnt(String proNo);
	
	// 현재 학기 강의 목록(성적등록에 출력)
	List<LectureVO> achiLectureList(String proNo);
	
	// 수강생 목록(성적등록에서 사용 - 출결 점수포함 출력)
	List<StuLectureVO> stuLetureList(String lecNo);
	
	// 강의 상세 (성적등록 - 강의 정보)
	LectureVO achLectureDetail(String lecNo);
	
	// 성적 등록
	int achieveInsert(List<StuLectureVO> stuLectureVOList);
	
	// 이의신청 목록
	List<AchExeptionVO> achExeptionVOList(String proNo);
	
	// 이의신청 학생 성적
	StuLectureVO achExepDetail(String stuLecNo);
	
	// 이의신청 승인 시 -> 성적변경
	int achExepUpdate(StuLectureVO stuLectureVO);
	
	// 이의 신청 답변, 상태 변경
	int achExepStatUpdate(AchExeptionVO achExeptionVO);
	//======================================================= 다희씨 구역 끝
	
	
	//=======================================================  수빈씨 구역 시작
	
	List<LectureVO> LectureVOList(String proNo);
	
	List<StuLectureVO> nowlecNoList(Map<String, Object> nowAttData);

	StuLectureVO stuLectureCount(StuLectureVO stuLectureVOCount);
	
	

	List<StuLectureVO> attendStuList(Map<String, Object> map);

	int attendanceInsert(AttendanceVO attendanceVO);

	List<StuLectureVO> nowAttendStudList(Map<String, Object> nowStudentListParams);

	List<ComCodeVO> attendanceComCode(String comCode);

	List<AttendanceVO> attStudList(Map<String, Object> map);
	
	List<AttendanceVO> nowAttendStudComCode(Map<String, Object> nowStudentListParams);
	
	

	//======================================================= 유진씨 구역 시작
	
	//수강 학생 조회 전 교수의 강의 목록 리스트
	List<LectureVO> stuList(String proNo);

	//특정 강의에 대한 학생 목록 전체 행수
	int stuGetTotal(Map<String, Object> map);

	////특정 강의에 대한 학생 목록
	List<LectureVO> stuDetail(Map<String, Object> map);

	
	

	

	//======================================================= 유진씨 구역 끝
}
