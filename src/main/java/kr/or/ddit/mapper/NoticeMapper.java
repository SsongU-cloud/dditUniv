package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.QuestionVO;

/**
 * @author PC-10
 * 문의사항
 */
public interface NoticeMapper {
	
	//전체 행의 수
	public int getTotal(Map<String,Object> map);
		
	//목록 뷰
	public List<QuestionVO> noticeList(Map<String,Object> map);
	
	//문의사항 상세화면
	public QuestionVO noticeDetail(String queNo);

	//파일업로드 마지막번호 + 1
	public String attEndId(String stNo);
	
	//문의사항 작성
	public int noticeAddPost(QuestionVO questionVO);

	//첨부파일
	public List<Map<String, Object>> selectFileList(String queNo);

	//답글 정보 가져오기
	public QuestionVO ansContent(String queNo);

	//문의사항 수정post
	public int updatePost(QuestionVO questionVO);

	//기존 파일 삭제
	public void uploadFileDelete(String attachId);

	//문의사항 삭제
	public int deleteAjax(String queNo);

	//답글 작성
	public int commentCreateAjax(Map<String, Object> map);

	//답글 완료 변경
	public int queYn(String queNo);
}
