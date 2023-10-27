package kr.happyjob.study.exe.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.exe.dao.RefundConfirmDao;
import kr.happyjob.study.exe.model.RefundConfirmModel;
import kr.happyjob.study.exe.model.RefundListModel;

@Service
public class RefundConfirmServiceImpl implements RefundConfirmService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	RefundConfirmDao refundConfirmDao; 
	
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;

	
	// 반품신청 목록 조회
	public List<RefundConfirmModel> refundDirectionList(Map<String, Object> paramMap) throws Exception {
		
		return refundConfirmDao.refundDirectionList(paramMap);
	}

	// 반품신청 목록 카운트 조회
	public int totalRefund(Map<String, Object> paramMap) throws Exception {
		
		return refundConfirmDao.totalRefund(paramMap);
	}

	// 반품 승인
	public int refundStUpdate(Map<String, Object> paramMap) throws Exception {

		return refundConfirmDao.refundStUpdate(paramMap);
	}

	// 승인 완료된 반품 목록 (반품상태 1로 변경된것)
	public List<RefundListModel> confirmCompleteList() throws Exception {

		return refundConfirmDao.confirmCompleteList();
	}
	
	
	
	
}
