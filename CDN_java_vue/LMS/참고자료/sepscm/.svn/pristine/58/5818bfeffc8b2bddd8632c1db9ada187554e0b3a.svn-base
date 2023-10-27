package kr.happyjob.study.scm.controller;

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

import kr.happyjob.study.scm.model.NoticeModel;
import kr.happyjob.study.scm.model.ScmOrderModel;
import kr.happyjob.study.scm.service.OrderService;

@Controller
@RequestMapping("/scm/")
public class OrderController {

	@Autowired
	OrderService orderService;
	
	// Set logger
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className=this.getClass().toString();
	
	// 수주 정보 확인 초기 화면
	@RequestMapping("dailyOrderHistory.do")
	public String dailyOrderHistory(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start"+className+".dailyOrderHistory");
		logger.info("  -paramMap : "+paramMap);
		
		logger.info("+End"+className+".dailyOrderHistory");
		
		return "scm/dailyOrderHistory";		
	}	
	
	// 수주 정보 리스트	
	@RequestMapping("orderList.do")
	public String orderList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start" + className + ".orderList");
		logger.info("  -paramMap : "+ paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startPoint = (currentPage - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<ScmOrderModel> orderList = orderService.orderList(paramMap);
		
		int totalCnt=orderService.totalOrderCnt(paramMap);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+End" + className + ".orderList");
				
		return "scm/orderList";	
	}
	
	@RequestMapping("orderSelect.do")
	@ResponseBody
	public Map<String, Object> orderSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".orderSelect");
		logger.info("   - paramMap : " + paramMap);
		
		ScmOrderModel sectInfo = orderService.orderSelect(paramMap);
				
		Map<String, Object> returnMap=new HashMap<String, Object>();
		
		returnMap.put("sectInfo", sectInfo);
				
		logger.info("+ End " + className + ".orderSelect");
		
		return returnMap;		
	}
	
	// 발주테이블에 발주 정보 넣기
	@RequestMapping("purchaseSave.do")
	@ResponseBody
	public Map<String, Object> purchaseSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".purchaseSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		
		int sqlReturn = 0;
		
		paramMap.put("loginid", session.getAttribute("loginId"));
		
		if(action.equals("I")) {
			sqlReturn = orderService.insertPurchase(paramMap);			
		}
					
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if(sqlReturn > 0) {
			
			returnMap.put("result", "SUCCESS");
			
		} else {
			
			returnMap.put("result", "FAIL");
			
		}
						
		logger.info("+ End" + className + ".purchaseSave");
		
		return returnMap;		
	}	
	
				
		
	
		
	
	
	
		
	
}
