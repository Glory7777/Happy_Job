package kr.happyjob.study.jobadm.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.jobadm.dao.JobDao;
import kr.happyjob.study.jobadm.model.JobModel;

@Service
public class JobServiceImpl implements JobService {

	@Autowired
	JobDao jobDao; // jobDao랑 자동연결
//리스트 조회
	@Override
	public List<JobModel> listJob(Map<String, Object> paramMap) throws Exception{ 

		List<JobModel> listJob = jobDao.listJob(paramMap);//컨트롤에서 받아서 바로  다오로 던지고 받기
		return listJob;
	}
//리스트 총 수량 조회
	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = jobDao.totalCnt(paramMap);
		return totalCnt;
	}
    // 1건 조회
	@Override
	public JobModel selectJob(Map<String, Object> paramMap) throws Exception {
		return jobDao.selectJob(paramMap);
	}

	/** 직장 등록 */
	public int insertJob(Map<String, Object> paramMap) throws Exception {
		return jobDao.insertJob(paramMap);
	}
	
	/** 직장 수정 */
	public int updateJob(Map<String, Object> paramMap) throws Exception {
		return jobDao.updateJob(paramMap);
	}
	
	/** 직장 삭제 */
	public int deleteJob(Map<String, Object> paramMap) throws Exception {
		return jobDao.deleteJob(paramMap);
	}
	
}
