package kr.happyjob.study.exe.controller;

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

import kr.happyjob.study.exe.model.PurchaseApprovalModel;
import kr.happyjob.study.exe.service.PurchaseApprovalService;

@Controller
@RequestMapping("/exe/")
public class PurchaseApprovalController {
	
	@Autowired
	PurchaseApprovalService purchaseApprovalService;
		
	// Set logger
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className=this.getClass().toString();
	
	// 발주 목록 초기 화면
	@RequestMapping("orderConfirm.do")
	public String dailyOrderHistory(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start"+className+".orderConfirm");
		logger.info("  -paramMap : "+paramMap);
		
		logger.info("+End"+className+".orderConfirm");
		
		return "exe/orderConfirm";		
	}	 
	
	// 발주 목록 초기 화면 (Vue)
	@RequestMapping("orderConfirmvue.do")
	public String dailyOrderHistoryVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start"+className+".orderConfirm");
		logger.info("  -paramMap : "+paramMap);
		
		logger.info("+End"+className+".orderConfirm");
		
		return "exe/vueOrderConfirm";		
	}	 
	
	// 수주 정보 리스트	
	@RequestMapping("approvalList.do")
	public String approvalList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start" + className + ".approvalList");
		logger.info("  -paramMap : "+ paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startPoint = (currentPage - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<PurchaseApprovalModel> approvalList = purchaseApprovalService.approvalList(paramMap);
		
		int totalCnt=purchaseApprovalService.totalPurchaseCnt(paramMap);
		
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+End" + className + ".approvalList");
				
		return "exe/approvalList";	
	}
	
	// 수주 정보 리스트 (Vue)	
		@RequestMapping("approvalListvue.do")
		@ResponseBody
		public Map<String, Object> approvalListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+Start" + className + ".approvalList");
			logger.info("  -paramMap : "+ paramMap);
			
			int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
			int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
			int startPoint = (currentPage - 1) * pageSize;
			
			paramMap.put("pageSize", pageSize);
			paramMap.put("startPoint", startPoint);
			
			List<PurchaseApprovalModel> approvalList = purchaseApprovalService.approvalList(paramMap);
			
			int totalCnt=purchaseApprovalService.totalPurchaseCnt(paramMap);
						
			Map<String, Object> retrunMap=new HashMap<String, Object>();
			
			retrunMap.put("approvalList", approvalList);
			retrunMap.put("totalCnt", totalCnt);
			
			logger.info("+End" + className + ".approvalList");
					
			return retrunMap;	
		}
	
	// 발주 정보 하나만 가져오기
	@RequestMapping("purchaseSelect.do")
	@ResponseBody
	public Map<String, Object> purchaseSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".purchaseSelect");
		logger.info("   - paramMap : " + paramMap);
						
		PurchaseApprovalModel sectInfo = purchaseApprovalService.purchaseSelect(paramMap);		
				
		Map<String, Object> returnMap=new HashMap<String, Object>();
		
		returnMap.put("sectInfo", sectInfo);
						
		logger.info("+ End " + className + ".orderSelect");
		
		return returnMap;		
	}
	
	// 발주 승인 받고, 발주 정보 업데이트
	@RequestMapping("purchaseApprovalSave.do")
	@ResponseBody
	public Map<String, Object> purchaseApprovalSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".purchaseSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		
		int sqlReturn = 0;
		
		paramMap.put("loginid", session.getAttribute("loginId"));
		
		if(action.equals("U")) {
			
			sqlReturn = purchaseApprovalService.updatePurchase(paramMap);
			
		}		
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if(sqlReturn > 0) {
			returnMap.put("result", "SUCCESS");
		} else {
			returnMap.put("result", "FAIL");
		}
		
		logger.info("+ End " + className + ".purchaseApprovalSave");	
		
		return returnMap;		
	}
		
		

}
