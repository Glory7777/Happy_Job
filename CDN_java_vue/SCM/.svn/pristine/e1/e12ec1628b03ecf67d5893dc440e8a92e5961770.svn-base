package kr.happyjob.study.exe.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.exe.dao.PurchaseApprovalDao;
import kr.happyjob.study.exe.model.PurchaseApprovalModel;

@Service
public class PurchaseApprovalServiceImpl implements PurchaseApprovalService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
		
	@Autowired
	PurchaseApprovalDao purchaseApprovalDao;

	// 발주 리스트 조회
	@Override
	public List<PurchaseApprovalModel> approvalList(Map<String, Object> paramMap) throws Exception {		
		return purchaseApprovalDao.approvalList(paramMap);
	}

	// 전체 발주 건수 조회
	@Override
	public int totalPurchaseCnt(Map<String, Object> paramMap) throws Exception {		
		return purchaseApprovalDao.totalApprovalCnt(paramMap);
	}

	// 발주 승인을 위한 발주 한건 가져오기
	@Override
	public PurchaseApprovalModel purchaseSelect(Map<String, Object> paramMap) throws Exception {		
		return purchaseApprovalDao.purchaseSelect(paramMap);
	}

	// 발주 승인을 받고 발주 정보 업데이트
	@Override
	public int updatePurchase(Map<String, Object> paramMap) throws Exception {		
		return purchaseApprovalDao.updatePurchase(paramMap);
	}
	
}
