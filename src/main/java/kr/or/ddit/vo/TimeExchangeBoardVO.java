package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 타임 강의 거래 게시판
 */
@Data
public class TimeExchangeBoardVO {
	private String rn;						// 출력 번호
	
	private String timeExBNo;				// 거래게시글번호
	private String timeExDiv;				// 거래게시글구분
	private String stNo;					// 학번
	private String timeExName;				// 거래게시글제목
	private String timeExCon;				// 거래게시글내용
	private int timeExViews;				// 거래게시글조회수
	private String timeExDate;				// 거래게시글작성일자
	private String timeExDateTime;			// 거래게시글작성시간
	private String timeExStat;				// 거래상태
	private MultipartFile timeExFile;		// 첨부파일
	private String timeExDelYn;				// 거래게시글삭제여부
	private String timeExUpdDate;			// 거래게시글 수정일자
	private String timeExUpdDateTime;		// 거래게시글 수정시간
	
	private UserInfoVO userInfoVOList;		// 사용자 관리
}
