package kr.happyjob.study.dashboard.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dashboard.dao.DashboardCusDao;
import kr.happyjob.study.dashboard.model.CusFileModel;
import kr.happyjob.study.dashboard.model.ProductModel;

@Service
public class DashboardCusServiceImpl implements DashboardCusService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	DashboardCusDao dashboardCusDao;
	
	// 기업고객 대시보드 - 판매상품 목록
	public List<ProductModel> cusProductList(Map<String, Object> paramMap) throws Exception {
		return dashboardCusDao.cusProductList(paramMap);
	}

	// 기업고객 대시보드 - 판매상품 목록 카운트 조회
	public int cusProCnt(Map<String, Object> paramMap) throws Exception {
		return dashboardCusDao.cusProCnt(paramMap);
	}

	// 파일정보
	public List<CusFileModel> fileList(Map<String, Object> paramMap) throws Exception {
		return dashboardCusDao.fileList(paramMap);
	}

	// 파일-이미지 목록
	public List<ProductModel> cusProductImageList(Map<String, Object> paramMap) throws Exception {
		return dashboardCusDao.cusProductImageList(paramMap);
	}
	
	
	
}
