package kr.happyjob.study.pcm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.pcm.model.PcmSupplierModel;

public interface PcmSupplierDao {

	// 납품업체 리스트
	List<PcmSupplierModel> supplierList(Map<String, Object> paramMap) throws Exception;
	int supplierTotal(Map<String, Object> paramMap) throws Exception;
	
}
