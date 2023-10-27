package kr.happyjob.study.pcm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import kr.happyjob.study.pcm.dao.PcmRefundDirectionDao;
import kr.happyjob.study.scm.model.RefundDirectionModel;

@Service
public class PcmRefundDirectionServiceImpl implements PcmRefundDirectionService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	PcmRefundDirectionDao pcmRefundDirectionDao;
	
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	
	// 반품지시서 목록 조회
	public List<RefundDirectionModel> pcmRefundDirectionList(Map<String, Object> paramMap) throws Exception {
		
		return pcmRefundDirectionDao.pcmRefundDirectionList(paramMap);
	}
	
	// 반품지시서 목록 카운트 조회
	public int totalList(Map<String, Object> paramMap) throws Exception {
		
		return pcmRefundDirectionDao.totalList(paramMap);
	}

	// 반품지시서 목록 조회 - 라디오버튼
	public List<RefundDirectionModel> pcmRadioRefDirecList(Map<String, Object> paramMap) throws Exception {
		
		return pcmRefundDirectionDao.pcmRadioRefDirecList(paramMap);
	}

	// 반품지시서 목록 카운트 조회 - 라디오버튼
	public int totalRadioList(Map<String, Object> paramMap) throws Exception {
		
		return pcmRefundDirectionDao.totalRadioList(paramMap);
	}
	
}
