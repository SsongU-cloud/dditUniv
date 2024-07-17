package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * @author PC-11
 * 출결 관리 VO
 */
@Data
public class AttendanceVO {
	private String stuLecNo;	// 수강 번호
	private String stNo;		// 학번
	private int lecNum;			// 강의 회차
	private String lecDate;		// 강의 요일
	private String lecNo2;		// 강의 번호
	private String attCode;		// 출결코드
	private String attCodeName;		// 출결코드명
	private int maxLecPcs;       //총 강의
	
	private List<LectureDetailVO> lectureDetailVOList;
	private ComDetCodeVO comDetCodeVO;
	
	
}
