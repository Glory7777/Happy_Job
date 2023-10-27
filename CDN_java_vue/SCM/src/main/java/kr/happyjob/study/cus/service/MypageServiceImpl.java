package kr.happyjob.study.cus.service;

import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cus.dao.MypageDao;
import kr.happyjob.study.cus.model.MypageModel;


@Service
public class MypageServiceImpl implements MypageService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	MypageDao mypageDao;
	
	/** 회원 정보 변경(마이페이지) 초기 화면 */
	public MypageModel initMypage(Map<String, Object> paramMap) throws Exception  {
		
		return mypageDao.initMypage(paramMap);
	}
	
	/** 회원 정보 변경(마이페이지)의 정보 수정 */
	public int updateMypage(Map<String, Object> paramMap) throws Exception {
		
		return mypageDao.updateMypage(paramMap);
	}
	
	/** 회원 정보 변경(마이페이지)의 회원 탈퇴 */
	public int delMember(Map<String, Object> paramMap) throws Exception {
		
		return mypageDao.delMember(paramMap);
	}
}
