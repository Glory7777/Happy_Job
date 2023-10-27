package kr.happyjob.study.pcm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dlm.model.SupplierInfoModel;
import kr.happyjob.study.pcm.dao.PurchaseDao;
import kr.happyjob.study.pcm.model.PurchaseModel;

@Service
public class PurchaseServiceImpl implements PurchaseService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PurchaseDao purchaseDao;

	// 발주 리스트
	@Override
	public List<PurchaseModel> purchaseList(Map<String, Object> paramMap) throws Exception {	
		return purchaseDao.purchaseList(paramMap);
	}

	// 발주 전체 건수 조회
	@Override
	public int totalPurchaseCnt(Map<String, Object> paramMap) throws Exception {		
		return purchaseDao.totalPurchaseCnt(paramMap);
	}

	// 입금 완료 처리를 위해 발주 정보 업데이트
	@Override
	public int purchaseUpdate(Map<String, Object> paramMap) throws Exception {		
		return purchaseDao.purchaseUpdate(paramMap);
	}

	// 납품 업체 정보 가져오기
	@Override
	public SupplierInfoModel selectSup(Map<String, Object> paramMap) throws Exception {		
		return purchaseDao.selectSup(paramMap);
	}
	
	
	
}
