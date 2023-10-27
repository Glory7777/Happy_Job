package kr.happyjob.study.dashboard.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dashboard.dao.DashboardDao;
import kr.happyjob.study.dashboard.dao.DashboardExeDao;
import kr.happyjob.study.dashboard.model.DashboardModel;
import kr.happyjob.study.dashboard.model.MonthProfitModel;
import kr.happyjob.study.dashboard.model.ProductSalesDataModel;
import kr.happyjob.study.scm.model.NoticeModel;

@Service
public class DashboardServiceImpl implements DashboardService {
	
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
   
   @Autowired
   DashboardDao dashboardDao;
   
   @Autowired
   DashboardExeDao exeDao;
	   
   @Override
   public DashboardModel goChart(Map<String, Object> paramMap) throws Exception {
      
	   DashboardModel goChart = dashboardDao.goChart(paramMap);
      
      return goChart;
   }
   
	@Override
	public int cntEngineer(Map<String, Object> paramMap) throws Exception {
		int cntEngineer = dashboardDao.cntEngineer(paramMap);
		return cntEngineer;
	}
	
	@Override
	public int cntCompany(Map<String, Object> paramMap) throws Exception {
		int cntCompany = dashboardDao.cntCompany(paramMap);
		return cntCompany;
	}
	
	@Override
	public int cntProject(Map<String, Object> paramMap) throws Exception {
		int cntProject = dashboardDao.cntProject(paramMap);
		return cntProject;
	}

	@Override
	public List<MonthProfitModel> lineChart() throws Exception{
		
		List<MonthProfitModel> list =  exeDao.lineChart();
		
		logger.info(list.size());
		
		return list;
	}

	@Override
	public List<ProductSalesDataModel> barChart() throws Exception {
		return exeDao.barChart();
	}


}
