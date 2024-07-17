package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 타임 신고 내역 VO
 */
@Data
public class TimeDeclareVO {
	private String rn;           	      // 화면에 보여주는 용 번호
	
	private String timeDeno;              // 신고 번호
	private String timeDereason;          // 신고 사유
	private String timeBDiv;              // 게시글 구분 코드
	private String timeDeBNo;             // 신고글 번호
	private String timeDeUrl;             // 신고글 URL
	private String timeDeId;			  // 신고자 ID
	private String timeDeTitle;           // 신고글 제목
	private String timeDeDate;            // 신고글 작성일
	
	private UserInfoVO userInfoVOMap;     // 사용자 관리
	private ComCodeVO  comCodeVOMap;      // 공통분류코드(게시판구분,신고사유)
	private ComDetCodeVO comDetCodeVOMap; // 공통상세코드(게시판구분,신고사유)
	
}
