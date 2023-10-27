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
	
	// 수주 정보 확인 초기 화면 (Vue)
	@RequestMapping("dailyOrderHistoryvue.do")
	public String dailyOrderHistoryVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start"+className+".dailyOrderHistoryVue");
		logger.info("  -paramMap : "+paramMap);
		
		logger.info("+End"+className+".dailyOrderHistoryVue");
		
		return "scm/vueDailyOrderHistory";		
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
	
	// 수주 정보 리스트 (Vue)	
	@RequestMapping("orderListvue.do")
	@ResponseBody
	public Map<String, Object> orderListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start" + className + ".orderListVue");
		logger.info("  -paramMap : "+ paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startPoint = (currentPage - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
				
		List<ScmOrderModel> orderList = orderService.orderList(paramMap);
		
		int totalCnt=orderService.totalOrderCnt(paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap.put("orderList", orderList);
		returnMap.put("totalCnt", totalCnt);
				
		logger.info("+End" + className + ".orderListVue");
				
		return returnMap;	
	}
	
	// 주문 정보 하나만 가져오기
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
			
		/*	 발주 테이블에 insert 하고 생성된 기본키인 pur_cd가 다시 paramMap에 담겨서 이것을 이용하여 지시서 테이블에 정보를 넣을 것임
			String pur_cd = (String) paramMap.get("pur_cd");
			
			System.out.println("pur_cd : "+pur_cd);*/
			
			sqlReturn += orderService.insertDirection(paramMap);	
			
			sqlReturn += orderService.updatePurchaseOrder(paramMap);
		}
					
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if(sqlReturn > 2) {
			
			returnMap.put("result", "SUCCESS");
			
		} else {
			
			returnMap.put("result", "FAIL");
			
		}
						
		logger.info("+ End" + className + ".purchaseSave");
		
		return returnMap;		
	}	
	
				
		
	
		
	
	
	
		
	
}
