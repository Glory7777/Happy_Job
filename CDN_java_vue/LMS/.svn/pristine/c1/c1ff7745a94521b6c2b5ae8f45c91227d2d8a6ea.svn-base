package kr.happyjob.study.sptstd.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mysql.fabric.xmlrpc.base.Array;

import kr.happyjob.study.sptins.model.FileInfoModel;
import kr.happyjob.study.sptstd.dao.ALearningMaterialDao;
import kr.happyjob.study.sptstd.model.ALearningMaterialModel;



@Service
public class ALearningMaterialServiceImpl implements ALearningMaterialService {
	
	@Autowired
	ALearningMaterialDao aLMDao;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	
	/* 강의코드 조회 
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptstd.service.ALearningMaterialService#selectLecCd(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public int selectLecCd(Map<String, Object> paramMap) throws Exception {
		return aLMDao.selectLecCd(paramMap);
	}
	
	
	/* 강의명 조회
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptstd.service.ALearningMaterialService#selectLecNm(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public String selectLecNm(Map<String, Object> paramMap) throws Exception {
		return aLMDao.selectLecNm(paramMap);
	}
	

	/* 주차 목록 조회
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptstd.service.ALearningMaterialService#lmFindWeeklyList(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public List<ALearningMaterialModel> lmFindWeeklyList(Map<String, Object> paramMap) throws Exception {
		return aLMDao.lmFindWeeklyList(paramMap);
	}


	/* 파일정보 불러오기
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptstd.service.ALearningMaterialService#selectWeek(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public FileInfoModel selectWeek(Map<String, Object> paramMap) throws Exception {
		return aLMDao.selectWeek(paramMap);
	}


}
