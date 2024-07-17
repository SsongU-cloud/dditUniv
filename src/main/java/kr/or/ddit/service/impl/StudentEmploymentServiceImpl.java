package kr.or.ddit.service.impl;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.apache.velocity.runtime.directive.Break;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.CertificateMapper;
import kr.or.ddit.mapper.RecruitmentMapper;
import kr.or.ddit.mapper.StudentEmploymentMapper;
import kr.or.ddit.service.StudentEmploymentService;
import kr.or.ddit.service.dao.AttachDao;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.CertificateVO;
import kr.or.ddit.vo.ComAttachDetVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.RecruitmentVO;
import kr.or.ddit.vo.VolunteerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StudentEmploymentServiceImpl implements StudentEmploymentService{
	private String userNo = "";
	@Autowired
	StudentEmploymentMapper studentEmploymentMapper;
	@Autowired
	RecruitmentMapper recruitmentMapper;
	@Autowired
	CertificateMapper certificateMapper;
	@Autowired
	AttachDao attachDao;
	@Autowired
	UploadUtils uploadUtils;
	
	@Override
	public List<VolunteerVO> volunteerList(Map<String, Object> map) {
		return this.studentEmploymentMapper.volunteerList(map);
	}
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.studentEmploymentMapper.getTotal(map);
	}
	@Override
	public int volTotalTime(String stNo) {
		return this.studentEmploymentMapper.volTotalTime(stNo);
				
	}
	@Transactional
	@Override
	public int volAddAjax(VolunteerVO volunteerVO) {
		

		//1)volunteer insert
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		String volNo = this.studentEmploymentMapper.mainNumber();
		volunteerVO.setStNo(stNo);
		volunteerVO.setVolNo(volNo);
		String vonFileStr= stNo+"Volunteer"+volNo;
		volunteerVO.setVolFileStr(vonFileStr);
//		log.info("volunteerVO"+volunteerVO);
		int result = this.studentEmploymentMapper.insertVolunteer(volunteerVO);
		
		//2)attach insert
		 MultipartFile uploadFile=volunteerVO.getVonFile();
		result+=this.uploadUtils.uploadOne(uploadFile, vonFileStr);
		
		return result;
	}
	@Override
	public VolunteerVO volDetail(Map<String, Object> map) {
		return this.studentEmploymentMapper.volDetail(map);
	}
	@Override
	public int viewCnt(Map<String, Object> map) {
		return this.recruitmentMapper.viewCnt(map);
	}
	@Transactional
	@Override
	public int volDetailAjax(VolunteerVO volunteerVO) {
		int result=0;
		//학번/사번
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		volunteerVO.setStNo(stNo);
		log.info("volDetailAjax>volunteerVO:{}",volunteerVO);
		
		MultipartFile ajaxDetailFile = volunteerVO.getVonFile();
		log.info("ajaxDetailFile: {}", ajaxDetailFile);

		if (ajaxDetailFile == null) {
		    // 파일이 없는 경우
			log.info("파일없는경우");
		    return this.studentEmploymentMapper.volUpdateAjax(volunteerVO);
		} else {
			log.info("파일있는경우");
		    // 파일이 있는 경우
			//정보 등록
			result+=this.studentEmploymentMapper.volUpdateAjax(volunteerVO);
			//파일삭제
			result+=this.studentEmploymentMapper.volAttachDetDelAjax(volunteerVO);
			result+=this.studentEmploymentMapper.volAttachFileDelAjax(volunteerVO);
			//파일 등록
			MultipartFile uploadFile=volunteerVO.getVonFile();
//			log.info("attaciId:{}",volunteerVO.getVolFileStr());
			result+=uploadUtils.uploadOne(uploadFile, volunteerVO.getVolFileStr());
			return result;
		}

	}
	/**
	 * 채용정보게시판 총개수
	 */
	@Override
	public int recruitmentTotal(Map<String, Object> map) {
		return this.recruitmentMapper.recruitmentTotal(map);
	}
	@Override
	public List<RecruitmentVO> recruitmentVOList(Map<String, Object> map) {
		return this.recruitmentMapper.recruitmentVOList(map);
	}
	@Override
	public String adminName(String userNo) {
		return this.recruitmentMapper.adminName(userNo);
	}
	/**
	 * 채용정보 post
	 */
	@Override
	public int reCreateAjax(RecruitmentVO recruitmentVO) {
		int result = 0;
		this.userNo = SecurityContextHolder.getContext().getAuthentication().getName();
		//userNo
		recruitmentVO.setUserNo(userNo); // 최조 작성자
		recruitmentVO.setRecuViews(0); // 글 조회수
		recruitmentVO.setRecuEndWriter(userNo);//최종 작성자
		
		//파일 ID 끝 번호
		String fileIdEndNum = this.recruitmentMapper.fileIdEndNum();
		log.info("fileIdEndNum>>{}",fileIdEndNum);
		MultipartFile[] recuAttFile = recruitmentVO.getRecuAttFile();
		
		//1) 파일 있는 경우
		if(recuAttFile  != null && recuAttFile.length>0) {
			
			log.info("recruitmentVO>> {}",recruitmentVO);
			recruitmentVO.setRecuAttFileId(userNo+"Recruitment"+fileIdEndNum);
			result+=this.recruitmentMapper.reCreateAjax(recruitmentVO);
			
			//attach insert
			result += this.uploadUtils.uploadMulti(recuAttFile, recruitmentVO.getRecuAttFileId());
		}
		//2) 파일 없는 경우
		else {
			log.info("파일이 없서용 >>>>") ;
			//recruitment info insert
			log.info("recruitmentVO>> {}",recruitmentVO);
			recruitmentVO.setRecuAttFileId("noFile");
			
			result += this.recruitmentMapper.reCreateAjax(recruitmentVO);
		}
		
		return result;
	}
	
	@Override
	public RecruitmentVO recDetail(Map<String, Object> map) {
		return this.recruitmentMapper.recDetail(map);
	}
	@Override
	public int recrDeleteAjax(Map<String, Object> map) {
		return this.recruitmentMapper.recrDeleteAjax(map);
	}
	@Transactional
	@Override
	public int recrUpdateFileDelete(Map<String, Object> map) {
		int result =0;
		result+=this.recruitmentMapper.recrUpdateDetFileDelete(map);
		result+=this.recruitmentMapper.recrUpdateFileDelete(map);
		return result;
	}
	@Transactional
	@Override
	public int recrUpdateAjax(RecruitmentVO recruitmentVO, MultipartFile[] sbFiles) {
		int result =0;
		//정보 수정하는 경우
//		log.info("userNo>>{}",this.userNo);
		String userId = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("userId>>{}",userId);
		recruitmentVO.setRecuEndWriter(userId);
		
		recruitmentVO.setRecuAttFileId(userId+"Recruitment"+recruitmentVO.getRecuNo());
		
		//이미 존재하는 파일 삭제하는경우
//		if(!recruitmentVO.getComAttachDetVOList().isEmpty()||recruitmentVO.getComAttachDetVOList().size()>0) {
//			log.info("recruitmentVO.get~ >{}",recruitmentVO.getComAttachDetVOList());
//			for(ComAttachDetVO  comAttachDetVO :recruitmentVO.getComAttachDetVOList()) {
//				log.info("ck");
//				comAttachDetVO.setComAttMId(recruitmentVO.getRecuAttFileId());
//				log.info("comAttachDetVO >{}",comAttachDetVO);
//				log.info("comAttachDetVO.getComAttDetNo>>{}",comAttachDetVO.getComAttDetNo());
//				result += this.recruitmentMapper.recrUpdateFileDelete(comAttachDetVO);
//			}
//		}
		
		///새로운 파일 추가하는경우
		if(sbFiles != null && sbFiles.length>0) {
			//기존 파일 삭제
			//recuAttFileId 주기
			result +=this.uploadUtils.allFileDelete(recruitmentVO.getRecuAttFileId());
			//새로운 파일 insert
			result+= this.uploadUtils.uploadMulti(sbFiles, recruitmentVO.getRecuAttFileId());
		}
		log.info("recruitmentVO info>>{}",recruitmentVO);
		result += this.recruitmentMapper.recrUpdateAjax(recruitmentVO);
		return result;
	}
	/**
	 * 학번에 대한 자격증 총개수
	 */
	@Override
	public int certificateCount(String stNo) {
		return this.certificateMapper.certificateCount(stNo);
	}
	/**
	 * 자격증 총개수
	 */
	@Override
	public int certificateTotal(Map<String, Object> map) {
		return this.certificateMapper.certificateTotal(map);
	}
	@Override
	public List<CertificateVO> certificateVOList(Map<String, Object> map) {
		return this.certificateMapper.certificateVOList(map);
	}
	@Override
	public int cerCreateAjax(CertificateVO certificateVO) {
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		certificateVO.setStNo(stNo);
		return this.certificateMapper.cerCreateAjax(certificateVO);
	}
	@Override
	public int cerDeleteAjax(Map<String, Object> map) {
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		return this.certificateMapper.cerDeleteAjax(map);
	}
	@Override
	public int cerUpdateAjax(Map<String, Object> map) {
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		map.put("stNo", stNo);
		return this.certificateMapper.cerUpdateAjax(map);
	}
	@Override
	public int cerValidation(CertificateVO certificateVO) {
		String stNo =SecurityContextHolder.getContext().getAuthentication().getName();
		certificateVO.setStNo(stNo);
		return this.certificateMapper.cerValidation(certificateVO);
	}
	
	
	
	
	
	
	
	
	
	
}
