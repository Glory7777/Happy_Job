package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.ScmPurchaseModel;
import kr.happyjob.study.scm.model.StockedProductModel;

public interface StockedProductService {

	// 상품별 재고 리스트 조회
	public List<StockedProductModel> stockedProductList(Map<String, Object> paramMap) throws Exception;
		
	// 전체 상품 개수 조회
	public int totalCnt(Map<String, Object> paramMap) throws Exception;
		
}
