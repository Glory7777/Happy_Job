package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.RefundDirectionModel;

public interface RefundDirectionService {

	// 반품지시서 목록 조회
	public List<RefundDirectionModel> refundDirectionList(Map<String, Object> paramMap) throws Exception;
	
	// 반품지시서 목록 카운트 조회
	public int totalRefundDirection(Map<String, Object> paramMap) throws Exception;


	
	
}
