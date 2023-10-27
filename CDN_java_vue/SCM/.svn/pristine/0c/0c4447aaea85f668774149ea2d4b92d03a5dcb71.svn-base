package kr.happyjob.study.dlm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cus.model.ProductModel;
import kr.happyjob.study.dlm.model.DlmDeliveryModel;

public interface DlmDeliveryDao {

	/** 배송지시서 목록 조회 */
	public List<DlmDeliveryModel> listDeliveryDirection(Map<String, Object> paramMap) throws Exception;
	
	/** 배송지시서  카운트 조회 */
	public int totalDeliveryDirection(Map<String, Object> paramMap) throws Exception;
	
	/** 배송지시서 한건 조회 */
	public DlmDeliveryModel selectDeliveryDirection(Map<String, Object> paramMap) throws Exception;	
	
	/**배송처리 업데이트  */
	public int updateDelivery(Map<String, Object> paramMap) throws Exception;
	
	/**배송완료 업데이트  */
	public int updateDeliveryFin(Map<String, Object> paramMap) throws Exception;
}
