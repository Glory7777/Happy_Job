package kr.happyjob.study.cus.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.cus.model.ProductModel;
import kr.happyjob.study.scm.model.NoticeModel;

public interface ProductService {

	/** 상품 목록 조회 */
	public List<ProductModel> listProduct(Map<String, Object> paramMap) throws Exception;
	
	/** 상품 목록  카운트 조회 */
	public int totalProduct(Map<String, Object> paramMap) throws Exception;
	
	/** 상품 목록 한건 조회 */
	public ProductModel selectProduct(Map<String, Object> paramMap) throws Exception;	
	
	/** 장바구니 등록 */
	public int insertCart(Map<String, Object> paramMap) throws Exception;
	
	/** 주문하기 등록 */
	public int insertOrder(Map<String, Object> paramMap) throws Exception;
	
}
