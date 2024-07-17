package kr.or.ddit.service.impl;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.controller.MainController;
import kr.or.ddit.mapper.MainMapper;
import kr.or.ddit.vo.StudentVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MainServiceImpl implements MainService {

	
	@Autowired
	MainController mainController;
	
	@Autowired
	MainMapper mainMapper;

	@Override
	public StudentVO detail(Principal principal) {
		return mainMapper.detail(principal.getName());
	}
	
}
