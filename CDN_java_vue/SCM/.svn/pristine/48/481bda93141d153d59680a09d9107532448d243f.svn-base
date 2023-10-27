package kr.happyjob.study.dashboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.dashboard.model.MonthProfitModel;
import kr.happyjob.study.dashboard.model.ProductSalesDataModel;
import kr.happyjob.study.dashboard.service.DashboardService;
import kr.happyjob.study.scm.model.NoticeModel;

@Controller
@RequestMapping("/dashboard/exe")
public class DashboardExeController {
	
	@Autowired
	DashboardService service;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("/dashboardExe.do")
	@ResponseBody
	public Map<String,Object> dashboardExe(Model model) throws Exception {
		
		logger.info("+ Start " + className + ".dashboardExe");

		Map<String,Object> resultMap = new HashMap<>();
		
		//월간수익
		List<MonthProfitModel> lineChart = service.lineChart();
		List<ProductSalesDataModel> barChart = service.barChart();
		
		logger.info("+ lineChart " +lineChart.size());
		
		//제품별 매출 막대그래프
		resultMap.put("lineChart", lineChart);
		resultMap.put("barChart", barChart);
		
		
		logger.info("+ end " + className + ".dashboardExe");

		return resultMap;
	}
	

}
