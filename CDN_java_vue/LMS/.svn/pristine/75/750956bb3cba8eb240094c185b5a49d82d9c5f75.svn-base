package kr.happyjob.study.sptadm.service;

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

import kr.happyjob.study.sptadm.dao.NtDao;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.sptadm.model.NtModel;

@Service
public class NtServiceImpl implements NtService {

	@Autowired
	NtDao ntDao; // ntDao랑 자동여

	@Override
	public List<NtModel> listNotice(Map<String, Object> paramMap) throws Exception{ 

		List<NtModel> listNotice = ntDao.listNotice(paramMap);//컨트롤에서 받아서 바로  다오로 던지고 받기
		return listNotice;
	}

	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = ntDao.totalCnt(paramMap);
		return totalCnt;
	}

	@Override
	public NtModel selectNotice(Map<String, Object> paramMap) throws Exception {

			ntDao.noticeReadCntUp(paramMap);		
		
		return ntDao.selectNotice(paramMap);
	}

	/** 공지사항 등록 */
	public int insertNotice(Map<String, Object> paramMap) throws Exception {
		
		return ntDao.insertNotice(paramMap);
	}
	
	/** 공지사항 수정 */
	public int updateNotice(Map<String, Object> paramMap) throws Exception {
		
		return ntDao.updateNotice(paramMap);
	}
	
	/** 공지사항 삭제 */
	public int deleteNotice(Map<String, Object> paramMap) throws Exception {
		
		return ntDao.deleteNotice(paramMap);
	}

}
