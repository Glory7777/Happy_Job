package kr.happyjob.study.dlm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dlm.dao.DlmRefundListDao;
import kr.happyjob.study.dlm.model.DlmRefundListModel;

@Service
public class DlmRefundListServiceImpl implements DlmRefundListService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	DlmRefundListDao dlmRefundListDao; 
	
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;

	
	// 반품지시서 목록 조회
	public List<DlmRefundListModel> dlmRefundList(Map<String, Object> paramMap) throws Exception {
		
		return dlmRefundListDao.dlmRefundList(paramMap);
	}

	// 반품지시서 목록 카운트 조회
	public int totalRefund(Map<String, Object> paramMap) throws Exception {
		
		return dlmRefundListDao.totalRefund(paramMap);
	}

	// tb_product 재고 업데이트
	public int stockPlus(Map<String, Object> paramMap) throws Exception {
		
		return dlmRefundListDao.stockPlus(paramMap);
	}

	// tb_refund 반품상태 업데이트
	public int refundUpdate(Map<String, Object> paramMap) throws Exception {
		
		return dlmRefundListDao.refundUpdate(paramMap);
	}

	// tb_stock_history에 insert
	public int stockHisInsert(Map<String, Object> paramMap) throws Exception {
		
		return dlmRefundListDao.stockHisInsert(paramMap);
	}


	
	
}
