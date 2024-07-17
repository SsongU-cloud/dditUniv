package kr.or.ddit.vo;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.util.Defind;
import lombok.Data;

/**
 * @author PC-11
 * 강의자랑게시판 VO
 */
@Data
public class TimeLecutreBoastVO {
//	private int rowNum; 						    //게시글 순서번호
	private String timeLecBoNo;                 // 강의자랑게시글번호
	private String stNo;                        // 작성자아이디
	private String timeLecBoName;               // 강의자랑게시글제목
	private String timeLecBoCon;                // 강의자랑게시글내용
	private int timeViews;                      // 강의자랑조회수
	private String timeLecDate;                   // 강의자랑작성일자
	private int timeLecLike;                    // 강의자랑추천
	private MultipartFile timeLecAttFile;       // 강의자랑첨부파일
	private String timeLecAttFileId;       // 강의자랑첨부파일
	private String timeLecUpdDate;				// 강의자랑수정일자
	private String timeLecDelYn; 	            //게시판 삭제 유무
	
	private StudentVO studentVO;
	private UserInfoVO userInfoVO;
	private List<TimeBoastCommVO> timeBoastCommVOList;
	private List<TimeLectureRecomVO> timeLectureRecomVOList;
	
	public String getTimeLecDateDisplay() {
		String result ="";
//		if(timeLecDate != null) {
//			result = new SimpleDateFormat(Defind.DATE_PATTERN).format(timeLecDate);
//		}
		return result;
	}
}
