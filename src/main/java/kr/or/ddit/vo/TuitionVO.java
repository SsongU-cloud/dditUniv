package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

/**
 * @author PC-11
 * 등록금 VO
 */
@Data
public class TuitionVO {
	
	private String semester;			// 학번 
	private int year;                   // 학기 
	private String stNo;                // 년도 
	private int tuiCost;                // 등록금금액 
	private Date tuiSchedule;           // 등록금납부기한 
	private String tuiPayYn;            // 등록금완납여부 
	private int scolAmount;				// 장학금(없으면 0)
	private int realpay; // 실납부액
	
	private int divPaySq;           // 학기
	private int divPayAmount;       // 등록금분할납부금액
	private Date divPayDate;		// 등록금분할납부날짜
	private String divPayDateStr;		// 등록금분할납부날짜
	private long divChanges; // 잔액
	
	
	private String divPayStDate;		// 분할 납부 시작 일시
	private String divPayEnDate;		// 분할 납부 종료 일시
	
	private String scolDNo;			// 장학금 상세 번호
	private String scolMethod;		// 장학금 지급 방식
	private String scolCode;		// 장학금 코드
	private String scolHiYn; // 사용여부
	private int scolarPay; // 장학금 제조
	
	
//	private List<ScolarshipVO> scolarshipVO;
	private ScolarshipVO scolarshipVO;
//	private List<StudentVO> studentVO;
	private StudentVO studentVO;
	
	
	private ScolarshipHistoryVO scolarshipHistoryVO;
	private DivPayTermVO divPayTermVO;
	private TuitionDivPayVO tuitionDivPayVO;
}
