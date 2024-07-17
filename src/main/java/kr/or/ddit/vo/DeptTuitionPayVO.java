package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 등록금 관리 VO
 */
@Data 
public class DeptTuitionPayVO {
	private String deptCode;	// 공통 코드
	private int year;			// 년도
	private int deptTuiPay;		// 등록금액
	private int semester;
	private String comDetCodeName;		// 상세 코드 명
	private int RNUM;
	private String divPayStDate;
	private String divPayEnDate;
	private String stNO;
	private String stNo2;
	private String userName;
	private int currentPage;			//페이징 처리를 위함
	private String comDetCode;
	
	ComDetCodeVO comDetCodeVO; // 학과 코드 (공통 상세 코드 참조)
}	
