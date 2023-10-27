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

import kr.happyjob.study.dashboard.model.CusFileModel;
import kr.happyjob.study.dashboard.model.ProductModel;
import kr.happyjob.study.dashboard.service.DashboardCusService;

@Controller
@RequestMapping("/dashboard/")
public class DashboardCusController {
	
	@Autowired
	//NoticeService noticeService;
	DashboardCusService dashboardCusService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	// Cus 판매상품 리스트 출력
	@RequestMapping("cusProductList.do")
	public String cusProductList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".cusProductList");
		logger.info("   - paramMap : " + paramMap);
		  
		List<ProductModel> productList = dashboardCusService.cusProductList(paramMap);
		int totalcnt = dashboardCusService.cusProCnt(paramMap);
		
		List<CusFileModel> fileList = dashboardCusService.fileList(paramMap);
		
		model.addAttribute("productList", productList);
		model.addAttribute("totalcnt", totalcnt);
		model.addAttribute("fileList", fileList);
		  
		logger.info("+ End " + className + ".cusProductList");
		
		return "system/cusProductList";
	}
	
	
	
	////////////////////////////////Vue ////////////////////////////////
	
	
	// Cus 판매상품 리스트 출력
	@RequestMapping("vueCusProductList.do")
	@ResponseBody
	public Map<String, Object> vueCusProductList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".vueCusProductList");
		logger.info("   - paramMap : " + paramMap);
		
		List<ProductModel> productList = dashboardCusService.cusProductList(paramMap);
		int totalcnt = dashboardCusService.cusProCnt(paramMap);
		
		List<CusFileModel> fileList = dashboardCusService.fileList(paramMap);
		List<ProductModel> producImagetList = dashboardCusService.cusProductImageList(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		
		returnmap.put("producImagetList", producImagetList);
		
		returnmap.put("productList", productList);
		returnmap.put("totalcnt", totalcnt);
		returnmap.put("fileList", fileList);
		
		logger.info("+ End " + className + ".vueCusProductList");
		
		return returnmap;
	}
	
	
}
