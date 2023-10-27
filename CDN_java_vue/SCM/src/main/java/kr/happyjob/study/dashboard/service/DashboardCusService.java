package kr.happyjob.study.dashboard.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dashboard.model.CusFileModel;
import kr.happyjob.study.dashboard.model.ProductModel;

public interface DashboardCusService {
	
	// 기업고객 대시보드 - 판매상품 목록
	public List<ProductModel> cusProductList(Map<String, Object> paramMap) throws Exception;

	// 기업고객 대시보드 - 판매상품 목록 카운트 조회
	public int cusProCnt(Map<String, Object> paramMap) throws Exception;

	// 파일정보
	public List<CusFileModel> fileList(Map<String, Object> paramMap) throws Exception;

	
	// 파일-이미지 목록
	public List<ProductModel> cusProductImageList(Map<String, Object> paramMap) throws Exception;
	
}
