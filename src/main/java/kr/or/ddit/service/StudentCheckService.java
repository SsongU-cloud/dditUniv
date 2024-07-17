package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.StudentVO;

public interface StudentCheckService {
	
	//목록 뷰 
	public List<StudentVO>list(Map<String,Object>map); 
	//상세 뷰 
	public StudentVO stdDetail(StudentVO studentVO);
	
	public List<StudentVO> searchList(Map<String, Object> map);
	
	
	//학과 학생 조회
	public String stuDeptCode(String proNo);
	
	//학과 코드에 맞는 학생 전체 행수
	public int stuGetTotal(Map<String,Object> map);
	
	//학과 코드에 맞는 학생 출력
	public List<StudentVO> stuTotalList(Map<String,Object> map);
	
	//학과 학생 상세 조회
	public StudentVO stuTotalDetail(String stNo);
	
	//학과 학생 상세 조회 재학/휴학/자퇴 여부
	public String stuStat(String stNo);
}
