package kr.or.ddit.vo;

import lombok.Data;

/**
 * @author PC-11
 * 공통 상세 코드 VO
 */
@Data
public class ComDetCodeVO {
	private String comDetCode;			// 공통 상세 코드
	private String comDetCodeName;		// 상세 코드 명
	private String comDetUseYn;			// 사용 여부
	private String comCode;				// 분류 코드
	private int RNUM; // 번호
	
	private int currentPage;			//페이징 처리를 위함
	
    private String comDetCode1;
    private String comDetCodeName1;
    private String comDetUseYn1;
    private String comCode1;
   
    private String comDetCode2;
    private String comDetCodeName2;
    private String comDetUseYn2;
    private String comCode2;
   
    //=======================================================  신고조회내역_권나현
}
