package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.dao.LectureDao;
import kr.or.ddit.service.LectureService;
import kr.or.ddit.vo.LectureDetailVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StuLecCartVO;
import kr.or.ddit.vo.StuLectureVO;
import kr.or.ddit.vo.StudentVO;

@Service
public class LectureImpl implements LectureService {
	
	@Autowired
	LectureDao lectureDao;
	
	
	/**
	 *	강의 검색
	 */
	@Override
	public List<LectureVO> searchList(Map<String, Object> map) {
		return this.lectureDao.searchList(map);
	}
	
	/**
	 * 강의 리스트
	 */
	@Override
	public List<LectureVO> list() {
		return this.lectureDao.list();
	}

	
	/**
	 * 내 장바구니
	 */
	@Override
	public List<StuLecCartVO> cartList(String stNo) {
		return this.lectureDao.cartList(stNo);
	}

	/**
	 * 관심과목 강의 수
	 */
	@Override
	public int countLec(String stNo) {
		return lectureDao.countLec(stNo);
	}

	/**
	 * 총 수강 학점
	 */
	@Override
	public int sumLecScore(String stNo) {
		return lectureDao.sumLecScore(stNo);
	}
	
	/**
	 * 관심과목 추가
	 */
	@Override
	public int insertCart(Map<String, Object> map) {
		return lectureDao.insertCart(map);
	}

	/**
	 * 관심과목 제거
	 */
	@Override
	public int deleteCart(Map<String, Object> map) {
		return lectureDao.deleteCart(map);
	}

	/**
	 * 전필 학점
	 */
	@Override
	public int junpil(String stNo) {
		return lectureDao.jumpil(stNo);
	}

	/**
	 * 전선 학점
	 */
	@Override
	public int junsun(String stNo) {
		return lectureDao.junsun(stNo);
	}

	/**
	 * 교필 학점
	 */
	@Override
	public int gyopil(String stNo) {
		return lectureDao.gyopil(stNo);
	}

	/**
	 * 교선 학점
	 */
	@Override
	public int gyosun(String stNo) {
		return lectureDao.gyosun(stNo);
	}

	/**
	 * 내 관심과목 조회(수간신청 페이지)
	 */
	@Override
	public List<StuLecCartVO> myLecCart(String stNo) {
		return lectureDao.myLecCart(stNo);
	}

	/**
	 * 수강신청 목록
	 */
	@Override
	public List<StuLectureVO> myLecList(String stNo) {
		return lectureDao.myLecList(stNo);
	}

	/**
	 * 수강 신청 총 학점
	 */
	@Override
	public int lecSum(String stNo) {
		return lectureDao.lecSum(stNo);
	}

	/**
	 * 수강신청 총 갯수
	 */
	@Override
	public int lecCount(String stNo) {
		return lectureDao.lecCount(stNo);
	}

	/**
	 *	수강 신청
	 */
	@Override
	public int insertMyLec(Map<String, Object> map) {
		return lectureDao.insertMyLec(map);
	}

	/**
	 * 수강 취소
	 */
	@Override
	public int delectMyLec(Map<String, Object> map) {
		return lectureDao.deleteMyLec(map);
	}

	/**
	 * 강의 정보
	 */
	@Override
	public List<LectureVO> lecInfo(Map<String, Object> map) {
		return lectureDao.lecInfo(map);
	}

	/**
	 * 내 강의 정보
	 */
	@Override
	public StudentVO myInfo(String stNo) {
		return lectureDao.myInfo(stNo);
	}

	/**
	 * 수강편람 검색
	 */
	@Override
	public List<LectureVO> searchHandbookList(Map<String, Object> map) {
		return lectureDao.searchHandbookList(map);
	}

	/**
	 * 수강편람 디테일
	 */
	@Override
	public LectureVO detailHandbook(Map<String, Object> map) {
		return lectureDao.detailHandbook(map);
	}

	/**
	 * 수강편람 디테일2
	 */
	@Override
	public List<LectureDetailVO> lectureDetailList(Map<String, Object> map) {
		return lectureDao.lectureDetailList(map);
	}

	@Override
	public int totalStudent(Map<String, Object> map) {
		return lectureDao.totalStudent(map);
	}

	@Override
	public List<StuLectureVO> stuLectureList(String stNo) {
		return lectureDao.stuLectureList(stNo);
	}

	
}
