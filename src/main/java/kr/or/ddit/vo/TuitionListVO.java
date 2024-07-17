package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

// 등록금 납부내역 list 를 위한 새로운 vo 5개의 테이블
// 박채연

@Data
public class TuitionListVO {

	private int scolar; // 장학금
	private String tuiPayDate;
	private String userName;
	private String comDetCodeName;
	private int RNUM; // 번호
	private int currentPage;			//페이징 처리를 위함
	
	private TuitionPayVO tuitionPayVO; // 등록금 납부 VO 
//	private List<TuitionDivPayVO> tuitionDivPayList; // 등록금 납부 VO 
	private TuitionDivPayVO tuitionDivPayVO; // 등록금 납부 VO 
	private TuitionVO tuitionVO;
	private List<ScolarshipHistoryVO> scolarshipHistoryList;
	private ScolarshipVO scolarshipVO;
	
}

