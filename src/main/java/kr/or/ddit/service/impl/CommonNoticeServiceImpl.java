package kr.or.ddit.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.CommonNoticeMapper;
import kr.or.ddit.service.CommonNoticeService;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.CommonNoticeVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CommonNoticeServiceImpl implements CommonNoticeService, Serializable {

	@Autowired
	CommonNoticeMapper commonNoticeMapper;
	
	@Autowired
	UploadUtils  uploadUtils;
	
	
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.commonNoticeMapper.getTotal(map);
	}

	//목록
	@Override
	public List<CommonNoticeVO> list(Map<String, Object> map) {
		return this.commonNoticeMapper.list(map);
	}

	//교수 등록
	@Transactional
	@Override
	public int createPost(CommonNoticeVO commonNoticeVO) {
		
		int result=0;
		
		//로그인 아이디
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo>"+stNo);//stNo>A001
		
		//파일업로드 마지막번호 + 1
		String attEndId = this.commonNoticeMapper.attEndId(stNo);
		log.info("attEndId>"+attEndId);//attEndId>95
		
		//일반공지첨부파일(첨부파일 여부를 체킹하기 위해 미리 처리)
		MultipartFile[] comAttFile= commonNoticeVO.getComAttFile();
		log.info("comAttFile : {}", comAttFile);
		
		//사번(공지사항 작성자)
		commonNoticeVO.setUserNo(stNo);
		
		//첨부파일이 있는지 없는지 체킹
		/*
		 1. 첨부파일이 없을 때
		  comAttFile[0] : 첫번째 파일의 getOriginalFilename() 이름을 가져와서 length()이름의 길이  : 0
		 2. 첨부파일이 있을 때
		  comAttFile[0] : 첫번째 파일의 getOriginalFilename() 이름을 가져와서 length()이름의 길이  : 0이상
		 */
		if(comAttFile[0].getOriginalFilename().length()>0) {
			//첨부파일마스터ID
			String attachId=stNo+"CommonNotice"+attEndId;  //메소드를 하나 만들어서 +1
			commonNoticeVO.setComAttFileId(attachId);//첨부파일 ID
			//파일첨부 insert
			result+= this.uploadUtils.uploadMulti(comAttFile, attachId);
			log.info("result(3)>"+result);
		}else {//첨부파일이 업을 때
			commonNoticeVO.setComAttFileId(null);
			log.info("commonNoticeVO null : " + commonNoticeVO);
		}
		
		//기본정보 insert
		log.info("commonNoticeVO : " + commonNoticeVO);
		result+= commonNoticeMapper.createPost(commonNoticeVO);
		log.info("result(2)>"+result);//result(2)>1
		
		return result;
	}

	//교수 수정
	@Transactional
	@Override
	public int updatePost(CommonNoticeVO commonNoticeVO) {
		int result =0; //결과값
		//commonNoticeMapper.updatePost(commonNoticeVO);
	    
		// 사용자가 아무파일도 선택하지 않았을 때, 이름도 없고, 사이즈도 0인 파일이 넘어옴
	    // 지금 VO와 DB 컬럼명의 매칭이 이상함(파일 자체랑, 파일URL이랑 구분이 안되고 있음)
		if(commonNoticeVO.getComAttFile()[0].getOriginalFilename().equals("")) {//선택안함
			log.debug("사용자가 아무 파일도 선택하지 않았어용");
		    commonNoticeVO.setComAttFileId("ttbang"); // 첨부파일 ID			
		    // 기본정보 update
		    commonNoticeMapper.updatePost(commonNoticeVO);
		    log.info("updatePost 성공");
		
		}else {
			// 로그인 아이디
			String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
			log.info("stNo>" + stNo); // stNo>A001
			
			// 파일업로드 마지막번호 + 1
//			String attEndId = this.commonNoticeMapper.attEndId(stNo);
			String attEndId = commonNoticeVO.getComNotNo();
			log.info("attEndId>" + attEndId); // attEndId>95
			
			//일반공지첨부파일
			MultipartFile[] comAttFile = commonNoticeVO.getComAttFile();
			log.info("comAttFile : {}", comAttFile);
			
			// 사용자가 파일을 선택 추가 했어용
		    String attachId = stNo + "CommonNotice" + attEndId; // 메소드를 하나 만들어서 +1
		    commonNoticeVO.setUserNo(stNo); // 학번
		    commonNoticeVO.setComAttFileId(attachId); // 첨부파일 ID
		    
		    //파일 수정
		    	//1) 기존 파일 삭제
			 this.commonNoticeMapper.uploadFileDelete(attachId);
		    	//2) 파일 등록 
			result += this.uploadUtils.uploadMulti(comAttFile, attachId);
	        log.info("파일 업로드 성공");
	        
	        // 기본정보 update
	        result=commonNoticeMapper.updatePost(commonNoticeVO);
	        log.info("updatePost 성공");
		}
		return result;
	    
	}

	//삭제
	@Transactional
    @Override
    public int deleteAjax(CommonNoticeVO commonNoticeVO) {
        int result = commonNoticeMapper.deleteComAttachDet(commonNoticeVO);
        result += commonNoticeMapper.deleteComAttachFile(commonNoticeVO);
        result += commonNoticeMapper.deleteCommonNotice(commonNoticeVO);
        return result;
	}

	//조회수
	@Override
	public int ViewCnt(String comNotNo) {
		return commonNoticeMapper.ViewCnt(comNotNo);
	}

	//교수 상세
	@Override
	public CommonNoticeVO detail(String comNotNo) {
		return this.commonNoticeMapper.detail(comNotNo);
	}

	//첨부파일
	@Override
	public List<Map<String, Object>> selectFileList(String comNotNo) {
		return this.commonNoticeMapper.selectFileList(comNotNo);
	}

	
	//관리자 등록
	@Transactional
	@Override
	public int createAdm(CommonNoticeVO commonNoticeVO) {
		
		int result=0;
		//로그인 아이디
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo>"+stNo);//stNo>A001
		
		//파일업로드 마지막번호 + 1
		String attEndId = this.commonNoticeMapper.attEndId(stNo);
		log.info("attEndId>"+attEndId);//attEndId>95
		
		//일반공지첨부파일(첨부파일 여부를 체킹하기 위해 미리 처리)
		MultipartFile[] comAttFile= commonNoticeVO.getComAttFile();
		log.info("comAttFile : {}", comAttFile);
		
		//사번(공지사항 작성자)
		commonNoticeVO.setUserNo(stNo);
		
		//첨부파일이 있는지 없는지 체킹
		/*
		 1. 첨부파일이 없을 때
		  comAttFile[0] : 첫번째 파일의 getOriginalFilename() 이름을 가져와서 length()이름의 길이  : 0
		 2. 첨부파일이 있을 때
		  comAttFile[0] : 첫번째 파일의 getOriginalFilename() 이름을 가져와서 length()이름의 길이  : 0이상
		 */
		if(comAttFile[0].getOriginalFilename().length()>0) {
			//첨부파일마스터ID
			String attachId=stNo+"CommonNotice"+attEndId;  //메소드를 하나 만들어서 +1
			commonNoticeVO.setComAttFileId(attachId);//첨부파일 ID
			//파일첨부 insert
			result+= this.uploadUtils.uploadMulti(comAttFile, attachId);
			log.info("result(3)>"+result);
		}else {//첨부파일이 업을 때
			commonNoticeVO.setComAttFileId(null);
			log.info("commonNoticeVO null : " + commonNoticeVO);
		}
		
		//기본정보 insert
		log.info("commonNoticeVO : " + commonNoticeVO);
		result+= commonNoticeMapper.createAdm(commonNoticeVO);
		log.info("result(2)>"+result);//result(2)>1
		
		return result;
	}

	
	//관리자 수정
	@Transactional
	@Override
	public int updateAdm(CommonNoticeVO commonNoticeVO) {
		int result =0; //결과값
	    
		// 사용자가 아무파일도 선택하지 않았을 때, 이름도 없고, 사이즈도 0인 파일이 넘어옴
	    // 지금 VO와 DB 컬럼명의 매칭이 이상함(파일 자체랑, 파일URL이랑 구분이 안되고 있음)
		if(commonNoticeVO.getComAttFile()[0].getOriginalFilename().equals("")) {//선택안함
			log.debug("사용자가 아무 파일도 선택하지 않았어용");
		    commonNoticeVO.setComAttFileId("ttbang"); // 첨부파일 ID			
		    // 기본정보 update
		    commonNoticeMapper.updateAdm(commonNoticeVO);
		    log.info("updateAdm 성공");
		
		}else {
			// 로그인 아이디
			String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
			log.info("stNo>" + stNo); // stNo>A001
			
			// 파일업로드 마지막번호 + 1
//				String attEndId = this.commonNoticeMapper.attEndId(stNo);
			String attEndId = commonNoticeVO.getComNotNo();
			log.info("attEndId>" + attEndId); // attEndId>95
			
			//일반공지첨부파일
			MultipartFile[] comAttFile = commonNoticeVO.getComAttFile();
			log.info("comAttFile : {}", comAttFile);
			
			// 사용자가 파일을 선택 추가 했어용
		    String attachId = stNo + "CommonNotice" + attEndId; // 메소드를 하나 만들어서 +1
		    commonNoticeVO.setUserNo(stNo); // 학번
		    commonNoticeVO.setComAttFileId(attachId); // 첨부파일 ID
		    
		    //파일 수정
		    	//1) 기존 파일 삭제
			 this.commonNoticeMapper.uploadFileDelete(attachId);
		    	//2) 파일 등록 
			result += this.uploadUtils.uploadMulti(comAttFile, attachId);
	        log.info("파일 업로드 성공");
	        
	        // 기본정보 update
	        result=commonNoticeMapper.updateAdm(commonNoticeVO);
	        log.info("updateAdm 성공");
		}
		return result;
	    
	}
	
	//학생 상세
	@Override
	public CommonNoticeVO detailStu(String comNotNo) {
		return this.commonNoticeMapper.detailStu(comNotNo);
	}

	//관리자 상세
	@Override
	public CommonNoticeVO detailAdm(String comNotNo) {
		return this.commonNoticeMapper.detailAdm(comNotNo);
	}
	

}
