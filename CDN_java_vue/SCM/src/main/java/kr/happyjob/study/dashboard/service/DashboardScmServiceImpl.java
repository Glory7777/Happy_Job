package kr.happyjob.study.dashboard.service;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtil;
import kr.happyjob.study.common.comnUtils.FileUtilModel;
import kr.happyjob.study.dashboard.dao.DashboardScmDao;
import kr.happyjob.study.dashboard.model.DashboardScmModel;

@Service
public class DashboardScmServiceImpl implements DashboardScmService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	DashboardScmDao dashboardScmDao;
	
	/** SCM(메인대시보드) 미응답 1:1 문의 */
	public int getDataUnanswered(Map<String, Object> paramMap) throws Exception {
		
		return dashboardScmDao.getDataUnanswered(paramMap);
	}
	/** SCM(메인대시보드) 미승인 반품 */
	public int getDataUnrefund(Map<String, Object> paramMap) throws Exception {
		
		return dashboardScmDao.getDataUnrefund(paramMap);
	}
	/** SCM(메인대시보드) 미발송 배송지시서*/
	public int getDataUndeli(Map<String, Object> paramMap) throws Exception {
		
		return dashboardScmDao.getDataUndeli(paramMap);
	}
	/** SCM(메인대시보드) 상품 누적 판매량*/
	public List<DashboardScmModel> getTotalOrder(Map<String, Object> paramMap) throws Exception {
		
		return dashboardScmDao.getTotalOrder(paramMap);
	}
	/** SCM(메인대시보드) 상품 누적 반품량*/
	public List<DashboardScmModel> getTotalRefund(Map<String, Object> paramMap) throws Exception {
		
		return dashboardScmDao.getTotalRefund(paramMap);
	}
	
}
