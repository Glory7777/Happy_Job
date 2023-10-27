package kr.happyjob.study.pcm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.RefundDirectionModel;

public interface PcmRefundDirectionDao {

	// 반품지시서 목록 조회
	public List<RefundDirectionModel> pcmRefundDirectionList(Map<String, Object> paramMap) throws Exception;
	
	// 반품지시서 목록 카운트 조회
	public int totalList(Map<String, Object> paramMap) throws Exception;
	
	// 반품지시서 목록 조회 - 라디오버튼
	public List<RefundDirectionModel> pcmRadioRefDirecList(Map<String, Object> paramMap) throws Exception;
	
	// 반품지시서 목록 카운트 조회 - 라디오버튼
	public int totalRadioList(Map<String, Object> paramMap) throws Exception;
	
}
