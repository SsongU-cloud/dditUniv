package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AchExeptionVO;
import kr.or.ddit.vo.LecEvalItemVO;
import kr.or.ddit.vo.LecEvaluationVO;
import kr.or.ddit.vo.StuLectureVO;

public interface AchMapper {
	
	// 신청학점 
	int appScore(String stNo);
	
	// 취득학점
	int achScore(String stNo);
	
	// 평점 계
	int ttAvg(String stNo);
	
	// 평점평균
	String avgAch(String stNo);
	
	// 백분위
	int percentage(String stNo);
	
	// 석차
	Map<String, Object> rank(String stNo);
	
	// 수강 강의 목록(이번학기)
	List<StuLectureVO> stuLectureVOList(String stNo);
	
	// 수강 강의 정보 (강의 평가)
	StuLectureVO evalStuLectureVO(String stuLecNo);
	
	// 강의 평가 항목
	List<LecEvalItemVO> lecEvaluationVOList();
	
	// 강의 평가 등록
	int lecEvaluationCreate(LecEvaluationVO lecEvaluationVO);
	
	// 성적 이의 신청 등록
	int lecExeptionCreate(AchExeptionVO achExeptionVO);

	// 이의신청 목록
	List<AchExeptionVO> achExeptionVOList(String stNo);
	
	// 이의신청 수정
	int lecExUpd(AchExeptionVO achExeptionVO);
	
	// 이의신청 삭제
	int lecExDel(String stuLecNo);
	
}
