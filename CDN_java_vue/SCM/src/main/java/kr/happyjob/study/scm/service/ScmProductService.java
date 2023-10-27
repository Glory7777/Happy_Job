package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.scm.model.CategoryModel;
import kr.happyjob.study.scm.model.NoticeModel;
import kr.happyjob.study.scm.model.ProductModel;
import kr.happyjob.study.scm.model.SupplierModel;

public interface ScmProductService {

	/* 제품 리스트 조회 */
	public List<ProductModel> productList(Map<String, Object> paramMap)  throws Exception;
	
	/* 총 제품 수 조회 */
	public int productTotal(Map<String, Object> paramMap)  throws Exception;
	
    //	납품업체 리스트 조회
	public List<SupplierModel> supList() throws Exception;

	/* 상품 정보 조회 */	
	public ProductModel productSelect(Map<String, Object> paramMap) throws Exception;

	public int insertProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;;

	public int updateProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;;

	public int deleteProduct(Map<String, Object> paramMap) throws Exception;

	public List<SupplierModel> selectSupList(Map<String, Object> paramMap) throws Exception;


}
