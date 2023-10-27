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

import kr.happyjob.study.exe.model.PurchaseApprovalModel;
import kr.happyjob.study.scm.model.ScmOrderModel;
import kr.happyjob.study.scm.model.ScmPurchaseModel;
import kr.happyjob.study.scm.service.OrderService;
import kr.happyjob.study.scm.service.ScmPurchaseService;

@Controller
@RequestMapping("/scm/")
public class ScmPurchaseController {

	@Autowired
	ScmPurchaseService scmPurchaseService;
	
	// Set logger
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className=this.getClass().toString();
	
	// 초기 화면
	@RequestMapping("purchaseDir.do")
	public String purchaseDir(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start"+className+".purchaseDir");
		logger.info("  -paramMap : "+paramMap);
		
		logger.info("+End"+className+".purchaseDir");
		
		return "scm/purchaseDir";		
	}	
	
	// 초기 화면 (Vue)
	@RequestMapping("purchaseDirvue.do")
	public String purchaseDirVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start"+className+".purchaseDirVue");
		logger.info("  -paramMap : "+paramMap);
		
		logger.info("+End"+className+".purchaseDirVue");
		
		return "scm/vuePurchaseDir";		
	}	
	
	// 발주 정보 리스트	
	@RequestMapping("scmPurchaseList.do")
	public String ScmPurchaseList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start" + className + ".ScmPurchaseList");
		logger.info("  -paramMap : "+ paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startPoint = (currentPage - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<ScmPurchaseModel> scmPurchaseList = scmPurchaseService.scmPurchaseList(paramMap);
		
		int totalCnt=scmPurchaseService.totalCnt(paramMap);
		
		model.addAttribute("scmPurchaseList", scmPurchaseList);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+End" + className + ".ScmPurchaseList");
				
		return "scm/scmPurchaseList";	
	}
	
	
	// 발주 정보 리스트 (Vue)	
	@RequestMapping("scmPurchaseListvue.do")
	@ResponseBody
	public Map<String, Object> ScmPurchaseListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start" + className + ".ScmPurchaseListVue");
		logger.info("  -paramMap : "+ paramMap);
				
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startPoint = (currentPage - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<ScmPurchaseModel> scmPurchaseList = scmPurchaseService.scmPurchaseList(paramMap);
		
		int totalCnt=scmPurchaseService.totalCnt(paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap.put("scmPurchaseList", scmPurchaseList);
		returnMap.put("totalCnt", totalCnt);
		
		logger.info("+End" + className + ".ScmPurchaseListVue");
				
		return returnMap;	
	}
	
	// 발주 정보 하나만 가져오기
	@RequestMapping("selectScmPurchase.do")
	@ResponseBody
	public Map<String, Object> selectScmPurchase(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectScmPurchase");
		logger.info("   - paramMap : " + paramMap);
						
		ScmPurchaseModel sectInfo = scmPurchaseService.selectScmPurchase(paramMap);		
						
		Map<String, Object> returnMap=new HashMap<String, Object>();
		
		returnMap.put("sectInfo", sectInfo);
						
		logger.info("+ End " + className + ".selectScmPurchase");
		
		return returnMap;		
	}
	
	
}
