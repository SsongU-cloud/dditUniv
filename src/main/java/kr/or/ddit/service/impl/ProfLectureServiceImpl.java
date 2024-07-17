package kr.or.ddit.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.ProfLectureMapper;
import kr.or.ddit.service.ProfLectureService;
import kr.or.ddit.util.UploadUtils;
import kr.or.ddit.vo.AchExeptionVO;
import kr.or.ddit.vo.AssigSituVO;
import kr.or.ddit.vo.AttendanceVO;
import kr.or.ddit.vo.BuildingInfoVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.LecTimeVO;
import kr.or.ddit.vo.LectureDetailVO;
import kr.or.ddit.vo.LectureRoomVO;
import kr.or.ddit.vo.LectureVO;
import kr.or.ddit.vo.StuLectureVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProfLectureServiceImpl implements ProfLectureService {
	
	@Autowired
	ProfLectureMapper profLecturetMapper; 
	
	@Autowired
	UploadUtils uploadUtils;
	
	// 단과대 리스트 출력
	@Override
	public List<ComCodeVO> collegeList() {
		return profLecturetMapper.collegeList();
	}
	
	// 선택한 단과대에 속하는 학과 리스트 출력
	@Override
	public List<ComDetCodeVO> deptList(String collegeCode) {
		return profLecturetMapper.deptList(collegeCode);
	}

	@Override
	public List<BuildingInfoVO> buildList() {
		return profLecturetMapper.buildList();
	}
	
	@Override
	public List<BuildingInfoVO> buildSearchList(String buildSeaWord) {
		return profLecturetMapper.buildSearchList(buildSeaWord);
	}
	
	// 강의실 목록 출력
	@Override
	public List<LectureRoomVO> buildChoice(Map<String, Object> param) {
		return profLecturetMapper.buildChoice(param);
	}
	//강의 등록
	@Override
	@Transactional
	public int lecCreate(LectureVO lectureVO) {
		
		// COM_ATT_M_ID 생성할 테이블 번호 가져오기
		String lecNo = profLecturetMapper.comAttMId();
		String proNo = lectureVO.getProNo();
		String comAttMId = proNo+"lecture"+lecNo;
		log.info("comAttMId >>>>>>> {}", comAttMId);
		
		// COM_ATTACH_FILE 테이블에 추가 + 파일 업로드
		MultipartFile lecFile = lectureVO.getLecFile();
		int result = uploadUtils.uploadOne(lecFile, comAttMId);
		log.info("lecCreate>>uploadController : {}", result);
		
		// lecture 테이블에 insert
		lectureVO.setFileName(comAttMId);
		result += profLecturetMapper.lecCreate(lectureVO);
		log.info("lecCreate>>lecture insert : {}", result);
		
		// lecture_time 테이블에 insert
		List<LecTimeVO> lecTimeVOList = lectureVO.getLecTimeVOList();
		for(LecTimeVO lecTimeVO : lecTimeVOList) {
			result += profLecturetMapper.lecTimeCreate(lecTimeVO);
		}
		log.info("lecCreate>>lecture_time insert : {}", result);
		
		// lecture_detail 테이블에 insert
		List<LectureDetailVO> lectuerDetailVOList = lectureVO.getLectureDetailVOList();
		for(LectureDetailVO lecturDetailVO : lectuerDetailVOList) {
			lecturDetailVO.setLecNo(lecNo);
			result += profLecturetMapper.lecDetCreate(lecturDetailVO);
		}
		log.info("lecCreate>>lecture_detail insert : {}", result);
		
		return result;
	}
	
	// 강의 계획서 목록
	@Override
	public List<LectureVO> lectureList(Map<String, Object> map) {
		return profLecturetMapper.lectureList(map);
	}
	
	// 강의 계획서 목록 갯수(페이징)
	@Override
	public int achListPCnt(String proNo) {
		return profLecturetMapper.achListPCnt(proNo);
	}
	
	// 성적등록용 강의 목록(현재 학기 강의 목록)
	@Override
	public List<LectureVO> achiLectureList(String proNo) {
		return profLecturetMapper.achiLectureList(proNo);
	}
	
	
	// 수강생 목록 (성적등록)
	@Override
	public List<StuLectureVO> stuLetureList(String lecNo) {
		return profLecturetMapper.stuLetureList(lecNo);
	}
	
	// 강의 상세
	@Override
	public LectureVO achLectureDetail(String lecNo) {
		return profLecturetMapper.achLectureDetail(lecNo);
	}
	
	// 성적 등록
	@Override
	public int achieveInsert(List<StuLectureVO> stuLectureVOList) {
		log.info("achieveInsert 서비스임플");
		int result = 0;
		
		for(StuLectureVO stuLectureVO : stuLectureVOList) {
			String stuLecNo = stuLectureVO.getStuLecNo();
			
			// 1. 과제-----------------------------------------------------
			// 1-1. 기존에 과제 점수가 등록 되어 있는지 확인
			int assigChk = profLecturetMapper.assigChk(stuLectureVO);
			
			// 과제 VO에 수강번호 넣기
			stuLectureVO.getAssigSituVO().setStuLecNo(stuLecNo);
			// 과제 점수 변수에 넣기
			int assigScore = stuLectureVO.getAssigSituVO().getAssigScore();
			
			// 1-2. 기존에 과제 점수가 없을 때 -> 과제 점수 등록
			if(assigChk == 0) {
				// 교수가 입력한 과제 점수가 있는지 확인
				log.info("stuLectureVO.getAssigSituVO() >> {}",stuLectureVO.getAssigSituVO());
				
				if(assigScore != 0) { // 방금 보낸 데이터에서 과제 점수를 입력했을 경우
					result += profLecturetMapper.assigInsert(stuLectureVO.getAssigSituVO());
					log.info("assigInsert >> result : {}",result);
				}
			}
			// 1-3. 기존에 과제 점수가 있을 때 -> 과제 점수 업데이트
			else if(assigChk>0){ 
				// 기존 점수
				int beforeAsScore = profLecturetMapper.beforeAsScore(stuLectureVO.getAssigSituVO());
				// 기존 점수와 입력한 정보가 다르면 과제점수 업데이트
				if(beforeAsScore != assigScore) {
					log.info("기존점수 : {}",beforeAsScore);
					log.info("새점수 : {}",assigScore);
					result += profLecturetMapper.assigUpdate(stuLectureVO.getAssigSituVO());
				}
				log.info("assigInsert >> result : {}",result);
			}
			
			// 2. 중간------------------------------------------------------
			// 2-1. 기존에 중간 점수가 등록되어 있는지 확인
			int middleTChk = profLecturetMapper.middleTChk(stuLectureVO);
			// 시험결과 VO에 수강번호 넣기
			stuLectureVO.getStuTestResVO().setStuLecNo(stuLecNo);
			// 시험결과 점수 변수에 넣기
			int middleScore = stuLectureVO.getStuTestResVO().getMiddleTestScore();
			
			// 2-2.기존에 중간 점수가 없을 때 -> 중간 점수 등록
			if(middleTChk==0) {
				result += profLecturetMapper.middleInsert(stuLectureVO.getStuTestResVO());
				log.info("중간점수 등록 : {}",result);
			}
			// 2-3. 기존에 중간 점수가 있을 때 -> 중간 점수 업데이트
			else if(middleTChk>0) {
				int beforeMiddle = profLecturetMapper.beforeMiddle(stuLectureVO.getStuTestResVO());
				log.info("기존 점수 :{}",beforeMiddle);
				if(beforeMiddle != middleScore) {
					result += profLecturetMapper.middleUpdate(stuLectureVO.getStuTestResVO());
					log.info("중간점수 수정 : {}",result);
				}
			}
			
			// 3. 기말------------------------------------------------------
			// 3-1. 기존에 기말 점수가 등록되어 있는지 확인
			int endTChk = profLecturetMapper.endTChk(stuLectureVO);
			// 기말 점수 변수에 넣기
			int endScore = stuLectureVO.getStuTestResVO().getEndTestScore();
			
			// 2-2.기존에 기말 점수가 없을 때 -> 기말 점수 등록
			if(endTChk==0) {
				result += profLecturetMapper.endInsert(stuLectureVO.getStuTestResVO());
				log.info("기말점수 등록 : {}",result);
			}
			// 2-3. 기존에 기말 점수가 있을 때 -> 기말 점수 업데이트
			else if(endTChk>0) {
				int beforeEnd = profLecturetMapper.beforeEnd(stuLectureVO.getStuTestResVO());
				log.info("기말 기존 점수 :{}",beforeEnd);
				if(beforeEnd != endScore) {
					result += profLecturetMapper.endUpdate(stuLectureVO.getStuTestResVO());
					log.info("기말점수 수정 : {}",result);
				}
			}
			
			// 4. 총점 and 최종 점수
			// 4-1. 기존 총점 등록 여부
			int ttScoreChk = profLecturetMapper.ttScoreChk(stuLectureVO);
			stuLectureVO.getAchievementVO().setStuLecNo(stuLecNo);
			String achieveGrade = stuLectureVO.getAchievementVO().getAchieveGrade();
			// 교수가 입력한 점수가 있으면 -> insert
			if(ttScoreChk == 0) { 
				if(achieveGrade!=null&&!achieveGrade.equals("")) {
					result += profLecturetMapper.achievementInsert(stuLectureVO.getAchievementVO());
				}
				log.info("총점 등록 : {}",result);
			} else {
				String beforeAhcGrade = profLecturetMapper.beforeAhcGrade(stuLectureVO.getAchievementVO());
				if(!beforeAhcGrade.equals(achieveGrade)) {
					result += profLecturetMapper.achievementUpdate(stuLectureVO.getAchievementVO());
					log.info("총점 update : {}",result);
				}
			}
		}
		
		return result;
	}
	// 강의 내역 (이번학기)
	@Override
	public List<LectureVO> lecList(Map<String, Object> map) {
		return profLecturetMapper.lecList(map);
	}
	
	// 강의 내역 목록갯수
	@Override
	public int lecListPCnt(String proNo) {
		return profLecturetMapper.lecListPCnt(proNo);
	}
	
	// 강의 상세 회차, 회차별 상세
	@Override
	public List<LectureDetailVO> lecDetail(String lecNo) {
		return profLecturetMapper.lecDetail(lecNo);
	}
	
	// 이의신청 목록 
	@Override
	public List<AchExeptionVO> achExeptionVOList(String proNo) {
		return profLecturetMapper.achExeptionVOList(proNo);
	}
	
	// 이의신청 학생 성적
	@Override
	public StuLectureVO achExepDetail(String stuLecNo) {
		return profLecturetMapper.achExepDetail(stuLecNo);
	}
	
	// 이의신청 승인 시 성적변경
	@Override
	public int achExepUpdate(StuLectureVO stuLectureVO) {
		String stuLecNo = stuLectureVO.getStuLecNo();
		int result = 0;
		
		// 1. 과제점수 
		int assigScore = stuLectureVO.getAssigSituVO().getAssigScore();
		stuLectureVO.getAssigSituVO().setStuLecNo(stuLecNo);
		// 기존 점수
		int beforeAsScore = profLecturetMapper.beforeAsScore(stuLectureVO.getAssigSituVO());
		// 기존 점수와 입력한 정보가 다르면 과제점수 업데이트
		if(beforeAsScore != assigScore) {
			log.info("기존점수 : {}",beforeAsScore);
			log.info("새점수 : {}",assigScore);
			result += profLecturetMapper.assigUpdate(stuLectureVO.getAssigSituVO());
		}
		
		log.info("assigInsert >> result : {}",result);
		
		
		// 2. 중간고사 점수
		// 시험결과 VO에 수강번호 넣기
		stuLectureVO.getStuTestResVO().setStuLecNo(stuLecNo);
		// 시험결과 점수 변수에 넣기
		int middleScore = stuLectureVO.getStuTestResVO().getMiddleTestScore();
		int beforeMiddle = profLecturetMapper.beforeMiddle(stuLectureVO.getStuTestResVO());
		log.info("기존 점수 :{}",beforeMiddle);
		if(beforeMiddle != middleScore) {
			result += profLecturetMapper.middleUpdate(stuLectureVO.getStuTestResVO());
			log.info("중간점수 수정 : {}",result);
		}
		
		// 3. 기말------------------------------------------------------
		// 3-1. 기존에 기말 점수가 등록되어 있는지 확인
		// 기말 점수 변수에 넣기
		int endScore = stuLectureVO.getStuTestResVO().getEndTestScore();
		// 기존 기말 점수
		int beforeEnd = profLecturetMapper.beforeEnd(stuLectureVO.getStuTestResVO());
		log.info("기말 기존 점수 :{}",beforeEnd);
		// 기존기말점수와 입력한 점수가 다를 경우
		if(beforeEnd != endScore) {
			result += profLecturetMapper.endUpdate(stuLectureVO.getStuTestResVO());
			log.info("기말점수 수정 : {}",result);
		}
		
		
		// 4. 총점 and 최종 점수
		stuLectureVO.getAchievementVO().setStuLecNo(stuLecNo);
		String achieveGrade = stuLectureVO.getAchievementVO().getAchieveGrade();
		// 교수가 입력한 점수가 있으면 -> insert
		String beforeAhcGrade = profLecturetMapper.beforeAhcGrade(stuLectureVO.getAchievementVO());
		if(!beforeAhcGrade.equals(achieveGrade)) {
			result += profLecturetMapper.achievementUpdate(stuLectureVO.getAchievementVO());
			log.info("총점 update : {}",result);
		}
		return result;
	}
	
	// 이의 신청 답변, 상태 변경
	@Override
	public int achExepStatUpdate(AchExeptionVO achExeptionVO) {
		return profLecturetMapper.achExepStatUpdate(achExeptionVO);
	}
//======================================================= 다희씨 구역 끝


//=======================================================  수빈씨 구역 시작
	@Override
	public List<LectureVO> LectureVOList(String proNo) {
		return profLecturetMapper.LectureVOList(proNo);
	}

	@Override
	public StuLectureVO stuLectureCount(StuLectureVO stuLectureVOCount) {
		return profLecturetMapper.stuLectureCount(stuLectureVOCount);
	}

	@Override
	public List<StuLectureVO> attendStuList(Map<String, Object> map) {
		return profLecturetMapper.attendStuList(map);
	}
	@Transactional
	@Override
	public int attendanceInsert(AttendanceVO attendanceVO) {
		return profLecturetMapper.attendanceInsert(attendanceVO);
	}

	@Override
	public List<StuLectureVO> nowAttendStudList(Map<String, Object> nowStudentListParams) {
		return this.profLecturetMapper.nowAttendStudList(nowStudentListParams);
	}
	@Override
	public List<AttendanceVO> nowAttendStudComCode(Map<String, Object> nowStudentListParams) {
		return this.profLecturetMapper.nowAttendStudComCode(nowStudentListParams);
	}
	@Override
	public List<ComCodeVO> attendanceComCode(String comCode) {
		return this.profLecturetMapper.attendanceComCode(comCode);
	}
	@Override
	public List<AttendanceVO> attStudList(Map<String, Object> map) {
		return this.profLecturetMapper.attStudList(map);
	}
	
	@Override
	public List<StuLectureVO> nowlecNoList(Map<String, Object> nowAttData) {
		return this.profLecturetMapper.nowlecNoList(nowAttData);
	}
	
	//수빈씨 구역 end


	//======================================================= 유진씨 구역 시작
	
	//수강 학생 조회 전 교수의 강의 목록 리스트
	@Override
	public List<LectureVO> stuList(String proNo) {
		return profLecturetMapper.stuList(proNo);
	}

	//특정 강의에 대한 학생 목록 전체 행수
	@Override
	public int stuGetTotal(Map<String, Object> map) {
		return profLecturetMapper.stuGetTotal(map);
	}

	//특정 강의에 대한 학생 목록
	@Override
	public List<LectureVO> stuDetail(Map<String, Object> map) {
		return profLecturetMapper.stuDetail(map);
	}

	

	

	//======================================================= 유진씨 구역 끝
}
