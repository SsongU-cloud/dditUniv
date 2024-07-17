package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ConsultingStudentMapper;
import kr.or.ddit.service.ConsultingStudentService;
import kr.or.ddit.vo.ConsultingRequestVO;

@Service
public class ConsultingStudentServiceImpl implements ConsultingStudentService {

	@Autowired
	ConsultingStudentMapper consultingStudentMapper;
	
	//상담 신청 조회
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.consultingStudentMapper.getTotal(map);
	}

	//상담 신청 조회
	@Override
	public List<ConsultingRequestVO> list(Map<String, Object> map) {
		return this.consultingStudentMapper.list(map);
	}

	//상담 내역
	@Override
	public int getTotalHis(Map<String, Object> map) {
		return this.consultingStudentMapper.getTotalHis(map);
	}

	//상담 내역
	@Override
	public List<ConsultingRequestVO> listHis(Map<String, Object> map) {
		return this.consultingStudentMapper.listHis(map);
	}

	//상담 내역 (상세)
	@Override
	public ConsultingRequestVO consultstudetail(String consulReqNo) {
		return this.consultingStudentMapper.consultstudetail(consulReqNo);
	}

	//상담 수정
	@Override
	public int updateAjax(ConsultingRequestVO consultingRequestVO) {
		return this.consultingStudentMapper.updateAjax(consultingRequestVO);
	}



	
}
