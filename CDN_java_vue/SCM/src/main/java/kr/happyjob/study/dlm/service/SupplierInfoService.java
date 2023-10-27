package kr.happyjob.study.dlm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.dlm.model.SupplierInfoModel;
import kr.happyjob.study.scm.model.SupplierModel;

public interface SupplierInfoService {

	List<SupplierInfoModel> supplierInfoList(Map<String, Object> paramMap) throws Exception;

	int supplierInfoTotal(Map<String, Object> paramMap) throws Exception;	

}
