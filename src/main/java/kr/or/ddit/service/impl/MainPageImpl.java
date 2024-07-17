package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.MainPageMapper;
import kr.or.ddit.service.MainPageService;
import kr.or.ddit.vo.CommonNoticeVO;

@Service
public class MainPageImpl implements MainPageService{

	@Autowired
	MainPageMapper mainPageMapper;
	
	@Override
	public List<CommonNoticeVO> getNoticeList() {
		return this.mainPageMapper.getNoticeList();
	}
}
