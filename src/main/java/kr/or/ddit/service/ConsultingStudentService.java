package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ConsultingRequestVO;

public interface ConsultingStudentService {

	//상담 신청 조회
	public int getTotal(Map<String, Object> map);

	//상담 신청 조회
	public List<ConsultingRequestVO> list(Map<String, Object> map);

	//상담 내역
	public int getTotalHis(Map<String, Object> map);

	//상담 내역
	public List<ConsultingRequestVO> listHis(Map<String, Object> map);

	//상담 내역 (상세)
	public ConsultingRequestVO consultstudetail(String consulReqNo);

	//상담 수정
	public int updateAjax(ConsultingRequestVO consultingRequestVO);


}
