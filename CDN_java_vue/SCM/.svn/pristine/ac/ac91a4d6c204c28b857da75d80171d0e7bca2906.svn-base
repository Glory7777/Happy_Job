package kr.happyjob.study.cus.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cus.dao.OrderRefundDao;
import kr.happyjob.study.cus.model.OrderModel;
import kr.happyjob.study.cus.model.UserInfoModel;

@Service
public class OrderRefundServiceImpl implements OrderRefundService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	OrderRefundDao orderRefundDao;

	// 주문 목록 조회
	public List<OrderModel> orderList(Map<String, Object> paramMap) throws Exception {
		
		return orderRefundDao.orderList(paramMap);
	}

	// 총 주문 목록 갯수
	public int totalOrder(Map<String, Object> paramMap) throws Exception {
		
		return orderRefundDao.totalOrder(paramMap);
	}

	// 주문 상세목록 조회
	public List<OrderModel> orderDetailList(Map<String, Object> paramMap) throws Exception {

		return orderRefundDao.orderDetailList(paramMap);
	}

	// 계좌정보 조회
	public UserInfoModel orderUserInfo(Map<String, Object> paramMap) throws Exception {

		return orderRefundDao.orderUserInfo(paramMap);
	}

	// 환불 신청
	public int refund(Map<String, Object> paramMap) throws Exception {
		
		return orderRefundDao.refund(paramMap);
	}

	// 주문 - 반품여부 변경
	public int updateOrder(Map<String, Object> paramMap) throws Exception {
		
		return orderRefundDao.updateOrder(paramMap);
	}
	
	
	
}
