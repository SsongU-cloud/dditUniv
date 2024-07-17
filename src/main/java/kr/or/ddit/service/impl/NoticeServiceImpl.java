package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.NoticeMapper;
import kr.or.ddit.service.NoticeService;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.AnswerVO;
import kr.or.ddit.vo.QuestionVO;
import lombok.extern.slf4j.Slf4j;

/**
 * @author PC-10
 * 문의사항
 */
@Service
@Slf4j
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	NoticeMapper noticeMapper;
	
	@Autowired
	UploadUtils uploadUtils;
	
	//총 행의 개수
	@Override
	public int getTotal(Map<String,Object> map) {
		System.out.println("getTotal >> NoticeServiceImpl : " + map);
		return this.noticeMapper.getTotal(map);
	}
	
	//문의사항 리스트
	@Override
	public List<QuestionVO> noticeList(Map<String,Object> map) {
		return this.noticeMapper.noticeList(map);
	}

	//문의사항 상세화면
	@Override
	public QuestionVO noticeDetail(String queNo) {
		return this.noticeMapper.noticeDetail(queNo);
	}

	//문의사항 작성
	@Transactional
	@Override
	public int noticeAddPost(QuestionVO questionVO) {
		int result=0;
		
		//로그인 아이디
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		log.info("stNo > " + stNo);
		
		//파일업로드 마지막번호 + 1
		String attEndId = this.noticeMapper.attEndId(stNo);
		log.info("attEndId > " + attEndId);
		
		//문의사항 첨부파일
		MultipartFile[] queAttFile = questionVO.getQueAttFile();
		log.debug("queAttFile : " + queAttFile);
		
		//사번(공지사항 작성자)
		questionVO.setQueUserId(stNo);
		
		//첨부파일이 있는지 없는지 체킹
		/*
		 1. 첨부파일이 없을 때
		  comAttFile[0] : 첫번째 파일의 getOriginalFilename() 이름을 가져와서 length()이름의 길이  : 0
		 2. 첨부파일이 있을 때
		  comAttFile[0] : 첫번째 파일의 getOriginalFilename() 이름을 가져와서 length()이름의 길이  : 0이상
		*/
		if(queAttFile[0].getOriginalFilename().length()>0) {
			//첨부파일마스터ID
			String attachId=stNo+"Notice"+attEndId;  //메소드를 하나 만들어서 +1
			questionVO.setQueAttFileId(attachId);//첨부파일 ID
			//파일첨부 insert
			result+= this.uploadUtils.uploadMulti(queAttFile, attachId);
			log.info("result(3)>"+result);
		}else {//첨부파일이 업을 때
			questionVO.setQueAttFileId(null);
			log.info("questionVO null : " + questionVO);
		}
		
		//기본정보 insert
		log.info("questionVO : " + questionVO);
		result+= noticeMapper.noticeAddPost(questionVO);
		log.info("result(2)>"+result);//result(2)>1
		
		return result;
	}

	//첨부파일
	@Override
	public List<Map<String, Object>> selectFileList(String queNo) {
		return this.noticeMapper.selectFileList(queNo);
	}

	//답글 정보 가져오기
	@Override
	public QuestionVO ansContent(String queNo) {
		return this.noticeMapper.ansContent(queNo);
	}

	//문의사항 수정post
	@Transactional
	@Override
	public int updatePost(QuestionVO questionVO) {
		
		int result =0; //결과값
	    
		// 사용자가 아무파일도 선택하지 않았을 때, 이름도 없고, 사이즈도 0인 파일이 넘어옴
	    // 지금 VO와 DB 컬럼명의 매칭이 이상함(파일 자체랑, 파일URL이랑 구분이 안되고 있음)
		if(questionVO.getQueAttFile()[0].getOriginalFilename().equals("")) {//선택안함
			log.debug("사용자가 아무 파일도 선택하지 않았어용");
			questionVO.setQueAttFileId("ttbang"); // 첨부파일 ID			
		    // 기본정보 update
			noticeMapper.updatePost(questionVO);
		    log.info("updatePost 성공");
		
		}else {
			// 로그인 아이디
			String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
			log.info("stNo>" + stNo); // stNo>A001
			
			// 파일업로드 마지막번호 + 1
			String attEndId = questionVO.getQueNo();
			log.info("attEndId>" + attEndId); // attEndId>95
			
			//일반공지첨부파일
			MultipartFile[] comAttFile = questionVO.getQueAttFile();
			log.info("comAttFile : {}", comAttFile);
			
			// 사용자가 파일을 선택 추가 했어용
		    String attachId = stNo + "Notice" + attEndId; // 메소드를 하나 만들어서 +1
		    log.info("attachId >> {}", attachId);
		    
		    questionVO.setQueUserId(stNo); // 학번
		    questionVO.setQueAttFileId(attachId); // 첨부파일 ID
		    
		    //파일 수정
	    	//1) 기존 파일 삭제
			 this.noticeMapper.uploadFileDelete(attachId);
	    	//2) 파일 등록 
			result += this.uploadUtils.uploadMulti(comAttFile, attachId);
	        log.info("파일 업로드 성공");
	        
	        // 기본정보 update
	        result=noticeMapper.updatePost(questionVO);
	        log.info("updatePost 성공");
		}
		return result;
	}

	//문의사항 삭제
	@Override
	public int deleteAjax(String queNo) {
		return noticeMapper.deleteAjax(queNo);
	}
	
	//답글 작성
	@Override
	public int commentCreateAjax(Map<String, Object> map) {
		return noticeMapper.commentCreateAjax(map);
	}

	//답글 완료 변경
	@Override
	public int queYn(String queNo) {
		return noticeMapper.queYn(queNo);
	}

}
