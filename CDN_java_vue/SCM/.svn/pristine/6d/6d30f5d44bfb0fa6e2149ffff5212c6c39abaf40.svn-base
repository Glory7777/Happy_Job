package kr.happyjob.study.cus.controller;

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
import kr.happyjob.study.scm.model.NoticeModel;

@Controller
@RequestMapping("/cus/")
public class ProductController {

	@Autowired
	ProductService productService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 상품 목록 초기화면
	 */
	@RequestMapping("product.do")
	public String product(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".product");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ End " + className + ".product");

		return "cus/Product";
	}

	/**
	 * 상품 목록
	 */
	@RequestMapping("listProduct.do")
	public String listProduct(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listProduct");
		logger.info("   - paramMap : " + paramMap);

		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));
		int startpoint = (currntPage - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);

		List<ProductModel> listProduct = productService.listProduct(paramMap);

		int totalcnt = productService.totalProduct(paramMap);

		model.addAttribute("listProduct", listProduct);
		model.addAttribute("totalcnt", totalcnt);

		logger.info("+ End " + className + ".listProduct");

		return "cus/ProductList";
	}

	/**
	 * 상품 단건조회
	 */
	@RequestMapping("selectProduct.do")
	@ResponseBody
	public Map<String, Object> selectProduct(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".selectProduct");
		logger.info("   - paramMap : " + paramMap);

		ProductModel selectProduct = productService.selectProduct(paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		returnmap.put("selectProduct", selectProduct);

		logger.info("+ End " + className + ".selectProduct");

		return returnmap;
	}

	/**
	 * 장바구니  저장/주문하기
	 */
	@RequestMapping("saveProduct.do")
	@ResponseBody
	public Map<String, Object> saveProduct(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".saveCart");
		logger.info("   - paramMap : " + paramMap);

		String action = (String) paramMap.get("action");
		int sqlreturn = 0;

		paramMap.put("loginid", session.getAttribute("loginId"));

		if ("C".equals(action)) {
			try{
				//장바구니 저장
				sqlreturn = productService.insertCart(paramMap);
			}catch(DuplicateKeyException e){
				//장바구니 중복 체크 예외처리
				e.getStackTrace();
				sqlreturn = -1;
			}
			
		} else if ("O".equals(action)) {
			//주문하기 (단건)
			sqlreturn = productService.insertOrder(paramMap);
		}

		Map<String, Object> returnmap = new HashMap<String, Object>();

		if (sqlreturn >= 0) {
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}

		logger.info("+ End " + className + ".saveCart");

		return returnmap;
	}
	
	
	
	////////////////////////////////Vue ////////////////////////////////

	
	/**
	 * 상품 목록 초기화면
	 */
	@RequestMapping("productvue.do")
	public String vueProduct(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueProduct");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".vueProduct");
		
		return "cus/vueProduct";
	}
	
	/**
	 * 상품 목록
	 */
	@RequestMapping("vueListProduct.do")
	@ResponseBody
	public Map<String, Object> vueListProduct(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueListProduct");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));
		int startpoint = (currntPage - 1) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<ProductModel> listProduct = productService.listProduct(paramMap);
		
		int totalcnt = productService.totalProduct(paramMap);
		
		Map<String, Object> returndata = new HashMap<String, Object>();
		
		returndata.put("listProduct", listProduct);
		returndata.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vueListProduct");
		
		return returndata;
	}
	
	/**
	 * 상품 단건조회
	 */
	@RequestMapping("vueSelectProduct.do")
	@ResponseBody
	public Map<String, Object> vueSelectProduct(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueSelectProduct");
		logger.info("   - paramMap : " + paramMap);
		
		ProductModel selectProduct = productService.selectProduct(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("selectProduct", selectProduct);
		
		logger.info("+ End " + className + ".vueSelectProduct");
		
		return returnmap;
	}
	
	/**
	 * 장바구니  저장/주문하기
	 */
	@RequestMapping("vueSaveProduct.do")
	@ResponseBody
	public Map<String, Object> vueSaveProduct(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueSaveProduct");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		int sqlreturn = 0;
		
		paramMap.put("loginid", session.getAttribute("loginId"));
		
		if ("C".equals(action)) {
			try{
				//장바구니 저장
				sqlreturn = productService.insertCart(paramMap);
			}catch(DuplicateKeyException e){
				//장바구니 중복 체크 예외처리
				e.getStackTrace();
				sqlreturn = -1;
			}
			
		} else if ("O".equals(action)) {
			//주문하기 (단건)
			sqlreturn = productService.insertOrder(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if (sqlreturn >= 0) {
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}
		
		logger.info("+ End " + className + ".vueSaveProduct");
		
		return returnmap;
	}

}
