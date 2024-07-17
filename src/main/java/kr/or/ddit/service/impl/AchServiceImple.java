package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AchMapper;
import kr.or.ddit.service.AchService;
import kr.or.ddit.vo.AchExeptionVO;
import kr.or.ddit.vo.LecEvalItemVO;
import kr.or.ddit.vo.LecEvaluationVO;
import kr.or.ddit.vo.StuLectureVO;

@Service
public class AchServiceImple implements AchService{
	
	@Autowired
	AchMapper achMapper;
	
	// 신청학점
	@Override
	public int appScore(String stNo) {
		return achMapper.appScore(stNo);
	}
	
	// 취득학점
	@Override
	public int achScore(String stNo) {
		return achMapper.achScore(stNo);
	}
	
	//평점계
	@Override
	public int ttAvg(String stNo) {
		return achMapper.ttAvg(stNo);
	}
	
	//평점 평균
	@Override
	public String avgAch(String stNo) {
		return achMapper.avgAch(stNo);
	}
	
	// 백분율
	@Override
	public int percentage(String stNo) {
		return achMapper.percentage(stNo);
	}
	
	// 석차
	@Override
	public Map<String, Object> rank(String stNo) {
		return achMapper.rank(stNo);
	}
	
	// 이번학기 수강목록
	@Override
	public List<StuLectureVO> stuLectureVOList(String stNo) {
		return achMapper.stuLectureVOList(stNo);
	}
	
	// 수강 강의 정보 (강의 평가)
	@Override
	public StuLectureVO evalStuLectureVO(String stuLecNo) {
		return achMapper.evalStuLectureVO(stuLecNo);
	}
	
	// 강의 평가 항목
	@Override
	public List<LecEvalItemVO> lecEvaluationVOList() {
		return achMapper.lecEvaluationVOList();
	}
	
	// 강의 평가 저장
	@Override
	public int lecEvaluationCreate(List<LecEvaluationVO> lecEvaluationVOList) {
		
		int result = 0;
		
		for(LecEvaluationVO lecEvaluationVO : lecEvaluationVOList) {
			result += achMapper.lecEvaluationCreate(lecEvaluationVO);
		}
		
		return 0;
	}
	
	// 성적이의신청 등록
	@Override
	public int lecExeptionCreate(AchExeptionVO achExeptionVO) {
		return achMapper.lecExeptionCreate(achExeptionVO);
	}
	
	// 이의신청 목록
	@Override
	public List<AchExeptionVO> achExeptionVOList(String stNo) {
		return achMapper.achExeptionVOList(stNo);
	}
	
	// 이의신청 수정
	@Override
	public int lecExUpd(AchExeptionVO achExeptionVO) {
		return achMapper.lecExUpd(achExeptionVO);
	}
	
	// 이의신청 삭제
	@Override
	public int lecExDel(String stuLecNo) {
		return achMapper.lecExDel(stuLecNo);
	}
}
