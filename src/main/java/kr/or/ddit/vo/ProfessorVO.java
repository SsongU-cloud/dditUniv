package kr.or.ddit.vo;


import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 교수 관리 VO
 */

@Data
public class ProfessorVO {
	private String proNo;			// 교수 번호
	private String proAddr;			// 교수 주소
	private String empDate;			// 입사일
	private int salary;				// 연봉
	private String deptCode;		// 학과 코드
	private String proStudy;		// 연구실
	private String proAddrDet;		// 교수 상세 주소
	private int proPostno;			// 교수 우편 번호
	private String proWorkYn;		// 재직 여부
	private String proRetireDate;	// 퇴직일시
	private String proPosition;		// 직급
	private String proEmail;		 //이메일
	private String proState;		 //교수상태
	private String comAttMId;       // 첨부파일아이디
	private String proTel;			//전화번호
	private String proName;			//교수 이름 
	private String deptTemp;		// 교수 아이디 만들 때 쓸 앞 5자리 용도
	
	
	private UserInfoVO userInfoVO;			  //
	private ComCodeVO comCodeVO;			  //
	private ComDetCodeVO comDetCodeVO;		  //
	private ComAttachDetVO comAttachDetVO;    //
	private ComAttachFileVO comAttachFileVO;  //

	private MultipartFile UploadFile;
	private MultipartFile comAttDetFile;

	
}

