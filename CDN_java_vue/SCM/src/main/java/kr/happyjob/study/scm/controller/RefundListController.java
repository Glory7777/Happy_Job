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
import kr.happyjob.study.scm.model.RefundListModel;
import kr.happyjob.study.scm.service.RefundListService;

@Controller
@RequestMapping("/scm/")
public class RefundListController {
	
	@Autowired
	RefundListService refundListService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 반품 신청 목록 초기화면
	@RequestMapping("refundList.do")
	public String refundListMgr(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".refundListMgr");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".refundListMgr");

		return "scm/refundMgr";
	}
	  
	// 반품신청 목록
	@RequestMapping("refundRequestList.do")
	public String refundRequestList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".refundRequestList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		// 전체 반품 목록
		List<RefundListModel> refundList = refundListService.refundList(paramMap);
		
		// 승인 요청 완료된 반품 목록 (반품지시서 작성된 반품 목록)
		List<RefundDirectionModel> refundDirectionList = refundListService.refundDirectionList();
		
		int totalcnt = refundListService.totalRefund(paramMap);
		
		model.addAttribute("totalcnt", totalcnt);
		model.addAttribute("refundList", refundList);
		model.addAttribute("refundDirectionList", refundDirectionList);
		
		logger.info("+ End " + className + ".refundRequestList");
		
		return "scm/refundList";
	}
	
	// 반품 승인 요청
	@RequestMapping("directionConfirm.do")
	@ResponseBody
	public Map<String, Object> directionConfirm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
	HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".directionConfirm");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginId", session.getAttribute("loginId"));
		
		int refundDirection = refundListService.refundDirection(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if(refundDirection >= 0){
			returnmap.put("result", "success");
		} else{
			returnmap.put("result", "file");
		}
		
		logger.info("+ End " + className + ".directionConfirm");
		
		return returnmap;
	}
	
	
	
	////////////////////////////////Vue ////////////////////////////////
	
	
	// 반품 신청 목록 초기화면
	@RequestMapping("refundListvue.do")
	public String vueRefundListMgr(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueRefundListMgr");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".vueRefundListMgr");
		
		return "scm/vueRefund";
	}
	
	// 반품신청 목록
	@RequestMapping("vueRefundRequestList.do")
	@ResponseBody
	public Map<String, Object> vueRefundRequestList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueRefundRequestList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		// 전체 반품 목록
		List<RefundListModel> refundList = refundListService.refundList(paramMap);
		
		// 승인 요청 완료된 반품 목록 (반품지시서 작성된 반품 목록)
		List<RefundDirectionModel> refundDirectionList = refundListService.refundDirectionList();
		
		int totalcnt = refundListService.totalRefund(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("totalcnt", totalcnt);
		returnmap.put("refundList", refundList);
		returnmap.put("refundDirectionList", refundDirectionList);
		
		logger.info("+ End " + className + ".vueRefundRequestList");
		
		return returnmap;
	}
	
	// 반품 승인 요청
	@RequestMapping("vueDirectionConfirm.do")
	@ResponseBody
	public Map<String, Object> vueDirectionConfirm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueDirectionConfirm");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginId", session.getAttribute("loginId"));
		
		int refundDirection = refundListService.refundDirection(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if(refundDirection >= 0){
			returnmap.put("result", "success");
		} else{
			returnmap.put("result", "file");
		}
		
		logger.info("+ End " + className + ".vueDirectionConfirm");
		
		return returnmap;
	}
	
}
