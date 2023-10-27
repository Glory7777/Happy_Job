package kr.happyjob.study.cus.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cus.model.OrderModel;
import kr.happyjob.study.cus.model.UserInfoModel;

public interface OrderRefundService {

	// 주문 목록 조회
	public List<OrderModel> orderList(Map<String, Object> paramMap) throws Exception;

	// 총 주문 목록 갯수
	public int totalOrder(Map<String, Object> paramMap) throws Exception;

	// 주문 상세목록 조회
	public List<OrderModel> orderDetailList(Map<String, Object> paramMap) throws Exception;

	// 계좌정보 조회
	public UserInfoModel orderUserInfo(Map<String, Object> paramMap) throws Exception;

	// 환불 신청
	public int refund(Map<String, Object> paramMap) throws Exception;

	// 주문 - 반품여부 변경
	public int updateOrder(Map<String, Object> paramMap) throws Exception;

	
	
	
}
