package kr.happyjob.study.exe.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.exe.model.PurchaseApprovalModel;

public interface PurchaseApprovalDao {

	// 발주 리스트 조회
	public List<PurchaseApprovalModel> approvalList(Map<String, Object> paramMap) throws Exception;
		
	// 전체 발주 건수 조회
	public int totalApprovalCnt(Map<String, Object> paramMap) throws Exception;
	
	// 발주 승인을 위한 발주 한건 가져오기
	public PurchaseApprovalModel purchaseSelect(Map<String, Object> paramMap) throws Exception;
	
	// 발주 승인을 받고 발주 정보 업데이트
	public int updatePurchase(Map<String, Object> paramMap) throws Exception;
	
}
