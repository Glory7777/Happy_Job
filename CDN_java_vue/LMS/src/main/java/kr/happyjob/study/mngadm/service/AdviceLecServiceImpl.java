package kr.happyjob.study.mngadm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.mngadm.dao.AdviceLecDao;
import kr.happyjob.study.mngadm.model.AdvStuListModel;
import kr.happyjob.study.mngadm.model.AdviceLecModel;

@Service
public class AdviceLecServiceImpl implements AdviceLecService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AdviceLecDao adviceLecDao;

	
	// 상담 목록
	@Override
	public List<AdviceLecModel> lectureAdviceList(Map<String, Object> paramMap) throws Exception {
		return adviceLecDao.lectureAdviceList(paramMap);
	}
	
	// 상담 목록 총 개수
	@Override
	public int totalcnt(Map<String, Object> paramMap) throws Exception {
		return adviceLecDao.totalcnt(paramMap);
	}
	
	// 학생 목록
	@Override
	public List<AdvStuListModel> advStuList(Map<String, Object> paramMap) throws Exception {
		return adviceLecDao.advStuList(paramMap);
	}

	// 학생 목록 총 개수
	@Override
	public int advTotalcnt(Map<String, Object> paramMap) throws Exception {
		return adviceLecDao.advTotalcnt(paramMap);
	}

//	@Override
//	public AdvStuListModel selectAdvStu(Map<String, Object> paramMap) throws Exception {
//		return adviceLecDao.selectAdvStu(paramMap);
//	}

	// 상담 등록
	@Override
	public int insertAdv(Map<String, Object> paramMap) throws Exception {
		return adviceLecDao.insertAdv(paramMap);
	}

	// 상담 갱신
	@Override
	public int updateAdv(Map<String, Object> paramMap) throws Exception {
		return adviceLecDao.updateAdv(paramMap);
	}

	// 상담 삭제
	@Override
	public int deleteAdv(Map<String, Object> paramMap) throws Exception {
		return adviceLecDao.deleteAdv(paramMap);
	}

	@Override
	public AdvStuListModel selectAdv(Map<String, Object> paramMap) throws Exception {
		return adviceLecDao.selectAdv(paramMap);
	}



	
	/*
	
	@Override
	public AdviceModel selectAdv(Map<String, Object> paramMap) throws Exception {
		return adviceMngDao.selectAdv(paramMap);
	}
	
	// 상담 등록
	@Override
	public String insertAdv(Map<String, Object> paramMap) throws Exception {
		int result = 0;
		result = adviceMngDao.insertAdv(paramMap);
		
		String msg = null;
		
		if(result != 0) msg = "저장 성공";
		else msg = "저장 실패";
		
		return msg;
	}
	
	// 상담 갱신
	@Override
	public String updateAdv(Map<String, Object> paramMap) throws Exception {

		int result = 0;
		result = adviceMngDao.updateAdv(paramMap);
		
		String msg = null;
		
		if(result != 0) msg = "갱신 성공";
		else msg = "갱신 실패";
		
		return msg;
	}
	// 상담 삭제
	@Override
	public String deleteAdv(Map<String, Object> paramMap) throws Exception {

		int result = 0;
		result = adviceMngDao.deleteAdv(paramMap);
		
		String msg = null;
		
		if(result != 0) msg = "삭제 성공";
		else msg = "삭제 실패";
		
		return msg;
	}
*/

}
