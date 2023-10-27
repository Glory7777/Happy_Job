package kr.happyjob.study.scm.controller;

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
import kr.happyjob.study.scm.model.DeliveryModel;
import kr.happyjob.study.scm.model.NoticeModel;
import kr.happyjob.study.scm.service.DeliveryService;

@Controller
@RequestMapping("/scm/")
public class DeliveryController {

	@Autowired
	DeliveryService deliveryService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 상품 단건조회
	 */
	@RequestMapping("selectDelivery.do")
	@ResponseBody
	public Map<String, Object> selectDelivery(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".selectDelivery");
		logger.info("   - paramMap : " + paramMap);

		DeliveryModel selectDelivery = deliveryService.selectDelivery(paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		returnmap.put("selectDelivery", selectDelivery);

		logger.info("+ End " + className + ".selectDelivery");

		return returnmap;
	}

	/**
	 * 배송  저장/주문하기
	 */
	@RequestMapping("saveDelivery.do")
	@ResponseBody
	public Map<String, Object> saveProduct(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".saveDelivery");
		logger.info("   - paramMap : " + paramMap);

		int sqlreturn = 0;

		paramMap.put("loginid", session.getAttribute("loginId"));
		
		//배송 테이블 insert
		sqlreturn = deliveryService.insertDelivery(paramMap);
		//지시서 테이블 insert		
		sqlreturn = deliveryService.insertDirection(paramMap);
		//주문 상태 update : 0 -> 1
		sqlreturn = deliveryService.updateOrderState(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();

		if (sqlreturn >= 0) {
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}

		logger.info("+ End " + className + ".saveDelivery");

		return returnmap;
	}
	
	/**
	 * 상품 재고 업데이트  
	 */
	@RequestMapping("updateProductStock.do")
	@ResponseBody
	public Map<String, Object> updateProductStock(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".saveDelivery");
		logger.info("   - paramMap : " + paramMap);

		int sqlreturn = 0;

		paramMap.put("loginid", session.getAttribute("loginId"));
		
		//상품 재고 업데이트 
		sqlreturn = deliveryService.updateProductStock(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();

		if (sqlreturn >= 0) {
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}

		logger.info("+ End " + className + ".saveDelivery");

		return returnmap;
	}
	
	
}
