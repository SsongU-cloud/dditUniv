package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ConsultingMapper;
import kr.or.ddit.service.ConsultingService;
import kr.or.ddit.vo.ConsultingRequestVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ConsultingServiceImpl implements ConsultingService {
	
	@Autowired
	ConsultingMapper consultingMapper;

	//총
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.consultingMapper.getTotal(map);
	}

	//목록
	@Override
	public List<ConsultingRequestVO> list(Map<String, Object> map) {
		return this.consultingMapper.list(map);
	}

	//신청(담당교수이름)
	@Override
	public String create(String stNo) {
		return this.consultingMapper.create(stNo);
	}
	
	//신청
	@Override
	public int createAjax(ConsultingRequestVO consultingRequestVO) {
		
		int result = 0;
		
		//로그인 아이디
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo->" + stNo);
		
		//사번(작성자)
		consultingRequestVO.setStNo(stNo);
		
		//기본정보insert
		log.info("consultingRequestVO : " + consultingRequestVO);
		result += this.consultingMapper.createAjax(consultingRequestVO);
		
		return result;
	}

	//상세
	@Override
	public ConsultingRequestVO detail(String consulReqNo) {
		return this.consultingMapper.detail(consulReqNo);
	}

	

	
}
