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
import kr.happyjob.study.cus.model.UserInfoModel;
import kr.happyjob.study.cus.service.OrderRefundService;

@Controller
@RequestMapping("/cus/")
public class OrderRefundController {
	
	@Autowired
	OrderRefundService orderRefundService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 주문현황, 반품신청 초기화면
	@RequestMapping("orderRefund.do")
	public String noticeMgr(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".orderRefund");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".orderRefund");

		return "cus/orderRefundMgr";
	}
	    
	// 주문 목록 조회
	@RequestMapping("listOrder.do")
	public String listOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listOrder");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<OrderModel> orderList = orderRefundService.orderList(paramMap);
		int totalcnt = orderRefundService.totalOrder(paramMap);
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".listOrder");
		
		return "cus/orderRefundList";
	}
	
	// 주문 상세목록 조회
	@RequestMapping("orderDetail.do")
	public String orderDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".orderDetail");
		logger.info("   - paramMap : " + paramMap);
		
		List<OrderModel> orderDetailList = orderRefundService.orderDetailList(paramMap);
		
		model.addAttribute("orderDetailList", orderDetailList);
		
		logger.info("+ End " + className + ".orderDetail");
		
		return "cus/orderDetail";
	}
	
	// 계좌정보 조회
	@RequestMapping("orderUserInfo.do")
	@ResponseBody
	public Map<String, Object> orderUserInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".orderUserInfo");
		logger.info("   - paramMap : " + paramMap);
		
		UserInfoModel orderUserInfo = orderRefundService.orderUserInfo(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();

		returnmap.put("orderUserInfo", orderUserInfo);
		
		System.out.println("returnmap : "+ returnmap);
		System.out.println("orderUserInfo : " + orderUserInfo);
		
		logger.info("+ End " + className + ".orderUserInfo");
		
		return returnmap;
	}
		
	// 반품 신청
	@RequestMapping("refund.do")
	@ResponseBody
	public Map<String, Object> refund(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".refund");
		logger.info("   - paramMap : " + paramMap);
		
		int insertRefund = orderRefundService.refund(paramMap);
		int updateOrder = orderRefundService.updateOrder(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if(updateOrder >= 0){
			
			if(insertRefund >= 0){
				returnmap.put("result", "success");
			} else{
				returnmap.put("result", "fail");
			}
		}
		
		
		logger.info("+ End " + className + ".refund");
		
		return returnmap;
	}
	
	// 배송 완됴되지 않은 건 주문 상세목록 조회
	@RequestMapping("notDeliveryOrderDetail.do")
	public String notDeliveryOrderDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".orderDetail");
		logger.info("   - paramMap : " + paramMap);
		
		System.out.println(paramMap);
		List<OrderModel> notDeliveryOrderDetailList = orderRefundService.orderDetailList(paramMap);
		
		model.addAttribute("notDeliveryOrderDetailList", notDeliveryOrderDetailList);
		
		logger.info("+ End " + className + ".orderDetail");
		
		return "cus/notDeliveryOrderDetail";
		
	}
	
	
	
	////////////////////////// Vue ///////////////////////////
	
	// 주문현황, 반품신청 초기화면
	@RequestMapping("orderRefundvue.do")
	public String vueNotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueNotice");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".vueNotice");

		return "cus/vueOrderRefund";
	}
	
	// 주문 목록 조회
	@RequestMapping("vueListOrder.do")
	@ResponseBody
	public Map<String, Object> vueListOrder(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueListOrder");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<OrderModel> orderList = orderRefundService.orderList(paramMap);
		int totalcnt = orderRefundService.totalOrder(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("orderList", orderList);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vueListOrder");
		
		return returnmap;
	}

	// 배송 완됴되지 않은 건 주문 상세목록 조회
	@RequestMapping("vueNotDeliveryOrderDetail.do")
	@ResponseBody
	public Map<String, Object> vueNotDeliveryOrderDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".vueNotDeliveryOrderDetail");
		logger.info("   - paramMap : " + paramMap);
		
		System.out.println(paramMap);
		List<OrderModel> notDeliveryOrderDetailList = orderRefundService.orderDetailList(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("notDeliveryOrderDetailList", notDeliveryOrderDetailList);
		
		logger.info("+ End " + className + ".vueNotDeliveryOrderDetail");
		
		return returnmap;
	}
	
	// 주문 상세목록 조회
	@RequestMapping("vueOrderDetail.do")
	@ResponseBody
	public Map<String, Object> vueOrderDetail(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".vueOrderDetail");
		logger.info("   - paramMap : " + paramMap);
		
		List<OrderModel> orderDetailList = orderRefundService.orderDetailList(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("orderDetailList", orderDetailList);
		
		logger.info("+ End " + className + ".vueOrderDetail");
		
		return returnmap;
	}
	
	// 계좌정보 조회
		@RequestMapping("vueOrderUserInfo.do")
		@ResponseBody
		public Map<String, Object> vueOrderUserInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) throws Exception{
			
			logger.info("+ Start " + className + ".vueOrderUserInfo");
			logger.info("   - paramMap : " + paramMap);
			
			UserInfoModel orderUserInfo = orderRefundService.orderUserInfo(paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();

			returnmap.put("orderUserInfo", orderUserInfo);
			
			System.out.println("returnmap : "+ returnmap);
			System.out.println("orderUserInfo : " + orderUserInfo);
			
			logger.info("+ End " + className + ".vueOrderUserInfo");
			
			return returnmap;
		}
			
		// 반품 신청
		@RequestMapping("vueRefund.do")
		@ResponseBody
		public Map<String, Object> vueRefund(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
					HttpServletResponse response, HttpSession session) throws Exception{
			
			logger.info("+ Start " + className + ".vueRefund");
			logger.info("   - paramMap : " + paramMap);
			
			int insertRefund = orderRefundService.refund(paramMap);
			int updateOrder = orderRefundService.updateOrder(paramMap);
			
			Map<String, Object> returnmap = new HashMap<String, Object>();
			
			if(updateOrder >= 0){
				
				if(insertRefund >= 0){
					returnmap.put("result", "success");
				} else{
					returnmap.put("result", "fail");
				}
			}
			
			logger.info("+ End " + className + ".vueRefund");
			
			return returnmap;
		}
	
}
