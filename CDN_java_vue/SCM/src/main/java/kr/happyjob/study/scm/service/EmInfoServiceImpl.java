package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.EmInfoDao;
import kr.happyjob.study.scm.model.EmInfoModel;



@Service
public class EmInfoServiceImpl implements EmInfoService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	EmInfoDao emInfoDao;
	
	
	/** 내부직원 목록 조회 */
	public List<EmInfoModel> emInfoList(Map<String, Object> paramMap) throws Exception {
		
		return emInfoDao.emInfoList(paramMap);
	}
	
	/** 내부직원 카운트 조회 */
	public int emInfoTotalCnt(Map<String, Object> paramMap) throws Exception {
		
		return emInfoDao.emInfoTotalCnt(paramMap);
	}
	
	/** 내부직원 한건 조회 */
	public EmInfoModel emInfoSelect(Map<String, Object> paramMap) throws Exception  {
		
		return emInfoDao.emInfoSelect(paramMap);
	}
	
	/** 내부직원 신규 등록 */
	public int insertEmInfo(Map<String, Object> paramMap) throws Exception {
		
		return emInfoDao.insertEmInfo(paramMap);

	}
	
	/** 내부직원 정보 수정 */
	public int updateEmInfo(Map<String, Object> paramMap) throws Exception {
		
		return emInfoDao.updateEmInfo(paramMap);
	}
	
	/** 내부직원 삭제 */
	public int deleteEmInfo(Map<String, Object> paramMap) throws Exception {
		
		return emInfoDao.deleteEmInfo(paramMap);
	}
}
