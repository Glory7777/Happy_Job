package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cus.model.QnaModel;
import kr.happyjob.study.scm.model.AnswerModel;
import kr.happyjob.study.scm.model.EmInfoModel;


public interface EmInfoDao {
	
	/** 내부직원 목록 조회 */
	public List<EmInfoModel> emInfoList(Map<String, Object> paramMap) throws Exception;
	
	/** 내부직원 카운트 조회 */
	public int emInfoTotalCnt (Map<String, Object> paramMap) throws Exception;
	
	/** 내부직원 한건 조회 */
	public EmInfoModel emInfoSelect(Map<String, Object> paramMap) throws Exception;

	/** 내부직원 신규 등록 */
	public int insertEmInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 내부직원 정보 수정 */
	public int updateEmInfo(Map<String, Object> paramMap) throws Exception;
	
	/** 내부직원 삭제 */
	public int deleteEmInfo(Map<String, Object> paramMap) throws Exception;
}
