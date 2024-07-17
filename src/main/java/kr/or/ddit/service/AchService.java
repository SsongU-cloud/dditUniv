package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AchExeptionVO;
import kr.or.ddit.vo.LecEvalItemVO;
import kr.or.ddit.vo.LecEvaluationVO;
import kr.or.ddit.vo.StuLectureVO;

public interface AchService {
	
	// 신청 학점 (이번학기)
	int appScore(String stNo);
	
	// 취득 학점 (이번학기)
	int achScore(String stNo);
	
	// 평점계(이번학기)
	int ttAvg(String stNo);
	
	// 평점평균(이번학기)
	String avgAch(String stNo);
	
	// 백분율(이번학기)
	int percentage(String stNo);
	
	// 석차(이번학기)
	Map<String, Object> rank(String stNo);
	
	// 수강 강의 목록(이번학기)
	List<StuLectureVO> stuLectureVOList(String stNo);
	
	// 수강 강의 정보 (강의 평가)
	StuLectureVO evalStuLectureVO(String stuLecNo);
	
	// 강의 평가 항목
	List<LecEvalItemVO> lecEvaluationVOList();
	
	// 강의 평가 저장
	int lecEvaluationCreate(List<LecEvaluationVO> lecEvaluationVOList);
	
	// 성적이의신청 등록
	int lecExeptionCreate(AchExeptionVO achExeptionVO);
	
	// 이의신청 목록
	List<AchExeptionVO> achExeptionVOList(String stNo);
	
	// 이의신청 수정
	int lecExUpd(AchExeptionVO achExeptionVO);
	
	// 이의신청 삭제
	int lecExDel(String stuLecNo);

}
