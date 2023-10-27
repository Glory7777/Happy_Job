package kr.happyjob.study.dashboard.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dashboard.model.MonthProfitModel;
import kr.happyjob.study.dashboard.model.ProductSalesDataModel;
import kr.happyjob.study.scm.model.NoticeModel;


public interface DashboardExeDao {

	// 월간수익
	public List<MonthProfitModel> lineChart() throws Exception;
	
	// 상품별 판매총액
	public List<ProductSalesDataModel> barChart() throws Exception;

	
}
