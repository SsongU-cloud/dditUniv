package kr.or.ddit.service.impl;


import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.ProCheckMapper;
import kr.or.ddit.service.ProCheckService;
import kr.or.ddit.util.UploadController;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.AuthorityVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.UserInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProCheckServiceImpl implements ProCheckService {

	@Autowired
	ProCheckMapper proCheckMapper;
	
	@Autowired
	UploadUtils uploadUtils;
	@Autowired
	String uploadPath;
	@Autowired
	UploadController uploadController;
	   
	@Autowired
	 PasswordEncoder passwordEncoder;
	@Override
	public List<ProfessorVO> searchList(Map<String, Object> map) {
		log.info("condition >>>>>>>> " + map);
		return this.proCheckMapper.searchList(map);
	}

	@Override
	public ProfessorVO profDetail(ProfessorVO professorVO) {
		return this.proCheckMapper.profDetail(professorVO);
	}
	
	@Transactional
	   @Override
	   public int profAddAjax(ProfessorVO professorVO) {
	      int result=0;
	     	      
	      log.info("professorVO >>>>>>> " + professorVO);
	      String frontId = professorVO.getDeptTemp();
	      String userNo = this.proCheckMapper.getUserNo(frontId);
	      String userPass = this.passwordEncoder.encode(userNo);
	      log.info("UserPass >>>>>>>>>>>>>>>>>>>>>" + userPass);
	      //userInfo 정보 넣기 
	      UserInfoVO userInfoVO = new UserInfoVO();
	     	
	      	userInfoVO.setUserNo(userNo);									//selectkey	
	      	userInfoVO.setUserPass(userPass);
	     	userInfoVO.setUserName(professorVO.getUserInfoVO().getUserName());
	     	userInfoVO.setUserTel(professorVO.getUserInfoVO().getUserTel());//전화번호
	     	userInfoVO.setUserGubun("02");
	     	userInfoVO.setUserBirth(professorVO.getUserInfoVO().getUserBirth());//전화번호
	      log.info("1.)userInfoVO>{}",userInfoVO);
	      
	      
	      result += this.proCheckMapper.userInfoAdd(userInfoVO);
	      // 교수 관리 정보 추가
	        if (professorVO.getProPosition() == null || professorVO.getProPosition().isEmpty()) {
	            professorVO.setProPosition("교수");
	        }	
	        //교수 아이디 셋팅 
	        professorVO.setProNo(userNo);
	        
//	        String proNo = proCheckMapper.proMaxNo();
	        String attachId = "PRO" + userNo + "PROFILE";
	        professorVO.setComAttMId(attachId);
	       result += this.proCheckMapper.profAddAjax(professorVO);
	      //2. 교수 관리
		  log.info("picture orgin name : {}", professorVO.getUploadFile().getOriginalFilename());
	      log.info("picture size : {}", professorVO.getUploadFile().getSize());
	      //파일 추가
	      if(professorVO.getUploadFile().getSize() != 0 && professorVO.getUploadFile().getOriginalFilename() != "") {
	    	  result += uploadController.uploadOne(professorVO.getUploadFile(), attachId);//PROB001PROFILE
	      }
	      
	      // 권한 부여
	      AuthorityVO authorityVO = new AuthorityVO();
	      authorityVO.setAuthority("ROLE_PROFESSOR");
	      authorityVO.setUserNo(userNo);
	      
	      result += this.proCheckMapper.profAuthInsert(authorityVO);	      
	      
	      return result;
	   }

	
	@Override
	public int updateProfPost(ProfessorVO professorVO) {
		log.info("여기까지 오나???" + professorVO);
		int result = 0;
		
		if(professorVO.getUploadFile() == null) {
			result += this.proCheckMapper.updateProfPost(professorVO);
			log.info("2.)updateProfPost>{}",professorVO);
			
			UserInfoVO userInfoVO = new UserInfoVO();
			userInfoVO.setUserNo(professorVO.getProNo());
			userInfoVO.setUserTel(professorVO.getProTel());
			userInfoVO.setUserName(professorVO.getProName());

			result += this.proCheckMapper.updateUserPost(userInfoVO);
		} else {
			log.info("사진 바꿈");
			// com_att_m_id를 가지고 업로드한 파일 Y/N을 Y 변경하는 쿼리문 실행
			String attachId = "PRO" + professorVO.getProNo() + "PROFILE";
			log.info("attachId>>>>>>>>>>>" +attachId );
			result += uploadUtils.allFileDelete(attachId);
			
			log.info("여기는 오나요?????");
	    	result += uploadController.uploadOne(professorVO.getUploadFile(), attachId);//PROB001PROFILE
			
			result += this.proCheckMapper.updateProfPost(professorVO);
			log.info("2.)updateProfPost>{}",professorVO);
			
			UserInfoVO userInfoVO = new UserInfoVO();
			userInfoVO.setUserNo(professorVO.getProNo());
			userInfoVO.setUserTel(professorVO.getProTel());
			userInfoVO.setUserName(professorVO.getProName());
			 
			result += this.proCheckMapper.updateUserPost(userInfoVO);
		}
			
		

		return result;	
	}
}
