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

import kr.happyjob.study.scm.model.ScmDeliveryModel;
import kr.happyjob.study.scm.service.ScmDeliveryService;

@Controller
@RequestMapping("/scm/")
public class ScmDeliveryController {

	@Autowired
	ScmDeliveryService scmDeliveryService;

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

		return "scm/vueDeliveryDirection";
	}
	

	/**
	 * 상품 목록
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

		List<ScmDeliveryModel> listDeliveryDirection = scmDeliveryService.listDeliveryDirection(paramMap);

		int totalcnt = scmDeliveryService.totalDeliveryDirection(paramMap);
		
		Map<String,Object> resultMap = new HashMap<String,Object>();
	
		resultMap.put("listDeliveryDirection", listDeliveryDirection);
		resultMap.put("totalcnt", totalcnt);

		logger.info("+ End " + className + ".listDeliveryDirectionvue");

		return resultMap;
	}

	//=============================

	/**
	 * 상품 목록 초기화면
	 */
	@RequestMapping("deliveryDirection.do")
	public String deliveryDirection(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".deliveryDirection");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".deliveryDirection");

		return "scm/DeliveryDirection";
	}

	/**
	 * 상품 목록
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

		List<ScmDeliveryModel> listDeliveryDirection = scmDeliveryService.listDeliveryDirection(paramMap);

		int totalcnt = scmDeliveryService.totalDeliveryDirection(paramMap);

		model.addAttribute("listDeliveryDirection", listDeliveryDirection);
		model.addAttribute("totalcnt", totalcnt);

		logger.info("+ End " + className + ".listDeliveryDirection");

		return "scm/DeliveryDirectionList";
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

		ScmDeliveryModel selectDeliveryDirection = scmDeliveryService.selectDeliveryDirection(paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		returnmap.put("selectDeliveryDirection", selectDeliveryDirection);

		logger.info("+ End " + className + ".selectDeliveryDirection");

		return returnmap;
	}

}
