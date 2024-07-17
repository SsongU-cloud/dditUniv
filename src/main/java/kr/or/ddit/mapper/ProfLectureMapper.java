package kr.or.ddit.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AchExeptionVO;
import kr.or.ddit.vo.AchievementVO;
import kr.or.ddit.vo.AssigSituVO;
import kr.or.ddit.vo.AttendanceVO;
import kr.or.ddit.vo.BuildingInfoVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.LecTimeVO;
import kr.or.ddit.vo.LectureDetailVO;
import kr.or.ddit.vo.LectureRoomVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StuTestResVO;

public interface ProfLectureMapper {            
	// 단과대 리스트
	List<ComCodeVO> collegeList();
	
	// 학과 리스트
	List<ComDetCodeVO> deptList(String collegeCode);
	
	// 건물 리스트 
	List<BuildingInfoVO> buildList();
	
	// 건물 검색 리스트
	List<BuildingInfoVO> buildSearchList(String buildSeaWord);
	
	// 강의실 리스트
	List<LectureRoomVO> buildChoice(Map<String, Object> param);
	
	// 강의 등록
	int lecCreate(LectureVO lectureVO);
	
	// 첨부파일 컬럼 값 넣으려고 가져오는..
	String comAttMId();
	
	// 강의 시간 등록
	int lecTimeCreate(LecTimeVO lecTimeVO);
	
	// 강의 디테일 등록
	int lecDetCreate(LectureDetailVO lecturDetailVO);
	
	// 강의 계획서 (전체 학기)
	List<LectureVO> lectureList(Map<String, Object> map);
	
	// 강의 계획서 목록 갯수(페이징)
	int achListPCnt(String proNo);
	
	// 강의 내역 (이번 학기)
	List<LectureVO> lecList(Map<String, Object> map);
	
	// 강의 내역 목록 갯수
	int lecListPCnt(String proNo);
	
	// 강의 상세 회차, 회차별 상세 내용
	List<LectureDetailVO> lecDetail(String lecNo);
	
	// 현재 강의 목록 (성적 등록을 위한 목록 출력)
	List<LectureVO> achiLectureList(String proNo);
	
	// 현재 강의 정보
	LectureVO achLectureDetail(String lecNo);

	// 수강생 목록(성적등록)
	List<StuLectureVO> stuLetureList(String lecNo);
	
	// 과제 점수 등록 확인
	int assigChk(StuLectureVO stuLectureVO);
	
	// 과제 점수 등록
	int assigInsert(AssigSituVO assigSituVO);
	
	// 기존에 등록되어있는 과제 점수 확인
	int beforeAsScore(AssigSituVO assigSituVO);
	
	// 과제 점수 업데이트
	int assigUpdate(AssigSituVO assigSituVO);
	
	// 중간 점수 등록 확인
	int middleTChk(StuLectureVO stuLectureVO);
	
	// 중간 점수 등록
	int middleInsert(StuTestResVO stuTestResVO);
	
	// 기존 중간 점수 
	int beforeMiddle(StuTestResVO stuTestResVO);
	
	// 중간 점수 수정
	int middleUpdate(StuTestResVO stuTestResVO);
	
	// 기말 점수 등록 여부 확인
	int endTChk(StuLectureVO stuLectureVO);
	
	// 기말 점수 등록
	int endInsert(StuTestResVO stuTestResVO);
	
	// 기존 기말 점수
	int beforeEnd(StuTestResVO stuTestResVO);
	
	// 기말 점수 업데이트
	int endUpdate(StuTestResVO stuTestResVO);
	
	// 총점 등록 여부 확인
	int ttScoreChk(StuLectureVO stuLectureVO);
	
	// 총점 등록
	int achievementInsert(AchievementVO achievementVO);
	
	// 기존 총점 등급
	String beforeAhcGrade(AchievementVO achievementVO);
	
	// 총점 수정
	int achievementUpdate(AchievementVO achievementVO);
	
	// 이의신청 목록 
	List<AchExeptionVO> achExeptionVOList(String proNo);
	
	// 이의신청 학생 성적
	StuLectureVO achExepDetail(String stuLecNo);
	
	// 이의 신청 답변, 상태 변경
	int achExepStatUpdate(AchExeptionVO achExeptionVO);
	//======================================================= 다희씨 구역 끝
	
	
	//=======================================================  수빈씨 구역 시작
	List<LectureVO> LectureVOList(String proNo);

	StuLectureVO stuLectureCount(StuLectureVO stuLectureVOCount);

	List<StuLectureVO> attendStuList(Map<String, Object> map);

	int attendanceInsert(AttendanceVO attendanceVO);

	List<StuLectureVO> nowAttendStudList(Map<String, Object> nowStudentListParams);
	
	List<AttendanceVO> nowAttendStudComCode(Map<String, Object> nowStudentListParams);
	
	List<ComCodeVO> attendanceComCode(String comCode);
	
	List<AttendanceVO> attStudList(Map<String, Object> map);
	//당일 출석에 대한 강의 리스트
	List<StuLectureVO> nowlecNoList(Map<String, Object> nowAttData);
	//수빈씨 구역 end
	
	//======================================================= 유진씨 구역 시작
	
	//수강 학생 조회 전 교수의 강의 목록 리스트
	List<LectureVO> stuList(String proNo);
	
	//특정 강의에 대한 학생 목록 전체 행수
	int stuGetTotal(Map<String, Object> map);

	//특정 강의에 대한 학생 목록
	List<LectureVO> stuDetail(Map<String, Object> map);

	

	

	


	//======================================================= 유진씨 구역 시작
}
