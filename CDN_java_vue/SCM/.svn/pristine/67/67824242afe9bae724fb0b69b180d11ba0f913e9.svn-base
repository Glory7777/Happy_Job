package kr.happyjob.study.exe.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.exe.model.RefundConfirmModel;
import kr.happyjob.study.exe.model.RefundListModel;

public interface RefundConfirmDao {

	// 반품신청 목록 조회
	public List<RefundConfirmModel> refundDirectionList(Map<String, Object> paramMap) throws Exception;

	// 반품신청 목록 카운트 조회
	public int totalRefund(Map<String, Object> paramMap) throws Exception;
	
	// 반품 승인
	public int refundStUpdate(Map<String, Object> paramMap) throws Exception;
	
	// 승인 완료된 반품 목록 (반품상태 1로 변경된것)
	public List<RefundListModel> confirmCompleteList() throws Exception;
}
