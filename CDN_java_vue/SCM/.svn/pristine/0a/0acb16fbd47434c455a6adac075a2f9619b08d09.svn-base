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

import kr.happyjob.study.scm.model.RefundDirectionModel;
import kr.happyjob.study.scm.service.RefundDirectionService;

@Controller
@RequestMapping("/scm/")
public class RefundDirectionController {
	
	@Autowired
	RefundDirectionService refundDirectionService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 반품 신청 목록 초기화면
	@RequestMapping("refundDirection.do")
	public String refundDirection(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".refundDirection");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".refundDirection");

		return "scm/refundDirectionMgr";
	}
	  
	// 반품신청 목록
	@RequestMapping("refundDirectionList.do")
	public String refundDirectionList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".refundDirectionList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		// 전체 반품 목록
		List<RefundDirectionModel> refundDirectionList = refundDirectionService.refundDirectionList(paramMap);
		
		int totalcnt = refundDirectionService.totalRefundDirection(paramMap);
		
		model.addAttribute("totalcnt", totalcnt);
		model.addAttribute("refundDirectionList", refundDirectionList);
		
		logger.info("+ End " + className + ".refundDirectionList");
		
		return "scm/refundDirectionList";
	}
	
	
	
	////////////////////////////////Vue ////////////////////////////////
	
	// 반품 신청 목록 초기화면
	@RequestMapping("refundDirectionvue.do")
	public String vueRefundDirection(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueRefundDirection");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".vueRefundDirection");
		
		return "scm/vueRefundDirection";
	}
	
	// 반품신청 목록
	@RequestMapping("vueRefundDirectionList.do")
	@ResponseBody
	public Map<String, Object> vueRefundDirectionList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueRefundDirectionList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		// 전체 반품 목록
		List<RefundDirectionModel> refundDirectionList = refundDirectionService.refundDirectionList(paramMap);
		
		int totalcnt = refundDirectionService.totalRefundDirection(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("totalcnt", totalcnt);
		returnmap.put("refundDirectionList", refundDirectionList);
		
		logger.info("+ End " + className + ".vueRefundDirectionList");
		
		return returnmap;
	}
	
}
