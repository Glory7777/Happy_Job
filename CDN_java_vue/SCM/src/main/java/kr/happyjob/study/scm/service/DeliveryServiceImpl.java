package kr.happyjob.study.scm.service;

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
import kr.happyjob.study.scm.dao.DeliveryDao;
import kr.happyjob.study.scm.model.DeliveryModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;

@Service
public class DeliveryServiceImpl implements DeliveryService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	DeliveryDao deliveryDao;
	
	
	/** 상품 목록 한건 조회 */
	public DeliveryModel selectDelivery(Map<String, Object> paramMap) throws Exception  {
		return deliveryDao.selectDelivery(paramMap);
	}
	
	/**배송 등록 */
	public int insertDelivery(Map<String, Object> paramMap) throws Exception {
		return deliveryDao.insertDelivery(paramMap);
	}
	
	/**지시서 등록 */
	public int insertDirection(Map<String, Object> paramMap) throws Exception {
		return deliveryDao.insertDirection(paramMap);
	}
	
	/**상품 재고 업데이트  */
	public int updateProductStock(Map<String, Object> paramMap) throws Exception {
		return deliveryDao.updateProductStock(paramMap);
	}
	
	/**주문상태 업데이트  */
	public int updateOrderState(Map<String, Object> paramMap) throws Exception {
		return deliveryDao.updateOrderState(paramMap);
	}
}
