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
import kr.happyjob.study.scm.model.StockedProductModel;
import kr.happyjob.study.scm.service.StockedProductService;

@Controller
@RequestMapping("/scm/")
public class StockedProductController {
	
	@Autowired
	StockedProductService stockedProductService;

	// Set logger
	private final Logger logger=LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className=this.getClass().toString();
	
	// 초기 화면
	@RequestMapping("whInventoryForm.do")
	public String whInventoryForm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start"+className+".whInventoryForm");
		logger.info("  -paramMap : "+paramMap);
		
		logger.info("+End"+className+".whInventoryForm");
		
		return "scm/whInventoryForm";		
	}	
	
	// 초기 화면 (Vue)
	@RequestMapping("whInventoryFormvue.do")
	public String whInventoryFormVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start"+className+".whInventoryFormVue");
		logger.info("  -paramMap : "+paramMap);
		
		logger.info("+End"+className+".whInventoryFormVue");
		
		return "scm/vueWhInventoryForm";		
	}	
	
	// 상품 재고 리스트	
	@RequestMapping("stockedProductList.do")
	public String stockedProductList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start" + className + ".stockedProductList");
		logger.info("  -paramMap : "+ paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startPoint = (currentPage - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<StockedProductModel> stockedProductList = stockedProductService.stockedProductList(paramMap);
		
		int totalCnt=stockedProductService.totalCnt(paramMap);
		
		model.addAttribute("stockedProductList", stockedProductList);
		model.addAttribute("totalCnt", totalCnt);
				
		logger.info("+End" + className + ".stockedProductList");
				
		return "scm/stockedProductList";	
	}
	
	// 상품 재고 리스트	
	@RequestMapping("stockedProductListvue.do")
	@ResponseBody
	public Map<String, Object> stockedProductListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, 
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+Start" + className + ".stockedProductListVue");
		logger.info("  -paramMap : "+ paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startPoint = (currentPage - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<StockedProductModel> stockedProductList = stockedProductService.stockedProductList(paramMap);
		
		int totalCnt=stockedProductService.totalCnt(paramMap);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap.put("stockedProductList", stockedProductList);
		returnMap.put("totalCnt", totalCnt);
				
		logger.info("+End" + className + ".stockedProductListVue");
				
		return returnMap;	
	}

	
}
