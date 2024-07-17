package kr.or.ddit.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.AuthorityVO;
import kr.or.ddit.vo.ComCodeVO;
import kr.or.ddit.vo.ComDetCodeVO;
import kr.or.ddit.vo.ProfessorVO;
import kr.or.ddit.vo.StudentStatVO;
import kr.or.ddit.vo.StudentVO;
import kr.or.ddit.vo.UserInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class AdminStudentDao {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	public List<ComDetCodeVO> deptList() {
		return this.sqlSessionTemplate.selectList("adminStudent.deptList");
	}

	public List<StudentVO> stdList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("adminStudent.stdList",map);
	}

	public int getTotal(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("adminStudent.getTotal", map);
	}

	public StudentVO detail(String stNo) {
		return this.sqlSessionTemplate.selectOne("adminStudent.detail",stNo);
	}

	public int updateStd(StudentVO studentVO) {
		return this.sqlSessionTemplate.update("adminStudent.updateStd",studentVO);
	}

	public int updateStdStat(Map<String, Object> map) {
		return this.sqlSessionTemplate.update("adminStudent.updateStdStat",map);
	}

	public List<ComCodeVO> getCollege() {
		return this.sqlSessionTemplate.selectList("adminStudent.getCollege");
	}

	public List<ComDetCodeVO> getDept(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("adminStudent.getDept",map);
	}

	public String getStNo(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("adminStudent.getStNo",map);
	}

	public String getStuAttaNo() {
		return this.sqlSessionTemplate.selectOne("adminStudent.getStuAttaNo");
	}

	public int userInfoInsert(UserInfoVO userInfoVO) {
		return this.sqlSessionTemplate.insert("adminStudent.userInfoInsert", userInfoVO);
	}

	public int stuAdd(StudentVO studentVO) {
		return this.sqlSessionTemplate.insert("adminStudent.stuAdd", studentVO);
	}

	public int authAdd(AuthorityVO authorityVO) {
		return this.sqlSessionTemplate.insert("adminStudent.authAdd", authorityVO);
	}

	public int statAdd(StudentStatVO studentStatVO) {
		return this.sqlSessionTemplate.insert("adminStudent.statAdd", studentStatVO);
	}

	public StudentVO getProf(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("adminStudent.getProf",map);
	}

	public List<ProfessorVO> getProfList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("adminStudent.getProfList", map);
	}

	public String selectStuAttaNo(String stNo) {
		return this.sqlSessionTemplate.selectOne("adminStudent.selectStuAttaNo", stNo);
	}

	public int delStuFile(Map<String, Object> map) {
		return this.sqlSessionTemplate.delete("adminStudent.delStuFile", map);
	}

	public int updateUserInfo(UserInfoVO userInfoVO) {
		return this.sqlSessionTemplate.update("adminStudent.updateUserInfo",userInfoVO);
	}
}
