package kr.happyjob.study.dlm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dlm.model.SupplierInfoModel;
import kr.happyjob.study.dlm.dao.SupplierInfoDao;

@Service
public class SupplierInfoServiceImpl  implements SupplierInfoService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@Autowired
	SupplierInfoDao supplierInfoDao;


	@Override
	public List<SupplierInfoModel> supplierInfoList(Map<String, Object> paramMap) throws Exception {
		return supplierInfoDao.supplierInfoList(paramMap);
	}


	@Override
	public int supplierInfoTotal(Map<String, Object> paramMap) throws Exception {
		return  supplierInfoDao.supplierInfoTotal(paramMap);
	}



	
}
