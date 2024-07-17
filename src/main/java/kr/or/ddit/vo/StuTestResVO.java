package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 시험 결과 VO
 */
@Data
public class StuTestResVO {
	private int middleTestScore;  // 중간점수
	private int endTestScore;     // 기말점수
	private String stuLecNo;	  // 수강번호
}
