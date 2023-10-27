package kr.happyjob.study.jobadm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.jobadm.model.JobModel;

public interface JobService {

	/** 학생 목록 조회 */
	public List<JobModel> listJob(Map<String, Object> paramMap) throws Exception; 
	
	/** 학생 카운트 조회 */
	public int totalCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 직장 한건 조회 */
	public JobModel selectJob(Map<String, Object> paramMap) throws Exception;
	
	
	/** 직장 등록 */
	public int insertJob(Map<String, Object> paramMap) throws Exception;
	
	/** 직장 수정 */
	public int updateJob(Map<String, Object> paramMap) throws Exception;
	
	/** 직장 삭제 */
	public int deleteJob(Map<String, Object> paramMap) throws Exception;
	
}
