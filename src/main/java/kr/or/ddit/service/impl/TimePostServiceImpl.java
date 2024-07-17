package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.velocity.runtime.log.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.TimePostMapper;
import kr.or.ddit.service.TimePostService;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.TimeBoastCommVO;
import kr.or.ddit.vo.TimeDeclareVO;
import kr.or.ddit.vo.TimeExchangeBoardVO;
import kr.or.ddit.vo.TimeLectureRecomVO;
import kr.or.ddit.vo.TimeLecutreBoastVO;
import lombok.extern.slf4j.Slf4j;

/**
*
* @author PC-31
* 신고 조회 내역_권나현
*/

@Slf4j
@Service
public class TimePostServiceImpl implements TimePostService {
	
	@Autowired
	TimePostMapper timePostMapper;

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.timePostMapper.getTotal(map);
	}

	@Override
	public List<TimeDeclareVO> list(Map<String, Object> map) {
		return this.timePostMapper.list(map);
	}

	//======================================================= 수빈씨 구역 시작
	@Override
	public int getTotalLecBoa(Map<String, Object> map) {
		return this.timePostMapper.getTotalLecBoa(map);
	}

	@Override
	public List<TimeLecutreBoastVO> timeLecBoastList(Map<String, Object> map) {
		return this.timePostMapper.timeLecBoastList(map);
	}

	@Override
	public int lecBoastViewCnt(Map<String, Object> map) {
		return this.timePostMapper.lecBoastViewCnt(map);
	}

	@Override
	public int lecBoaAddAjax(TimeLecutreBoastVO timeLecutreBoastVO) {
		int result=0;
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		timeLecutreBoastVO.setStNo(stNo);
		result += this.timePostMapper.lecBoaAddAjax(timeLecutreBoastVO);
		return result;
	}

	@Override
	public List<TimeLecutreBoastVO> mostLikeList() {
		return this.timePostMapper.mostLikeList();
	}

	@Override
	public TimeLecutreBoastVO lecBoaDetail(Map<String, Object> map) {
		return this.timePostMapper.lecBoaDetail(map);
	}

	@Override
	public int lecBoaDelete(TimeLecutreBoastVO timeLecutreBoastVO, Authentication auth) {
		int result =0;
		timeLecutreBoastVO.setStNo(auth.getName());
		result += this.timePostMapper.lecBoaDelete(timeLecutreBoastVO);
		return result;
	}
	
	@Transactional
	@Override
	public int likeDelCnt(TimeLectureRecomVO timeLectureRecomVO) {
		int result = 0;
		result += this.timePostMapper.likeDelCnt(timeLectureRecomVO);
		result += this.timePostMapper.boaLikeDelete(timeLectureRecomVO);
		return result;
	}

	@Transactional
	@Override
	public int likeInsert(TimeLectureRecomVO timeLectureRecomVO) {
		int result = 0;
		result += this.timePostMapper.likeInsert(timeLectureRecomVO);
		result += this.timePostMapper.boaLikeUpdate(timeLectureRecomVO);
		log.info("result>>{}",result);
		return result;
	}

	@Override
	public List<TimeLectureRecomVO> likeList(TimeLectureRecomVO timeLectureRecomVO) {
		return this.timePostMapper.likeList(timeLectureRecomVO);
	}

	@Override
	public List<TimeBoastCommVO> timeBoastComm(TimeBoastCommVO timeBoastCommVO) {
		return this.timePostMapper.timeBoastComm(timeBoastCommVO);
	}

	@Override
	public int timeBoastCommInsert(TimeBoastCommVO timeBoastCommVO) {
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		timeBoastCommVO.setStNo(stNo);
		return this.timePostMapper.timeBoastCommInsert(timeBoastCommVO);
	}

	@Override
	public int timeBoastCommDelete(TimeBoastCommVO timeBoastCommVO) {
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		timeBoastCommVO.setStNo(stNo); 
		return this.timePostMapper.timeBoastCommDelete(timeBoastCommVO);
	}

	@Override
	public TimeLecutreBoastVO updateMode(TimeLecutreBoastVO timeLecutreBoastVO) {
		return this.timePostMapper.updateMode(timeLecutreBoastVO);
	}

	@Override
	public int lecBoaUpdate(TimeLecutreBoastVO timeLecutreBoastVO) {
		String stNo = SecurityContextHolder.getContext().getAuthentication().getName();
		timeLecutreBoastVO.setStNo(stNo);
		return this.timePostMapper.lecBoaUpdate(timeLecutreBoastVO) ;
	}

	@Override
	public TimeLecutreBoastVO detailMode(TimeLecutreBoastVO timeLecutreBoastVO) {
		return this.timePostMapper.detailMode(timeLecutreBoastVO);
	}
	@Override
	public List<ComDetCodeVO> declarationComDetCode(String comCode) {
		return this.timePostMapper.declarationComDetCode(comCode);
	}
	@Override
	public int lecBoaDeclaration(TimeDeclareVO timeDeclareVO) {
		return this.timePostMapper.lecBoaDeclaration(timeDeclareVO);
	}
	@Override
	public List<TimeDeclareVO> timeBoastCommDeclare(TimeDeclareVO timeDeclareVO) {
		return this.timePostMapper.timeBoastCommDeclare(timeDeclareVO);
	}
	@Override
	public List<TimeLecutreBoastVO> lecutreBoastAdminAjax(Map<String, Object> map) {
		return this.timePostMapper.lecutreBoastAdminAjax(map);
	}
	@Override
	public List<TimeLecutreBoastVO> mostLikeListAdmin() {
		return this.timePostMapper.mostLikeListAdmin();
	}
	@Override
	public List<TimeLecutreBoastVO> timeLecBoastAdminList(Map<String, Object> map) {
		return this.timePostMapper.timeLecBoastAdminList(map);
	}
	@Override
	public int getTotalLecBoaAdmin(Map<String, Object> map) {
		return this.timePostMapper.getTotalLecBoaAdmin(map);
	}
	@Override
	public int lecBoaAdminBlindUpdateY(TimeLecutreBoastVO timeLecutreBoastVO) {
		return this.timePostMapper.lecBoaAdminBlindUpdateY(timeLecutreBoastVO);
	}
	@Override
	public int lecBoaAdminCommBlindUpdateY(TimeBoastCommVO timeBoastCommVO) {
		return this.timePostMapper.lecBoaAdminCommBlindUpdateY(timeBoastCommVO);
	}
	@Override
	public List<TimeBoastCommVO> timeBoastCommAdmin(TimeBoastCommVO timeBoastCommVO) {
		return this.timePostMapper.timeBoastCommAdmin(timeBoastCommVO);
	}

	//======================================================= 수빈씨 구역 끝
	
	
	
	//======================================================= 유진씨 구역 시작

	//강의 거래 게시글 전체 행수
	@Override
	public int getTotalExc(Map<String, Object> map) {
		return this.timePostMapper.getTotalExc(map);
	}

	//강의 거래 목록(양도)
	@Override
	public List<TimeExchangeBoardVO> exchaBoard(Map<String, Object> map) {
		return this.timePostMapper.exchaBoard(map);
	}

	//강의 거래 목록(구함)
	@Override
	public List<TimeExchangeBoardVO> exchaBoardWan(Map<String, Object> map) {
		return this.timePostMapper.exchaBoardWan(map);
	}

	//학생 강의 거래 게시글 상세
	@Override
	public TimeExchangeBoardVO excBoaDetail(String timeExBNo) {
		return this.timePostMapper.excBoaDetail(timeExBNo);
	}

	//강의 거래 목록(양도)
	@Override
	public List<TimeExchangeBoardVO> exchaBoardAdmin(Map<String, Object> map) {
		return this.timePostMapper.exchaBoardAdmin(map);
	}

	//강의 거래 목록(구함)
	@Override
	public List<TimeExchangeBoardVO> exchaBoardWanAdmin(Map<String, Object> map) {
		return this.timePostMapper.exchaBoardWanAdmin(map);
	}

	//강의 거래 게시글 전체 행수 (관리자)
	@Override
	public int getTotalExcAdmin(Map<String, Object> map) {
		return this.timePostMapper.getTotalExcAdmin(map);
	}

	//강의 거래 게시글 상세
	@Override
	public TimeExchangeBoardVO excBoaDetailAdmin(String timeExBNo) {
		return this.timePostMapper.excBoaDetailAdmin(timeExBNo);
	}

	//관리자 블라인드 처리
	@Override
	public int deleteAdminAjax(String timeExBNo) {
		return this.timePostMapper.deleteAdminAjax(timeExBNo);
	}

	//======================================================= 유진씨 구역 끝
}
