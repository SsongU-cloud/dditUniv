package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 상담 신청 현황 VO
 */
@Data
public class ConsultingRequestVO {
	private String rn;           	      // 화면에 보여주는 용 번호
	private String conrqNo;               // createAjax keyProperty
	private String dayAndTime;			  // 상담예약날짜+시간
	
	private String consulReqNo;				// 상담 신청 번호
	private String stNo;					// 학번
	private String consulReqDate;			// 상담 신청 작성 날짜
	private String consulReqCondition;		// 상담 신청 상태
	private String consulTitle;				// 상담 신청 제목
	private String consulCon;				// 상담 신청 내용
	private String consulReqTime;			// 상담 예약 날짜
	private String consulCateg;				// 상담 카테고리
	
	private UserInfoVO userInfoVOMap;       				// 사용자 관리
	private ConsultingRecordVO consultingRecordVOMap;       // 상담기록(상담번호,상담신청번호,교수번호,상담내역)
	private StudentVO studentVOMap;                         // 학생관리
	private ProfessorVO professorVOMap;                     // 교수관리
}
