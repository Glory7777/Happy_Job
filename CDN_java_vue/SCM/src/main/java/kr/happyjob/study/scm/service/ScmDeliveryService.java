package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.scm.model.ScmDeliveryModel;

public interface ScmDeliveryService {

	/** 배송지시서 조회 */
	public List<ScmDeliveryModel> listDeliveryDirection(Map<String, Object> paramMap) throws Exception;
	
	/** 배송지시서  카운트 조회 */
	public int totalDeliveryDirection(Map<String, Object> paramMap) throws Exception;
	
	/** 배송지시서 한건 조회 */
	public ScmDeliveryModel selectDeliveryDirection(Map<String, Object> paramMap) throws Exception;	
	
}
