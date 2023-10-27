package kr.happyjob.study.cus.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtil;
import kr.happyjob.study.common.comnUtils.FileUtilModel;
import kr.happyjob.study.cus.dao.CartDao;
import kr.happyjob.study.cus.model.CartModel;
import kr.happyjob.study.cus.model.ProductModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;

@Service
public class CartServiceImpl implements CartService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	CartDao cartDao;
	
	
	/** 장바구니 목록 조회 */
	public List<CartModel> listCart(Map<String, Object> paramMap) throws Exception {
		return cartDao.listCart(paramMap);
	}
	
	/** 장바구니  카운트 조회 */
	public int totalCart(Map<String, Object> paramMap) throws Exception {
		return cartDao.totalCart(paramMap);
		
	}
	
	/** 장바구니 한건 조회 */
	public CartModel selectAccount(Map<String, Object> paramMap) throws Exception  {
		return cartDao.selectAccount(paramMap);
	}
	
	/** 장바구니 삭제(단건) */
	public int deleteCart(Map<String, Object> paramMap) throws Exception {
		return cartDao.deleteCart(paramMap);
	}
	
	/** 장바구니 삭제 */
	public int selectDeleteCart(Map<String, Object> paramMap) throws Exception {
		return cartDao.selectDeleteCart(paramMap);
	}
	
	/** 장바구니 삭제 */
	public int orderCart(Map<String, Object> paramMap) throws Exception {
		return cartDao.orderCart(paramMap);
	}
	
	
}
