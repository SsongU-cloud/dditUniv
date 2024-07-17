package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.CertificateVO;
import kr.or.ddit.vo.RecruitmentVO;
import kr.or.ddit.vo.VolunteerVO;

public interface StudentEmploymentService {

	public List<VolunteerVO> volunteerList(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);

	public int volAddAjax(VolunteerVO volunteerVO);

	public VolunteerVO volDetail(Map<String, Object> map);

	public int volDetailAjax(VolunteerVO volunteerVO);

	public int recruitmentTotal(Map<String, Object> map);

	public List<RecruitmentVO> recruitmentVOList(Map<String, Object> map);

	public int certificateTotal(Map<String, Object> map);
	
	/**
	 * 봉사활동 총 시간
	 * @param stNo 학번/사번
	 * @return
	 */
	public int volTotalTime(String stNo);

	public List<CertificateVO> certificateVOList(Map<String, Object> map);

	public int cerCreateAjax(CertificateVO certificateVO);

	public int cerDeleteAjax(Map<String, Object> map);

	public int cerUpdateAjax(Map<String, Object> map);

	public int certificateCount(String stNo);

	public String adminName(String userNo);

	public int reCreateAjax(RecruitmentVO recruitmentVO);

	public RecruitmentVO recDetail(Map<String, Object> map);

	public int recrDeleteAjax(Map<String, Object> map);

	public int viewCnt(Map<String, Object> map);

	public int recrUpdateAjax(RecruitmentVO recruitmentVO, MultipartFile[] sbFiles);

	public int recrUpdateFileDelete(Map<String, Object> map);

	public int cerValidation(CertificateVO certificateVO);


}
