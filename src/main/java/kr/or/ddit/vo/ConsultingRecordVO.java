package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 상남 내역 VO
 */
@Data
public class ConsultingRecordVO {
	private String conNo;		// 상담 번호
	private String conReqNo;	// 상담 신청 번호
	private String proNo;		// 교수 번호
	private String conCont;		// 상담 내역
	
	private UserInfoVO userInfoVOMap;       				// 사용자 관리
	private ConsultingRequestVO consultingRequestVOMap;       // 상담기록(상담번호,상담신청번호,교수번호,상담내역)
	private StudentVO studentVOMap;                         // 학생관리
	private ProfessorVO professorVOMap;                     // 교수관리
	
}
