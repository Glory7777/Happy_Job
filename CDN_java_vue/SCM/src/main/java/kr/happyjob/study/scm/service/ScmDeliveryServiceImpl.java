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
import kr.happyjob.study.scm.dao.ScmDeliveryDao;
import kr.happyjob.study.scm.model.ScmDeliveryModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;

@Service
public class ScmDeliveryServiceImpl implements ScmDeliveryService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ScmDeliveryDao scmDeliveryDao;
	
	/** 배송지시서 목록 조회 */
	public List<ScmDeliveryModel> listDeliveryDirection(Map<String, Object> paramMap) throws Exception {
		return scmDeliveryDao.listDeliveryDirection(paramMap);
	}
	
	/** 배송지시서 카운트 조회 */
	public int totalDeliveryDirection(Map<String, Object> paramMap) throws Exception {
		return scmDeliveryDao.totalDeliveryDirection(paramMap);
		
	}
	
	/** 배송지시서 한건 조회 */
	public ScmDeliveryModel selectDeliveryDirection(Map<String, Object> paramMap) throws Exception {
		return scmDeliveryDao.selectDeliveryDirection(paramMap);
	}
	
}
