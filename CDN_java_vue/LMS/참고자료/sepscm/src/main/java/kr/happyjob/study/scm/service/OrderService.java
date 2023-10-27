package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmOrderModel;

public interface OrderService {

	// 주문 리스트 조회
	public List<ScmOrderModel> orderList(Map<String, Object> paramMap) throws Exception;
		
	// 주문 전체 건수 조회
	public int totalOrderCnt(Map<String, Object> paramMap) throws Exception;
	
	// 발주를 위한 주문 한건 가져오기
	public ScmOrderModel orderSelect(Map<String, Object> paramMap) throws Exception;
	
	// 발주 테이블에 발주 정보 삽입
	public int insertPurchase(Map<String, Object> paramMap) throws Exception;
	
	
	
}
