package kr.happyjob.study.mngstd.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngstd.model.LevelTestModel;
import kr.happyjob.study.mngstd.model.MylecListModel;
import kr.happyjob.study.sptadm.model.NtModel;

public interface LevelTestService {

	//내가 신청한 강의의 개설된 시험 조회하기 
	public List<LevelTestModel> testList(Map<String, Object> paramMap) throws Exception; 

	 /* 시험제출하기 */  
	public int TestSubmit(Map<String, Object> paramMap) throws Exception;
	
	/* 시험제출하기 2*/     
	public int TestSubmit2(Map<String, Object> paramMap) throws Exception; 
	
	
	/* 시험결과값 조회*/     
	public List<LevelTestModel> resultList(Map<String, Object> paramMap) throws Exception; 

	/* 시험결과값 조회*/     
	public List<LevelTestModel> resultList2(Map<String, Object> paramMap) throws Exception; 
}
