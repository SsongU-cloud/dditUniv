package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

/**
 * @author PC-11
 * 장학금 내역 VO
 */
@Data
public class ScolarshipHistoryVO {
	private String scolDNo;			// 장학금 상세 번호
	private String scolMethod;		// 장학금 지급 방식
	private String semester;		// 학기
	private String scolCode;		// 장학금 코드
	private String stNo;			// 학번
	private String scolHiYn; // 사용여부
	private long scolAmount; // 장학금 원래금액
	private long year;
	private int scolarPay; // 장학금 제조
	
	
//	private List<ScolarshipVO> scolarshipVO;
	private ScolarshipVO scolarshipVO;
//	private List<StudentVO> studentVO;
	private StudentVO studentVO;
	
}
