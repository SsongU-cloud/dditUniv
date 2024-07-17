package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.QuestionVO;

/**
 * @author PC-10
 * 문의사항
 */
public interface NoticeService {
	//총 행의 개수
	public int getTotal(Map<String,Object> map);
	
	//문의사항 리스트
	public List<QuestionVO> noticeList(Map<String,Object> map);

	//문의사항 상세화면
	public QuestionVO noticeDetail(String queNo);

	//문의사항 작성
	public int noticeAddPost(QuestionVO questionVO);

	//첨부파일
	public List<Map<String, Object>> selectFileList(String queNo);

	//답글 정보 가져오기
	public QuestionVO ansContent(String queNo);

	//문의사항 수정post
	public int updatePost(QuestionVO questionVO);

	//문의사항 삭제
	public int deleteAjax(String queNo);

	//답글 작성
	public int commentCreateAjax(Map<String, Object> map);

	//답글 완료 변경
	public int queYn(String queNo);
}
