package kr.happyjob.study.cus.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cus.dao.RefundHistoryDao;
import kr.happyjob.study.cus.model.OrderModel;

@Service
public class RefundHistoryServiceImpl implements RefundHistoryService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	RefundHistoryDao refundHistoryDao;

	// 반품현황 목록 조회
	public List<OrderModel> refundHistoryList(Map<String, Object> paramMap) throws Exception {
		
		return refundHistoryDao.refundHistoryList(paramMap);
	}

	// 총 반품현황 목록 갯수
	public int totalHistory(Map<String, Object> paramMap) throws Exception {
		
		return refundHistoryDao.totalHistory(paramMap);
	}

	
	
}
