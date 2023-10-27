package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.CusInfoDao;
import kr.happyjob.study.scm.model.CusInfoModel;



@Service
public class CusInfoServiceImpl implements CusInfoService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	CusInfoDao cusInfoDao;
	
	
	/** 내부직원 목록 조회 */
	public List<CusInfoModel> cusInfoList(Map<String, Object> paramMap) throws Exception {
		
		return cusInfoDao.cusInfoList(paramMap);
	}
	
	/** 내부직원 카운트 조회 */
	public int cusInfoTotalCnt(Map<String, Object> paramMap) throws Exception {
		
		return cusInfoDao.cusInfoTotalCnt(paramMap);
	}
	
	/** 내부직원 한건 조회 */
	public CusInfoModel cusInfoSelect(Map<String, Object> paramMap) throws Exception  {
		
		return cusInfoDao.cusInfoSelect(paramMap);
	}
	
	/** 내부직원 신규 등록 */
	public int insertCusInfo(Map<String, Object> paramMap) throws Exception {
		
		return cusInfoDao.insertCusInfo(paramMap);

	}
	
	/** 내부직원 정보 수정 */
	public int updateCusInfo(Map<String, Object> paramMap) throws Exception {
		
		return cusInfoDao.updateCusInfo(paramMap);
	}
	
	/** 내부직원 삭제 */
	public int deleteCusInfo(Map<String, Object> paramMap) throws Exception {
		
		return cusInfoDao.deleteCusInfo(paramMap);
	}
}
