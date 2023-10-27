package kr.happyjob.study.pcm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlm.model.SupplierInfoModel;
import kr.happyjob.study.pcm.model.PurchaseModel;

public interface PurchaseService {

	// 발주 리스트
	public List<PurchaseModel> purchaseList(Map<String, Object> paramMap) throws Exception;
	
	// 발주 전체 건수 조회
	public int totalPurchaseCnt(Map<String, Object> paramMap) throws Exception;
	
	// 입금 완료 처리를 위해 발주 정보 업데이트
	public int purchaseUpdate(Map<String, Object> paramMap) throws Exception;
	
	// 납품 업체 정보 가져오기
	public SupplierInfoModel selectSup(Map<String, Object> paramMap) throws Exception;
	
}
