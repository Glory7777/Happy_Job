package kr.happyjob.study.pcm.controller;

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

import kr.happyjob.study.pcm.service.PcmRefundDirectionService;
import kr.happyjob.study.scm.model.RefundDirectionModel;

@Controller
@RequestMapping("/pcm/")
public class PcmRefundDirectionController {
	
	@Autowired
	PcmRefundDirectionService pcmRefundDirectionService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	// 반품 신청 목록 초기화면
	@RequestMapping("refundPurchase.do")
	public String refundPurchase(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".refundPurchase");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".refundPurchase");

		return "pcm/pcmRefundDirectionMgr";
	}
	  
	// 반품신청 목록
	@RequestMapping("pcmRefundDirectionList.do")
	public String pcmRefundDirectionList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".pcmRefundDirectionList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		// 전체 반품지시서 목록
		List<RefundDirectionModel> pcmRefundDirectionList = pcmRefundDirectionService.pcmRefundDirectionList(paramMap);
		
		int totalcnt = pcmRefundDirectionService.totalList(paramMap);
		
		model.addAttribute("totalcnt", totalcnt);
		model.addAttribute("pcmRefundDirectionList", pcmRefundDirectionList);
		
		logger.info("+ End " + className + ".pcmRefundDirectionList");
		
		return "pcm/pcmRefundDirectionList";
	}
	
	// 라디오버튼 선택시 반품지시서 목록 리스트
	@RequestMapping("pcmRadioRefDirecList.do")
	public String pcmRadioRefDirecList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".pcmRadioRefDirecList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		// 전체 반품지시서 목록
		List<RefundDirectionModel> pcmRadioRefDirecList = pcmRefundDirectionService.pcmRadioRefDirecList(paramMap);
		
		int totalcnt = pcmRefundDirectionService.totalRadioList(paramMap);
		
		model.addAttribute("totalcnt", totalcnt);
		model.addAttribute("pcmRefundDirectionList", pcmRadioRefDirecList);
		
		logger.info("+ End " + className + ".pcmRadioRefDirecList");
		
		return "pcm/pcmRefundDirectionList";
	}
	
	
	
	//////////////////////////////// Vue ////////////////////////////////
	
	// 반품 신청 목록 초기화면
	@RequestMapping("refundPurchasevue.do")
	public String vueRefundPurchase(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueRefundPurchase");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".vueRefundPurchase");

		return "pcm/vuePcmRefundDirection";
	}
	  
	// 반품신청 목록
	@RequestMapping("vuePcmRefundDirectionList.do")
	@ResponseBody
	public Map<String, Object> vuePcmRefundDirectionList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vuePcmRefundDirectionList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		// 전체 반품지시서 목록
		List<RefundDirectionModel> pcmRefundDirectionList = pcmRefundDirectionService.pcmRefundDirectionList(paramMap);
		
		int totalcnt = pcmRefundDirectionService.totalList(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("totalcnt", totalcnt);
		returnmap.put("pcmRefundDirectionList", pcmRefundDirectionList);
		
		logger.info("+ End " + className + ".vuePcmRefundDirectionList");
		
		return returnmap;
	}
	
	// 라디오버튼 선택시 반품지시서 목록 리스트
		@RequestMapping("vuePcmRadioRefDirecList.do")
		@ResponseBody
		public Map<String, Object> vuePcmRadioRefDirecList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest requst,
				HttpServletResponse response, HttpSession session) throws Exception {
			
			logger.info("+ Start " + className + ".vuePcmRadioRefDirecList");
			logger.info("   - paramMap : " + paramMap);
			
			int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
			int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
			int startPoint = ( currentPage - 1 ) * pageSize;
			
			paramMap.put("pageSize", pageSize);
			paramMap.put("startPoint", startPoint);
			
			// 전체 반품지시서 목록
			List<RefundDirectionModel> pcmRadioRefDirecList = pcmRefundDirectionService.pcmRadioRefDirecList(paramMap);
			
			int totalcnt = pcmRefundDirectionService.totalRadioList(paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			returnmap.put("totalcnt", totalcnt);
			returnmap.put("pcmRefundDirectionList", pcmRadioRefDirecList);
			
			logger.info("+ End " + className + ".vuePcmRadioRefDirecList");
			
			return returnmap;
		}
}
