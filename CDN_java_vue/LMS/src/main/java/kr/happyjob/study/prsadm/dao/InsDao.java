package kr.happyjob.study.prsadm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.prsadm.model.InsModel;

public interface InsDao {

	
	// 강사 리스트 조회
	public List<InsModel> listIns(Map<String, Object> paramMap)throws Exception ; // 이걸 xml로 던져버리기
	
	// 강사 목록 카운트 조회
	public int totalCnt(Map<String, Object> paramMap)throws Exception ;
	
	/** 강사 한건 조회 */
	public InsModel selectIns(Map<String, Object> paramMap) throws Exception;	
	

	/** 강사 등록 */
	public int insertIns(Map<String, Object> paramMap) throws Exception;
	
	/** 강사 수정 */
	public int updateIns(Map<String, Object> paramMap) throws Exception;
	/*public int updateUnable(Map<String, Object> paramMap) throws Exception;*/
	
	/** 강사 삭제 */
	public int deleteIns(Map<String, Object> paramMap) throws Exception;
	/** 미승인->승인 */
	public int statusY(Map<String, Object> paramMap) throws Exception;
	/** 승인 -> 미승인*/
	public int statusN(Map<String, Object> paramMap) throws Exception;

}
