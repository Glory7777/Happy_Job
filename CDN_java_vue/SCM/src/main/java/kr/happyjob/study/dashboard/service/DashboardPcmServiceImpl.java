package kr.happyjob.study.dashboard.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtil;
import kr.happyjob.study.common.comnUtils.FileUtilModel;
import kr.happyjob.study.cus.dao.ProductDao;
import kr.happyjob.study.cus.model.ProductModel;
import kr.happyjob.study.dashboard.dao.DashboardDlmDao;
import kr.happyjob.study.dashboard.dao.DashboardPcmDao;
import kr.happyjob.study.dashboard.model.DashboardDlmModel;
import kr.happyjob.study.dashboard.model.DashboardPcmModel;
import kr.happyjob.study.dlm.dao.DlmDeliveryDao;
import kr.happyjob.study.dlm.model.DlmDeliveryModel;
import kr.happyjob.study.scm.model.NoticeModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;

@Service
public class DashboardPcmServiceImpl implements DashboardPcmService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	DashboardPcmDao dashboardPcmDao;
	
	/** 발주지시서 목록 조회(대시보드) */
	public List<DashboardPcmModel> listPurchaseDirectionDashboard(Map<String, Object> paramMap) throws Exception {
		return dashboardPcmDao.listPurchaseDirectionDashboard(paramMap);
	}
	
}
