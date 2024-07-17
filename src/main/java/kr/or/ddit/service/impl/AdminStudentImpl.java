package kr.or.ddit.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.dao.AdminStudentDao;
import kr.or.ddit.service.AdminStudentService;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.AuthorityVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentStatVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserInfoVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AdminStudentImpl implements AdminStudentService{

	@Autowired
	AdminStudentDao adminStudentDao;
	
	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	UploadUtils uploadUtils;
	
	@Override
	public List<ComDetCodeVO> deptList() {
		return this.adminStudentDao.deptList();
	}

	@Override
	public List<StudentVO> stdList(Map<String, Object> map) {
		return this.adminStudentDao.stdList(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.adminStudentDao.getTotal(map);
	}

	@Override
	public StudentVO detail(String stNo) {
		return this.adminStudentDao.detail(stNo);
	}

	@Override
	public int updateStd(StudentVO studentVO) {
		log.info("여기까지 오나요?");
		int result = 0;
		
		String stNo = studentVO.getStNo();
		log.info("학번 체킁 >>> " + stNo);
		
		if(studentVO.getUploadFile() == null) {
			log.info("사진 안바꿈");
			// userInfo 테이블 업데이트
			UserInfoVO userInfoVO = new UserInfoVO();
			userInfoVO.setUserNo(studentVO.getStNo());
			userInfoVO.setUserName(studentVO.getStName());
			userInfoVO.setUserTel(studentVO.getStTel());
			userInfoVO.setUserBirth(studentVO.getStBirth());
			
//			log.info("userInfoVO >>> " + userInfoVO);
			
			result += this.adminStudentDao.updateUserInfo(userInfoVO);

			// student 테이블 업데이트
			result += this.adminStudentDao.updateStd(studentVO);
		} else {
			log.info("사진 바꿈");
			String selectStuAttaNo = this.adminStudentDao.selectStuAttaNo(stNo);
			log.info("stuAttaNo >>>>>>>>> " + selectStuAttaNo);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("stNo", studentVO.getStNo());
			map.put("stuAttaNo", selectStuAttaNo);
			
			log.info("여기까지 오나요? 2트" + map);
			
			result += this.adminStudentDao.delStuFile(map);
			
			if(result > 0) {
				String stuAttaNo = this.adminStudentDao.getStuAttaNo();
				
				MultipartFile uploadFile = studentVO.getUploadFile();
				result += this.uploadUtils.stuAttachFile(uploadFile, stuAttaNo, studentVO.getStNo(), "증명사진");
				
				// userInfo 테이블 업데이트
				UserInfoVO userInfoVO = new UserInfoVO();
				userInfoVO.setUserNo(studentVO.getStNo());
				userInfoVO.setUserName(studentVO.getStName());
				userInfoVO.setUserTel(studentVO.getStTel());
				userInfoVO.setUserBirth(studentVO.getStBirth());
				
				result += this.adminStudentDao.updateUserInfo(userInfoVO);
				
				result += this.adminStudentDao.updateStd(studentVO);
			}
		}
		return result;
	}

	@Override
	public int updateStdStat(Map<String, Object> map) {
		return this.adminStudentDao.updateStdStat(map);
	}

	@Override
	public List<ComCodeVO> getCollege() {
		return this.adminStudentDao.getCollege();
	}

	@Override
	public List<ComDetCodeVO> getDept(Map<String, Object> map) {
		return this.adminStudentDao.getDept(map);
	}

	@Override
	public String getStNo(Map<String, Object> map) {
		return this.adminStudentDao.getStNo(map);
	}


	@Override
	public int stuAdd(StudentVO studentVO) {
		
		int result = 0;

		String stuAttaNo = this.adminStudentDao.getStuAttaNo();
		log.info("stuAttaNo >>>>>> " + stuAttaNo);
		
		if(studentVO.getStGender().equals("male")) {
			studentVO.setStGender("남성");
		} else {
			studentVO.setStGender("여성");
		}
		
		// 사용자 관리 VO
		UserInfoVO userInfoVO = new UserInfoVO();
		userInfoVO.setUserNo(studentVO.getStNo());
		userInfoVO.setUserName(studentVO.getStName());
		userInfoVO.setUserTel(studentVO.getStTel());
		userInfoVO.setUserGubun("01"); // 학생 구분 
		userInfoVO.setEnabled(1);
		userInfoVO.setUserPass(this.passwordEncoder.encode(studentVO.getStNo())); // 초기 비밀번호 = 암호화한 학번
		userInfoVO.setUserBirth(studentVO.getStBirth());
		
		result += this.adminStudentDao.userInfoInsert(userInfoVO);
		
		result += this.adminStudentDao.stuAdd(studentVO);
		
		// 권한 VO
		AuthorityVO authorityVO = new AuthorityVO();
		authorityVO.setAuthority("ROLE_STUDENT");
		authorityVO.setUserNo(studentVO.getStNo());
		
		result += this.adminStudentDao.authAdd(authorityVO);
		
		MultipartFile uploadFile = studentVO.getUploadFile();
		// MultipartFile uploadFile,String stuAttaNo,String stNo,String stuGubun
		result += this.uploadUtils.stuAttachFile(uploadFile, stuAttaNo, studentVO.getStNo(), "증명사진");
		
		StudentStatVO studentStatVO = new StudentStatVO();
		studentStatVO.setStNo(studentVO.getStNo());
		result += this.adminStudentDao.statAdd(studentStatVO);
		
		return result;
	}

	@Override
	public StudentVO getProf(Map<String, Object> map) {
		return this.adminStudentDao.getProf(map);
	}

	@Override
	public List<ProfessorVO> getProfList(Map<String, Object> map) {
		return this.adminStudentDao.getProfList(map);
	}

}
