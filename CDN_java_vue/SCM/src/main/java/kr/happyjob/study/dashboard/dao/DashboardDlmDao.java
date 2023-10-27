package kr.happyjob.study.dashboard.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dashboard.model.DashboardDlmModel;
import kr.happyjob.study.dashboard.model.DeliveryBuyerModel;
import kr.happyjob.study.dlm.model.DlmDeliveryModel;

public interface DashboardDlmDao {
	
	/** 배송지시서 조회(대시보드) */
	public List<DashboardDlmModel> listDeliveryDirectionDashboard(Map<String, Object> paramMap) throws Exception;

}
