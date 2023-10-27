package kr.happyjob.study.dlm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlm.model.DlmRefundListModel;

public interface DlmRefundListDao {

	// 반품지시서 목록 조회
	public List<DlmRefundListModel> dlmRefundList(Map<String, Object> paramMap) throws Exception;

	// 반품지시서 목록 카운트 조회
	public int totalRefund(Map<String, Object> paramMap) throws Exception;
	
	// tb_product 재고 업데이트
	public int stockPlus(Map<String, Object> paramMap) throws Exception;

	// tb_refund 반품상태 업데이트
	public int refundUpdate(Map<String, Object> paramMap) throws Exception;

	// tb_stock_history에 insert
	public int stockHisInsert(Map<String, Object> paramMap) throws Exception;


}
