package kr.happyjob.study.dashboard.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dashboard.model.DashboardPcmModel;
import kr.happyjob.study.dashboard.model.PcmModel;

public interface DashboardPcmDao {
	
	List<DashboardPcmModel> listPurchaseDirectionDashboard(Map<String, Object> paramMap);

}
