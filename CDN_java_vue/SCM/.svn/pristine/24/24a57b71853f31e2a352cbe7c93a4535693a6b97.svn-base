package kr.happyjob.study.dlm.service;

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
import kr.happyjob.study.dlm.dao.DlmDeliveryDao;
import kr.happyjob.study.dlm.model.DlmDeliveryModel;
import kr.happyjob.study.scm.model.NoticeModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;

@Service
public class DlmDeliveryServiceImpl implements DlmDeliveryService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	DlmDeliveryDao dlmDeliveryDao;
	
	/** 배송지시서 목록 조회 */
	public List<DlmDeliveryModel> listDeliveryDirection(Map<String, Object> paramMap) throws Exception {
		return dlmDeliveryDao.listDeliveryDirection(paramMap);
	}
	
	/** 배송지시서 카운트 조회 */
	public int totalDeliveryDirection(Map<String, Object> paramMap) throws Exception {
		return dlmDeliveryDao.totalDeliveryDirection(paramMap);
		
	}
	
	/** 배송지시서 한건 조회 */
	public DlmDeliveryModel selectDeliveryDirection(Map<String, Object> paramMap) throws Exception {
		return dlmDeliveryDao.selectDeliveryDirection(paramMap);
	}
	
	/**배송처리 업데이트  */
	public int updateDelivery(Map<String, Object> paramMap) throws Exception {
		return dlmDeliveryDao.updateDelivery(paramMap);
	}
	
	/**배송완료 업데이트  */
	public int updateDeliveryFin(Map<String, Object> paramMap) throws Exception {
		return dlmDeliveryDao.updateDeliveryFin(paramMap);
	}
}
