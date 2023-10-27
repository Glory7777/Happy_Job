package kr.happyjob.study.dashboard.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.cus.model.ProductModel;
import kr.happyjob.study.dashboard.model.DashboardDlmModel;
import kr.happyjob.study.dlm.model.DlmDeliveryModel;
import kr.happyjob.study.scm.model.NoticeModel;

public interface DashboardDlmService {
	
	/** 배송지시서 조회(대시보드) */
	public List<DashboardDlmModel> listDeliveryDirectionDashboard(Map<String, Object> paramMap) throws Exception;
	
}
