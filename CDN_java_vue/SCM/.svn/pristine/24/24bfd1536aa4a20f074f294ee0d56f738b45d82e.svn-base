package kr.happyjob.study.dashboard.controller;

import java.util.ArrayList;
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

import kr.happyjob.study.dashboard.model.DashboardDlmModel;
import kr.happyjob.study.dashboard.service.DashboardDlmService;
//import kr.happyjob.study.system.model.NoticeModel;
//import kr.happyjob.study.system.service.NoticeService;

@Controller
@RequestMapping("/dashboard/")
public class DashboardDlmController {
	
	@Autowired
	//NoticeService noticeService;
	DashboardDlmService dashboardDlmService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 배송지시서 목록(대시보드)
	 */
	@ResponseBody
	@RequestMapping("listDeliveryDirectionDashboard.do")
	public List<DashboardDlmModel> listDeliveryDirectionDashboard(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listDeliveryDirectionDashboard");
		
		String userNm = (String)session.getAttribute("userNm");
		paramMap.put("userNm", userNm);
		
		logger.info("   - userNm : " + userNm);
		logger.info("   - paramMap : " + paramMap);
		
		List<DashboardDlmModel> listDeliveryDirection = dashboardDlmService.listDeliveryDirectionDashboard(paramMap);
		logger.info("+ End " + className + ".listDeliveryDirectionDashboard");
		
		return listDeliveryDirection;
		
	}	
	
	
}
