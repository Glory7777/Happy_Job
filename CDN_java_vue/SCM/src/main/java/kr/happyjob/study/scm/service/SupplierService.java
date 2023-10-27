package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.scm.model.CategoryModel;
import kr.happyjob.study.scm.model.NoticeModel;
import kr.happyjob.study.scm.model.ProductModel;
import kr.happyjob.study.scm.model.SupplierModel;

public interface SupplierService {

	List<SupplierModel> supplierList(Map<String, Object> paramMap) throws Exception;

	int supplierTotal(Map<String, Object> paramMap) throws Exception;

	List<ProductModel> productList(Map<String, Object> paramMap) throws Exception;

	int productTotalCnt(Map<String, Object> paramMap) throws Exception;

	int insertSupplier(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	int updateSupplier(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	int deleteSupplier(Map<String, Object> paramMap) throws Exception;

	SupplierModel selectSupplier(Map<String, Object> paramMap) throws Exception;

	List<ProductModel> productListvue(Map<String, Object> paramMap) throws Exception;


}
