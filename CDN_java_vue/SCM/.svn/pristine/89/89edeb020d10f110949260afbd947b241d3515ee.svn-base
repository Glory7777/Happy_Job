package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.RefundDirectionDao;
import kr.happyjob.study.scm.model.RefundDirectionModel;

@Service
public class RefundDirectionServiceImpl implements RefundDirectionService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	RefundDirectionDao refundDirectionDao;
	
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	
	// 반품지시서 목록 조회
	public List<RefundDirectionModel> refundDirectionList(Map<String, Object> paramMap) throws Exception {
		
		return refundDirectionDao.refundDirectionList(paramMap);
	}
	
	// 반품지시서 목록 카운트 조회
	public int totalRefundDirection(Map<String, Object> paramMap) throws Exception {
		
		return refundDirectionDao.totalRefundDirection(paramMap);
	}
	
	
}
