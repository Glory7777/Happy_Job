package kr.happyjob.study.mngadm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngadm.model.AdvStuListModel;
import kr.happyjob.study.mngadm.model.AdviceLecModel;



public interface AdviceLecService {

	// 상담 목록

	List<AdviceLecModel> lectureAdviceList(Map<String, Object> paramMap)throws Exception;

	// 상담 목록 총 갯수

	int totalcnt(Map<String, Object> paramMap) throws Exception;

	// 학생 상담 목록 조회
	public List<AdvStuListModel> advStuList(Map<String, Object> paramMap) throws Exception;
	
	// 학생 목록 총 개수
	int advTotalcnt(Map<String, Object> paramMap)throws Exception;

	
	
/*
	//상담 내용 조회
	AdviceModel selectAdv(Map<String, Object> paramMap) throws Exception;


	// 상담 저장
	String insertAdv(Map<String, Object> paramMap) throws Exception;

	// 상담 갱신
	String updateAdv(Map<String, Object> paramMap)throws Exception;

	// 상담 삭제
	String deleteAdv(Map<String, Object> paramMap)throws Exception;

	
*/
	


}
