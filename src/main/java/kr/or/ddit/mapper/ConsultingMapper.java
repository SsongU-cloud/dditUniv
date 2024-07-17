package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ConsultingRequestVO;

public interface ConsultingMapper {
	
	//총
	public int getTotal(Map<String, Object> map);

	//목록
	public List<ConsultingRequestVO> list(Map<String, Object> map);
	
	//신청(담당교수이름)
	public String create(String stNo);

	//신청
	public int createAjax(ConsultingRequestVO consultingRequestVO);
	
	//상세
	public ConsultingRequestVO detail(String consulReqNo);
	
	

}
