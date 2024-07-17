package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AuthorityVO;
import kr.or.ddit.vo.ComAttachDetVO;
import kr.or.ddit.vo.ComAttachFileVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserInfoVO;

public interface ProCheckMapper {

	List<ProfessorVO> searchList(Map<String, Object> map);

	ProfessorVO profDetail(ProfessorVO professorVO);

	int profAddAjax(ProfessorVO professorVO);

	int userInfoAdd(UserInfoVO userInfoVO);
	
	int comAttachFileAdd(ComAttachFileVO comAttachFileVO);
	
	int comAttachDetAdd(ComAttachDetVO ComAttachDetVO);

	String proMaxNo();
	
	// PROFESSOR 테이블 업데이트 
	int updateProfPost(ProfessorVO professorVO);
	//  User 테이블 업데이트 
	int updateUserPost(UserInfoVO userInfoVO);
	//	ComAttachDetVO 테이블 Y /N 수정 
	int updateFilePost(String attachId);
	// 사번 생성 
	String getUserNo(String frontId);

	int profAuthInsert(AuthorityVO authorityVO); 

}
