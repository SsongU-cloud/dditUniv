package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 등록금분할납부내역VO
 */
@Data
public class TuitionDivPayVO {
	private int divPaySq;           // 학기
	private String semester;        // 학번
	private String stNo;            // 년도
	private String tuiPayDate;            // 년도
	private int year;               // 분할차수
	private int divPayAmount;       // 등록금분할납부금액
	private String divPayDate;		// 등록금분할납부날짜
	private String divPayDateStr;		// 등록금분할납부날짜
	private long scolAmount; // 장학금 사용금액
	private long divChanges; // 잔액
}
