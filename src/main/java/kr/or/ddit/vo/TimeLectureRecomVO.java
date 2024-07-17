package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 강의추천받은내역VO
 */
@Data
public class TimeLectureRecomVO {
	private String timeNo; 			//일렬번호
	private String stNo;			//학번/사번
	private String timeLecBoNo;		//강의자랑게시글번호
}
