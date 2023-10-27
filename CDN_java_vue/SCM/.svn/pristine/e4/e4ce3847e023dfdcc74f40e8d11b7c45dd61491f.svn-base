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
import kr.happyjob.study.cus.dao.ProductDao;
import kr.happyjob.study.cus.model.ProductModel;
import kr.happyjob.study.scm.model.NoticeModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;

@Service
public class ProductServiceImpl implements ProductService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ProductDao productDao;
	
	
	/** 공지사항 목록 조회 */
	public List<ProductModel> listProduct(Map<String, Object> paramMap) throws Exception {
		return productDao.listProduct(paramMap);
	}
	
	/** 상품 목록  카운트 조회 */
	public int totalProduct(Map<String, Object> paramMap) throws Exception {
		return productDao.totalProduct(paramMap);
		
	}
	
	/** 상품 목록 한건 조회 */
	public ProductModel selectProduct(Map<String, Object> paramMap) throws Exception  {
		return productDao.selectProduct(paramMap);
	}
	
	/** 장바구니 등록 */
	public int insertCart(Map<String, Object> paramMap) throws Exception{
		return productDao.insertCart(paramMap);
	}
	
	/** 주문하기 등록 */
	public int insertOrder(Map<String, Object> paramMap) throws Exception{
		return productDao.insertOrder(paramMap);
	}
	
	
	
}
