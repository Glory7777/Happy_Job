package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.CusInfoModel;



public interface CusInfoDao {
	
	/** 내부직원 목록 조회 */
	public List<CusInfoModel> cusInfoList(Map<String, Object> paramMap) throws Exception;
	
	/** 내부직원 카운트 조회 */
	public int cusInfoTotalCnt (Map<String, Object> paramMap) throws Exception;
	
	/** 내부직원 한건 조회 */
	public CusInfoModel cusInfoSelect(Map<String, Object> paramMap) throws Exception;

	/** 내부직원 신규 등록 */
	public int insertCusInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 내부직원 정보 수정 */
	public int updateCusInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 내부직원 삭제 */
	public int deleteCusInfo(Map<String, Object> paramMap) throws Exception;
}
