package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * @author PC-11
 * 과제제출관리 VO
 */
@Data
public class AssigSituVO {
	private String stuLecNo; // 수강번호
	private int assigScore;  // 과제점수
}
