package kr.happyjob.study.dlm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlm.model.StockedModel;
import kr.happyjob.study.dlm.model.SupplierInfoModel;

public interface StockedDao {

	// 입고 처리할 발주 리스트
	public List<StockedModel> stockedList (Map<String, Object>paramMap) throws Exception;
	
	// 입금 처리 된 전체 발주 건수 조회
	public int totalCnt(Map<String, Object> paramMap) throws Exception;	

	// 입고 완료 처리를 위해 발주 정보 업데이트
	public int stockUpdate(Map<String, Object> paramMap) throws Exception;
	
	// 상품 테이블에 입고 수량만큼 재고 업데이트
	public int productStockUpdate(Map<String, Object> paramMap) throws Exception;
	
	// 납품 업체 정보 가져오기
	public SupplierInfoModel selectSup(Map<String, Object> paramMap) throws Exception;
	
}
