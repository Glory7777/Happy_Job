package kr.happyjob.study.dlm.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.cus.model.ProductModel;
import kr.happyjob.study.cus.service.ProductService;
import kr.happyjob.study.dlm.model.DlmDeliveryModel;
import kr.happyjob.study.dlm.service.DlmDeliveryService;
import kr.happyjob.study.scm.model.NoticeModel;

@Controller
@RequestMapping("/dlm/")
public class DlmDeliveryController {

	@Autowired
	DlmDeliveryService dlmDeliveryService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 상품 목록 초기화면
	 */
	@RequestMapping("deliveryDirectionvue.do")
	public String deliveryDirectionvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deliveryDirectionvue");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".deliveryDirectionvue");

		return "dlm/vueDeliveryDirection";
	}

	/**
	 * 배송지시서 목록
	 */
	@RequestMapping("listDeliveryDirectionvue.do")
	@ResponseBody
	public Map<String,Object> listDeliveryDirectionvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listDeliveryDirectionvue");
		logger.info("   - paramMap : " + paramMap);

		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));
		int startpoint = (currntPage - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);

		List<DlmDeliveryModel> listDeliveryDirection = dlmDeliveryService.listDeliveryDirection(paramMap);

		int totalcnt = dlmDeliveryService.totalDeliveryDirection(paramMap);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("listDeliveryDirection", listDeliveryDirection);
		resultMap.put("totalcnt", totalcnt);

		logger.info("+ End " + className + ".listDeliveryDirectionvue");

		return resultMap;
	}

	
	
	
	//=======================================
	
	
	

	/**
	 * 상품 목록 초기화면
	 */
	@RequestMapping("deliveryDirection.do")
	public String deliveryDirection(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deliveryDirection");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".deliveryDirection");

		return "dlm/DeliveryDirection";
	}

	/**
	 * 배송지시서 목록
	 */
	@RequestMapping("listDeliveryDirection.do")
	public String listDeliveryDirection(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listDeliveryDirection");
		logger.info("   - paramMap : " + paramMap);

		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));
		int startpoint = (currntPage - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);

		List<DlmDeliveryModel> listDeliveryDirection = dlmDeliveryService.listDeliveryDirection(paramMap);

		int totalcnt = dlmDeliveryService.totalDeliveryDirection(paramMap);

		model.addAttribute("listDeliveryDirection", listDeliveryDirection);
		model.addAttribute("totalcnt", totalcnt);

		logger.info("+ End " + className + ".listDeliveryDirection");

		return "dlm/DeliveryDirectionList";
	}

	/**
	 * 배송지시서 단건조회
	 */
	@RequestMapping("selectDeliveryDirection.do")
	@ResponseBody
	public Map<String, Object> selectDeliveryDirection(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".selectDeliveryDirection");
		logger.info("   - paramMap : " + paramMap);

		DlmDeliveryModel selectDeliveryDirection = dlmDeliveryService.selectDeliveryDirection(paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		returnmap.put("selectDeliveryDirection", selectDeliveryDirection);

		logger.info("+ End " + className + ".selectDeliveryDirection");

		return returnmap;
	}
	
	/**
	 * 배송처리 
	 */
	@RequestMapping("updateDelivery.do")
	@ResponseBody
	public Map<String, Object> updateDelivery(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".saveDelivery");
		logger.info("   - paramMap : " + paramMap);

		int sqlreturn = 0;

		paramMap.put("loginid", session.getAttribute("loginId"));
		String action = (String) paramMap.get("action");
		
		if(action.equals("0")){
			//배송상태  0 > 1 
			sqlreturn = dlmDeliveryService.updateDelivery(paramMap);
		} else if(action.equals("1")){
			//배송상태  1 > 2
			sqlreturn = dlmDeliveryService.updateDeliveryFin(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();

		if (sqlreturn >= 0) {
			if(action.equals("0")){
				returnmap.put("result", "SUCCESS");
			}else if(action.equals("1")){
				returnmap.put("result", "SUCCESSFin");
			}
		} else {
			returnmap.put("result", "FAIL");
		}

		logger.info("+ End " + className + ".saveDelivery");

		return returnmap;
	}

}
