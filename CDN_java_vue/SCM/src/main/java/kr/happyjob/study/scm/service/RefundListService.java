package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.RefundDirectionModel;
import kr.happyjob.study.scm.model.RefundListModel;

public interface RefundListService {

	// 반품 신청 목록 조회
	public List<RefundListModel> refundList(Map<String, Object> paramMap) throws Exception;
	
	// 반품 신청 목록 카운트 조회
	public int totalRefund(Map<String, Object> paramMap) throws Exception;

	// 반품 승인 요청
	public int refundDirection(Map<String, Object> paramMap) throws Exception;
	
	// 승인 요청 완료한 반품신청목록
	public List<RefundDirectionModel> refundDirectionList() throws Exception;

	
	
}
