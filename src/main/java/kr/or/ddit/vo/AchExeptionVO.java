package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 성적이의신청관리 VO
 */
@Data
public class AchExeptionVO {
	private String stuLecNo;			// 수강 번호
	private String achExeptionCon;		// 이의 신청 내용
	private String achExeptionBefore;	// 이의 신청 전 성적
	private String achExeptionAfter;	// 이의 신청 후 성적
	private String achExeptionDate;		// 이의 신청 날짜
	private String achExepStat;			// 이의 신청 승인 상태
    private String achExepAppDate;		// 이의 신청 승인 날짜
    private String achExepAns;			// 이의 신청 답변 
    
    private LectureVO lectureVO;		// 강의정보
    private StuLectureVO stuLectureVO;	// 강의정보
    private UserInfoVO userInfoVO;	// 강의정보
}
