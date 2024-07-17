package kr.or.ddit.service;

import java.util.List;
import java.util.Map;


import kr.or.ddit.vo.CommonNoticeVO;

public interface CommonNoticeService {

	public int getTotal(Map<String, Object> map);
	
	//목록
	public List<CommonNoticeVO> list(Map<String, Object> map);

	//교수 등록
	public int createPost(CommonNoticeVO commonNoticeVO);
	//관리자 등록
	public int createAdm(CommonNoticeVO commonNoticeVO);
	
	//교수 수정
	public int updatePost(CommonNoticeVO commonNoticeVO);
	//관리자 수정
	public int updateAdm(CommonNoticeVO commonNoticeVO);

	// 삭제 실행
	public int deleteAjax(CommonNoticeVO commonNoticeVO);

	// 조회수
	public int ViewCnt(String comNotNo);

	//학생 상세
	public CommonNoticeVO detailStu(String comNotNo);
	//교수 상세
	public CommonNoticeVO detail(String comNotNo);
	//관리자 상세
	public CommonNoticeVO detailAdm(String comNotNo);

	// 첨부파일
	public List<Map<String, Object>> selectFileList(String comNotNo);





	
}
