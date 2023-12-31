package kr.happyjob.study.dashboard.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dashboard.model.DashboardModel;
import kr.happyjob.study.dashboard.model.MonthProfitModel;
import kr.happyjob.study.dashboard.model.ProductSalesDataModel;
import kr.happyjob.study.scm.model.NoticeModel;
import kr.happyjob.study.system.model.UserMgmtModel;

public interface DashboardService {
	
	public DashboardModel goChart(Map<String, Object> paramMap) throws Exception;
	
	// 엔지니어 수 조회
	public int cntEngineer(Map<String, Object> paramMap)throws Exception ;
	// 기업 수 조회
	public int cntCompany(Map<String, Object> paramMap)throws Exception ;
	// 프로젝트 수 조회
	public int cntProject(Map<String, Object> paramMap)throws Exception ;
	
	
	// 임원대시보드 
	// 월간수익
	public List<MonthProfitModel> lineChart() throws Exception;

	public List<ProductSalesDataModel> barChart() throws Exception;

}
