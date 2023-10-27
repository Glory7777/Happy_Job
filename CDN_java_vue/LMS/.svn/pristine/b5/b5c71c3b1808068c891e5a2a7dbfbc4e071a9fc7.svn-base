package kr.happyjob.study.facadm.service;

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

import kr.happyjob.study.facadm.dao.EquDao;
import kr.happyjob.study.facadm.model.EquDtlModel;
import kr.happyjob.study.facadm.model.EquModel;

@Service
public class EquServiceImpl implements EquService {

	@Autowired
	EquDao equDao; // equDao랑 자동연결

	@Override
	public List<EquModel> listEqu(Map<String, Object> paramMap) throws Exception{ 

		List<EquModel> listEqu = equDao.listEqu(paramMap);//컨트롤에서 받아서 바로  다오로 던지고 받기
		return listEqu;
	}

	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = equDao.totalCnt(paramMap);
		return totalCnt;
	}

	@Override
	public EquModel selectEqu(Map<String, Object> paramMap) throws Exception {
		return equDao.selectEqu(paramMap);
	}

	/** 장비 등록 */
	public int insertEqu(Map<String, Object> paramMap) throws Exception {
		
		return equDao.insertEqu(paramMap);
	}
	
	/** 장비 수정 */
	public int updateEqu(Map<String, Object> paramMap) throws Exception {
		return equDao.updateEqu(paramMap);
	}
	
	/** 장비 삭제 */
	public int deleteEqu(Map<String, Object> paramMap) throws Exception {
		
		return equDao.deleteEqu(paramMap);
	}
	
	
	
	/** 장비내역 목록 조회 */
	public List<EquDtlModel> listEquDtl(Map<String, Object> paramMap) throws Exception {
		
		List<EquDtlModel> listEquDtl = equDao.listEquDtl(paramMap);
		
		return listEquDtl;
	}
	
	/** 장비내역 목록 카운트 조회 */
	public int totalCntDtl(Map<String, Object> paramMap) throws Exception {
		
		int totalCntDtl = equDao.totalCntDtl(paramMap);
		
		return totalCntDtl;
	}
	
	/** 장비내역 단건 조회 */
	public EquDtlModel selectEquDtl(Map<String, Object> paramMap) throws Exception {
		
		EquDtlModel EquDtlModel = equDao.selectEquDtl(paramMap);
		return EquDtlModel;
	}
	
	/** 장비내역 저장 */
	public int insertEquDtl(Map<String, Object> paramMap) throws Exception {
		equDao.insertAbleEqu(paramMap);
		return equDao.insertEquDtl(paramMap);
	}
	
	/** 장비내역 수정 */
	public int updateEquDtl(Map<String, Object> paramMap) throws Exception {
		equDao.updateEquDtl(paramMap);
		
		return equDao.updateAbleEqu(paramMap);
	}
	
	/** 장비내역 삭제 */
	public int deleteEquDtl(Map<String, Object> paramMap) throws Exception {
		equDao.deleteEquDtl(paramMap);
		return equDao.deleteAbleEqu(paramMap);
	}
	// 장비 강의실 중복여부
	public int dupRoomCheck(Map<String, Object> paramMap) throws Exception {
		return equDao.dupRoomCheck(paramMap);
	}
	

}
