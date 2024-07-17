package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.StudentCheckMapper;
import kr.or.ddit.service.StudentCheckService;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StudentCheckServiceImpl implements StudentCheckService{
	
	@Autowired
	StudentCheckMapper studentCheckMapper; 
	
	// 목록 뷰 
	public List<StudentVO> list(Map<String, Object>map){
		return this.studentCheckMapper.list(map);
	}
	
	@Override
	public StudentVO stdDetail(StudentVO studentVO) {
		return this.studentCheckMapper.stdDetail(studentVO);

	}

	@Override
	public List<StudentVO> searchList(Map<String, Object> map) {
		log.info("condition >>>>>>>> " + map);
		return this.studentCheckMapper.searchList(map);
	}

	
	//학과 학생 조회
	@Override
	public String stuDeptCode(String proNo) {
		return this.studentCheckMapper.stuDeptCode(proNo);
	}
	
	//학과 코드에 맞는 학생 전체 행수
	@Override
	public int stuGetTotal(Map<String,Object> map) {
		return this.studentCheckMapper.stuGetTotal(map);
	}
	
	//학과 코드에 맞는 학생 출력
	@Override
	public List<StudentVO> stuTotalList(Map<String,Object> map) {
		return this.studentCheckMapper.stuTotalList(map);
	}

	//학과 학생 상세 조회
	@Override
	public StudentVO stuTotalDetail(String stNo) {
		return this.studentCheckMapper.stuTotalDetail(stNo);
	}

	//학과 학생 상세 조회 재학/휴학/자퇴 여부
	@Override
	public String stuStat(String stNo) {
		return this.studentCheckMapper.stuStat(stNo);
	}

}
