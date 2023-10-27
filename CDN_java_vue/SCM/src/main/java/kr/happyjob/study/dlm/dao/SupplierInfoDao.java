package kr.happyjob.study.dlm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dlm.model.SupplierInfoModel;

public interface SupplierInfoDao {

	List<SupplierInfoModel> supplierInfoList(Map<String, Object> paramMap) throws Exception;

	int supplierInfoTotal(Map<String, Object> paramMap) throws Exception;

	
}
