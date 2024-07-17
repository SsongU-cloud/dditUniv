package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 학생 상태 이력 VO
 */
@Data
public class StudentStatVO {
	private String stStat;					// 학생 상태
	private String stNo;					// 학번
	private String stDate;					// 접수 일자
	private String stSitu;					// 승인 상태
	private String stSituDate;				// 승인 상태 변경 일자
	private String stSituEndDate;				// 종료 예정 일자
	private String comAttMId;		// 첨부파일
	private String stSituStDate;				// 상태 시작 일자
	private String stSituAppCon;			// 상태 신청 사유
	private String stSituAppFUpdDate;			// 상태 신청 최종 수정 일자
	private ComAttachDetVO comAttachDetVO;
	private ComAttachFileVO comAttachFileVO;
	private int seqrest; //시퀀스
	
	private MultipartFile picture; // 휴학신청 첨부파일
	
}
