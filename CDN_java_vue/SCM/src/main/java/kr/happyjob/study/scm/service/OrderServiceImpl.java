package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.OrderDao;
import kr.happyjob.study.scm.model.ScmOrderModel;

@Service
public class OrderServiceImpl implements OrderService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	OrderDao orderDao;
		
	@Override
	public List<ScmOrderModel> orderList(Map<String, Object> paramMap) throws Exception {		
		return orderDao.orderList(paramMap);
	}

	@Override
	public int totalOrderCnt(Map<String, Object> paramMap) throws Exception {		
		return orderDao.totalOrderCnt(paramMap);
	}

	@Override
	public ScmOrderModel orderSelect(Map<String, Object> paramMap) throws Exception {		
		return orderDao.orderSelect(paramMap);
	}

	// 발주 테이블에 발주 정보 삽입
	@Override
	public int insertPurchase(Map<String, Object> paramMap) throws Exception {		
		return orderDao.insertPurchase(paramMap);
	}

	// 지시서 테이블에 발주 지시서 정보 삽입
	@Override
	public int insertDirection(Map<String, Object> paramMap) throws Exception {		
		return orderDao.insertDirection(paramMap);
	}

	// 주문 테이블에 주문 상태를 '발주 완료(2)'로 업데이트
	@Override
	public int updatePurchaseOrder(Map<String, Object> paramMap) throws Exception {		
		return orderDao.updatePurchaseOrder(paramMap);
	}

}
