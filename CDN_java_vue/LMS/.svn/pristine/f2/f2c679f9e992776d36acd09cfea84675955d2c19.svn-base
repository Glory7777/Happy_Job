package kr.happyjob.study.prsadm.service;

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

import kr.happyjob.study.prsadm.dao.InsDao;
import kr.happyjob.study.prsadm.model.InsModel;

@Service
public class InsServiceImpl implements InsService {

	@Autowired
	InsDao insDao; // insDao랑 자동연결

	@Override
	public List<InsModel> listIns(Map<String, Object> paramMap) throws Exception{ 

		List<InsModel> listIns = insDao.listIns(paramMap);//컨트롤에서 받아서 바로  다오로 던지고 받기
		return listIns;
	}

	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = insDao.totalCnt(paramMap);
		return totalCnt;
	}

	@Override
	public InsModel selectIns(Map<String, Object> paramMap) throws Exception {
		return insDao.selectIns(paramMap);
	}

	/** 강사 등록 */
	public int insertIns(Map<String, Object> paramMap) throws Exception {
		
		return insDao.insertIns(paramMap);
	}
	
	/** 강사 수정 */
	public int updateIns(Map<String, Object> paramMap) throws Exception {
		return insDao.updateIns(paramMap);
	}
	
	/** 강사 삭제 */
	public int deleteIns(Map<String, Object> paramMap) throws Exception {
		return insDao.deleteIns(paramMap);
	}
	// 미승인 -> 승인
	public int statusY(Map<String, Object> paramMap) throws Exception {
		return insDao.statusY(paramMap);
	}
	// 승인 -> 미승인
	public int statusN(Map<String, Object> paramMap) throws Exception {
		return insDao.statusN(paramMap);
	}

}
