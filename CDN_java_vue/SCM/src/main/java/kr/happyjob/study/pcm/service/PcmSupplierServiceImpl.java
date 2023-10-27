package kr.happyjob.study.pcm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pcm.dao.PcmSupplierDao;
import kr.happyjob.study.pcm.model.PcmSupplierModel;

@Service
public class PcmSupplierServiceImpl implements PcmSupplierService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PcmSupplierDao dao;

	// 납품업체 리스트 조회
	@Override
	public List<PcmSupplierModel> supplierList(Map<String, Object> paramMap) throws Exception {
		return dao.supplierList(paramMap);
	}
	@Override
	public int supplierTotal(Map<String, Object> paramMap) throws Exception {
		return dao.supplierTotal(paramMap);
	}

	
	
	
	
}
