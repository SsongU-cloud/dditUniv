package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;

import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.TimeBoastCommVO;
import kr.or.ddit.vo.TimeDeclareVO;
import kr.or.ddit.vo.TimeExchangeBoardVO;
import kr.or.ddit.vo.TimeLectureRecomVO;
import kr.or.ddit.vo.TimeLecutreBoastVO;

/**
*
* @author PC-31
* 신고 조회 내역_권나현
*/

public interface TimePostService {

	public int getTotal(Map<String, Object> map);

	public List<TimeDeclareVO> list(Map<String, Object> map);

	public int getTotalLecBoa(Map<String, Object> map);

	public List<TimeLecutreBoastVO> timeLecBoastList(Map<String, Object> map);

	public int lecBoastViewCnt(Map<String, Object> map);

	public int lecBoaAddAjax(TimeLecutreBoastVO timeLecutreBoastVO);

	public List<TimeLecutreBoastVO> mostLikeList();

	public TimeLecutreBoastVO lecBoaDetail(Map<String, Object> map);

	public int lecBoaDelete(TimeLecutreBoastVO timeLecutreBoastVO, Authentication auth);

	public int likeDelCnt(TimeLectureRecomVO timeLectureRecomVO);

	public int likeInsert(TimeLectureRecomVO timeLectureRecomVO);

	public List<TimeLectureRecomVO> likeList(TimeLectureRecomVO timeLectureRecomVO);

	public List<TimeBoastCommVO> timeBoastComm(TimeBoastCommVO timeBoastCommVO);

	public int timeBoastCommInsert(TimeBoastCommVO timeBoastCommVO);

	public int timeBoastCommDelete(TimeBoastCommVO timeBoastCommVO);

	public TimeLecutreBoastVO updateMode(TimeLecutreBoastVO timeLecutreBoastVO);

	//강의 거래 게시글 전체 행수
	public int getTotalExc(Map<String, Object> map);

	//강의 거래 목록(양도)
	public List<TimeExchangeBoardVO> exchaBoard(Map<String, Object> map);

	//강의 거래 목록(구함)
	public List<TimeExchangeBoardVO> exchaBoardWan(Map<String, Object> map);

	public int lecBoaUpdate(TimeLecutreBoastVO timeLecutreBoastVO);

	public TimeLecutreBoastVO detailMode(TimeLecutreBoastVO timeLecutreBoastVO);

	public List<ComDetCodeVO> declarationComDetCode(String comCode);

	public int lecBoaDeclaration(TimeDeclareVO timeDeclareVO);
	
	public List<TimeDeclareVO> timeBoastCommDeclare(TimeDeclareVO timeDeclareVO);

	//학생 강의 거래 게시글 상세
	public TimeExchangeBoardVO excBoaDetail(String timeExBNo);

	//강의 거래 목록(양도)
	public List<TimeExchangeBoardVO> exchaBoardAdmin(Map<String, Object> map);

	//강의 거래 목록(구함)
	public List<TimeExchangeBoardVO> exchaBoardWanAdmin(Map<String, Object> map);

	//강의 거래 게시글 전체 행수 (관리자)
	public int getTotalExcAdmin(Map<String, Object> map);

	//강의 거래 게시글 상세
	public TimeExchangeBoardVO excBoaDetailAdmin(String timeExBNo);

	//관리자 블라인드 처리
	public int deleteAdminAjax(String timeExBNo);

	public List<TimeLecutreBoastVO> lecutreBoastAdminAjax(Map<String, Object> map);

	public List<TimeLecutreBoastVO> mostLikeListAdmin();

	public List<TimeLecutreBoastVO> timeLecBoastAdminList(Map<String, Object> map);

	public int getTotalLecBoaAdmin(Map<String, Object> map);

	public int lecBoaAdminBlindUpdateY(TimeLecutreBoastVO timeLecutreBoastVO);

	public int lecBoaAdminCommBlindUpdateY(TimeBoastCommVO timeBoastCommVO);

	public List<TimeBoastCommVO> timeBoastCommAdmin(TimeBoastCommVO timeBoastCommVO);

}
