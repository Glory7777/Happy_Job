package kr.happyjob.study.jobadm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.jobadm.model.ResModel;

public interface ResService {

	/** 학생 목록 조회 */
	public List<ResModel> listRes(Map<String, Object> paramMap) throws Exception; 
	
	/** 학생 카운트 조회 */
	public int totalCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 이력서 한건 조회 */
	public ResModel selectRes(Map<String, Object> paramMap) throws Exception;
	
	
	/** 이력서 등록 */
	public int insertRes(Map<String, Object> paramMap) throws Exception;
	
	/** 이력서 수정 */
	public int updateRes(Map<String, Object> paramMap) throws Exception;
	
	/** 이력서 삭제 */
	public int deleteRes(Map<String, Object> paramMap) throws Exception;
	
}
