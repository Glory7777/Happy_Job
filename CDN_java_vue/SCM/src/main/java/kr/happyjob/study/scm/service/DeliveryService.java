package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.cus.model.ProductModel;
import kr.happyjob.study.scm.model.DeliveryModel;
import kr.happyjob.study.scm.model.NoticeModel;

public interface DeliveryService {
	
	/** 상품 목록 한건 조회 */
	public DeliveryModel selectDelivery(Map<String, Object> paramMap) throws Exception;	
	
	/**배송 등록 */
	public int insertDelivery(Map<String, Object> paramMap) throws Exception;
	
	/**지시서 등록 */
	public int insertDirection(Map<String, Object> paramMap) throws Exception;
	
	/**상품 재고 업데이트  */
	public int updateProductStock(Map<String, Object> paramMap) throws Exception;
	
	/**주문상태 업데이트  */
	public int updateOrderState(Map<String, Object> paramMap) throws Exception;
}
