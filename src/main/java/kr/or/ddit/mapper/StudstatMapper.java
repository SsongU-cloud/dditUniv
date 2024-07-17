package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.StudentStatVO;
import kr.or.ddit.vo.UserInfoVO;

public interface StudstatMapper {

	
	// 한 학생의 신청 내역 리스트
	List<StudentStatVO> restlist(String stNo);

	// 담당 교수 이름
	UserInfoVO proName(String stNo);

	// 첨부파일 1 추가
	int statatt1(Map<String, Object> map1);

	// 첨부파일 2 추가
	int statatt2(Map<String, Object> map2);

	// 첨부파일 추가 후 휴학상태 추가
	int restall(StudentStatVO studentStatVO);

	// 첨부파일 없이 휴학상태 추가
	int restpart(StudentStatVO studentStatVO);

}
