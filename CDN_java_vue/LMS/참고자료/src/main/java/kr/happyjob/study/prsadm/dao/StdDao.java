package kr.happyjob.study.prsadm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.prsadm.model.StdLecModel;
import kr.happyjob.study.prsadm.model.StdModel;

public interface StdDao {

	
	// 학생 리스트 조회
	public List<StdModel> listStd(Map<String, Object> paramMap)throws Exception ; // 이걸 xml로 던져버리기
	
	// 학생 목록 카운트 조회
	public int totalCnt(Map<String, Object> paramMap)throws Exception ;
	
	/** 학생 한건 조회 */
	public StdModel selectStd(Map<String, Object> paramMap) throws Exception;	
	

	/** 학생 등록 */
	public int insertStd(Map<String, Object> paramMap) throws Exception;
	public int insertStdCtg(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 수정 */
	public int updateStd(Map<String, Object> paramMap) throws Exception;
	
	/** 학생 삭제 */
	public int deleteStd(Map<String, Object> paramMap) throws Exception;

	/** 수강 목록 조회 */
	public List<StdLecModel> listStdLec(Map<String, Object> paramMap) throws Exception; 
	
	/** 수강목록 카운트 조회 */
	public int totalCntStdLec(Map<String, Object> paramMap) throws Exception;
	/** 강의 상세조회 */
	public StdLecModel selectLec(Map<String, Object> paramMap) throws Exception;

}
