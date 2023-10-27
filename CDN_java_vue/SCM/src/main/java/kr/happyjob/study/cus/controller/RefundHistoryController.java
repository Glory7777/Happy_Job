package kr.happyjob.study.cus.controller;

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

import kr.happyjob.study.cus.model.OrderModel;
import kr.happyjob.study.cus.service.RefundHistoryService;

@Controller
@RequestMapping("/cus/")
public class RefundHistoryController {
	
	@Autowired
	RefundHistoryService refundHistoryService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 반품현황 초기화면
	@RequestMapping("refundHistory.do")
	public String refundHistory(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".refundHistory");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".refundHistory");

		return "cus/refundHistoryMgr";
	}
	    
	// 반품현황 조회
	@RequestMapping("refundHistoryList.do")
	public String refundHistoryList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".refundHistoryList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<OrderModel> refundHistoryList = refundHistoryService.refundHistoryList(paramMap);
		int totalcnt = refundHistoryService.totalHistory(paramMap);
		
		model.addAttribute("refundHistoryList", refundHistoryList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".refundHistoryList");
		
		return "cus/refundHistoryList";
	}
	
	
	
	////////////////////////////////Vue ////////////////////////////////

	
	// 반품현황 초기화면
	@RequestMapping("refundHistoryvue.do")
	public String vueRefundHistory(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueRefundHistory");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".vueRefundHistory");
		
		return "cus/vueRefundHistory";
	}
	
	// 반품현황 조회
	@RequestMapping("vueRefundHistoryList.do")
	@ResponseBody
	public Map<String, Object> vueRefundHistoryList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueRefundHistoryList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<OrderModel> refundHistoryList = refundHistoryService.refundHistoryList(paramMap);
		int totalcnt = refundHistoryService.totalHistory(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("refundHistoryList", refundHistoryList);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vueRefundHistoryList");
		
		return returnmap;
	}
	
	
}
