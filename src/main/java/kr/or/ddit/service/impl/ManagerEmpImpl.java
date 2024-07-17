package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.ManagerEmpDao;
import kr.or.ddit.service.ManagerEmpService;
import kr.or.ddit.vo.ScheduleVO;
import kr.or.ddit.vo.SchoolEmployeeVO;

@Service
public class ManagerEmpImpl implements ManagerEmpService {

	@Autowired
	ManagerEmpDao managerEmpDao;
	
	@Override
	public List<SchoolEmployeeVO> empList(Map<String, Object> map) {
		return this.managerEmpDao.empList(map);
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.managerEmpDao.getTotal(map);
	}

	@Override
	public String schEmNo(Map<String, Object> map) {
		return this.managerEmpDao.schEmNo(map);
	}

	@Override
	public int createAjax(Map<String, Object> map) {
		return this.managerEmpDao.createAjax(map);
	}

	@Override
	public List<Map<String, Object>> salaryList() {
		return this.managerEmpDao.salaryList();
	}

	@Override
	public List<Map<String, Object>> univList() {
		return this.managerEmpDao.univList();
	}

	@Override
	public List<ScheduleVO> getScheduleList() {
		return this.managerEmpDao.getScheduleList();
	}

	@Override
	public int insertSchedule(Map<String, Object> map) {
		return this.managerEmpDao.insertSchedule(map);
	}

	@Override
	public int deleteSchedule(Map<String, String> map) {
		return this.managerEmpDao.deleteSchedule(map);
	}

	@Override
	public String getScheNo() {
		return this.managerEmpDao.getScheNo();
	}

	@Override
	public int deleteScheduleString(String scheNo) {
		return this.managerEmpDao.deleteScheduleString(scheNo);
	}
	
}
