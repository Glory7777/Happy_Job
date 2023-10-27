package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.ScmPurchaseDao;
import kr.happyjob.study.scm.model.ScmPurchaseModel;

@Service
public class ScmPurchaseServiceImpl implements ScmPurchaseService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ScmPurchaseDao scmPurchaseDao;

	// 발주 리스트 조회
	@Override
	public List<ScmPurchaseModel> scmPurchaseList(Map<String, Object> paramMap) throws Exception {		
		return scmPurchaseDao.scmPurchaseList(paramMap);
	}

	// 전체 발주 건수 조회
	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {		
		return scmPurchaseDao.totalCnt(paramMap);
	}

	// 발주 정보 한건 가져오기
	@Override
	public ScmPurchaseModel selectScmPurchase(Map<String, Object> paramMap) throws Exception {		
		return scmPurchaseDao.selectScmPurchase(paramMap);
	}
}
