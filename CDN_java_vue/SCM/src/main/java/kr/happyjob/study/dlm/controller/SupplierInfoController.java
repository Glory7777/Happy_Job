package kr.happyjob.study.dlm.controller;

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

import kr.happyjob.study.dlm.model.SupplierInfoModel;
import kr.happyjob.study.dlm.service.SupplierInfoService;



@Controller
@RequestMapping("/dlm/")
public class SupplierInfoController {
	
	@Autowired
	SupplierInfoService supplierInfoService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 납품업체정보조회
	 */
	@RequestMapping("supplierInfovue.do")
	public String supplierInfovue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".supplierInfovue");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".supplierInfovue");
		
		return "dlm/vueSupplierInfoMgr";
	}
	
	/**
	 * 납품업체 목록 조회
	 */
	@RequestMapping("supplierInfoListvue.do")
	@ResponseBody
	public Map<String,Object> supplierInfoListvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".supplierInfoListvue");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));   
		int startpoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<SupplierInfoModel> supList = supplierInfoService.supplierInfoList(paramMap);
		
		int totalCnt = supplierInfoService.supplierInfoTotal(paramMap);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("supList", supList);
		resultMap.put("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".supplierInfoListvue");

		return resultMap;
	}

	//========================================
	
	

	/**
	 * 납품업체정보조회
	 */
	@RequestMapping("supplierInfo.do")
	public String supplierInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".supplierInfo");
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".supplierInfo");
		
		return "dlm/supplierInfoMgr";
	}
	

	/**
	 * 납품업체 목록 조회
	 */
	@RequestMapping("supplierInfoList.do")
	public String supplierInfoList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".supplierInfoList");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));   
		int startpoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<SupplierInfoModel> supList = supplierInfoService.supplierInfoList(paramMap);
		
		int totalCnt = supplierInfoService.supplierInfoTotal(paramMap);
		
		model.addAttribute("supList", supList);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".supplierInfoList");

		return "dlm/supplierInfoList";
	}

}
