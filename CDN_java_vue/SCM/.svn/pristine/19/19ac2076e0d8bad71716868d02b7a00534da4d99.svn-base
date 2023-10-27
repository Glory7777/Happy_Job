package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.RefundListDao;
import kr.happyjob.study.scm.model.RefundDirectionModel;
import kr.happyjob.study.scm.model.RefundListModel;

@Service
public class RefundListServiceImpl implements RefundListService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	RefundListDao refundListeDao; 
					
	
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	
	// 반품 신청 목록 조회
	public List<RefundListModel> refundList(Map<String, Object> paramMap) throws Exception {
		
		return refundListeDao.refundList(paramMap);
	}
	
	// 반품 신청 목록 카운트 조회
	public int totalRefund(Map<String, Object> paramMap) throws Exception {
		
		return refundListeDao.totalRefund(paramMap);
	}

	// 반품 승인 요청
	public int refundDirection(Map<String, Object> paramMap) throws Exception {
		
		return refundListeDao.refundDirection(paramMap);
	}

	// 승인 요청 완료한 반품신청목록
	public List<RefundDirectionModel> refundDirectionList() throws Exception {
		
		return refundListeDao.refundDirectionList();
	}

	
	
}
