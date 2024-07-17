package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ComAttachDetVO;
import kr.or.ddit.vo.RecruitmentVO;

public interface RecruitmentMapper {
	public int recruitmentTotal(Map<String, Object> map);

	public List<RecruitmentVO> recruitmentVOList(Map<String, Object> map);

	public String adminName(String userNo);

	public String fileIdEndNum();

	public int reCreateAjax(RecruitmentVO recruitmentVO);

	public RecruitmentVO recDetail(Map<String, Object> map);

	public int recrDeleteAjax(Map<String, Object> map);

	public int viewCnt(Map<String, Object> map);

	public int recrUpdateAjax(RecruitmentVO recruitmentVO);

//	public int recrUpdateFileDelete(ComAttachDetVO comAttachDetVO);

	public int recrUpdateFileDelete(Map<String, Object> map);

	public int recrUpdateDetFileDelete(Map<String, Object> map);
}
