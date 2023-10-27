package kr.happyjob.study.exe.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.exe.dao.SalesStatusDao;
import kr.happyjob.study.exe.model.SalesStatusModel;

@Service
public class SalesStatusServiceImpl implements SalesStatusService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
		
	@Autowired
	SalesStatusDao dao;

	// 발주 리스트 조회
	@Override
	public List<SalesStatusModel> ssList(Map<String, Object> paramMap) throws Exception {		
		return dao.ssList(paramMap);
	}

	@Override
	public int ssTotal(Map<String, Object> paramMap) throws Exception {
		return dao.ssTotal(paramMap);
	}


}
