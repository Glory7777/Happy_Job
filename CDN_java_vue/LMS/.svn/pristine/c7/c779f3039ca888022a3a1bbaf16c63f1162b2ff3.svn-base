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

import kr.happyjob.study.jobadm.dao.ResDao;
import kr.happyjob.study.jobadm.model.ResModel;

@Service
public class ResServiceImpl implements ResService {

	@Autowired
	ResDao resDao; // resDao랑 자동연결
//리스트 조회
	@Override
	public List<ResModel> listRes(Map<String, Object> paramMap) throws Exception{ 

		List<ResModel> listRes = resDao.listRes(paramMap);//컨트롤에서 받아서 바로  다오로 던지고 받기
		return listRes;
	}
//리스트 총 수량 조회
	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = resDao.totalCnt(paramMap);
		return totalCnt;
	}
    // 1건 조회
	@Override
	public ResModel selectRes(Map<String, Object> paramMap) throws Exception {
		return resDao.selectRes(paramMap);
	}

	/** 이력서 등록 */
	public int insertRes(Map<String, Object> paramMap) throws Exception {
		return resDao.insertRes(paramMap);
	}
	
	/** 이력서 수정 */
	public int updateRes(Map<String, Object> paramMap) throws Exception {
		return resDao.updateRes(paramMap);
	}
	
	/** 이력서 삭제 */
	public int deleteRes(Map<String, Object> paramMap) throws Exception {
		return resDao.deleteRes(paramMap);
	}
	
}
