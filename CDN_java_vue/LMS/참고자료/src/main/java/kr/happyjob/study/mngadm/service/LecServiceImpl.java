package kr.happyjob.study.mngadm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mngadm.dao.LecDao;
import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngadm.model.StdModel;
import kr.happyjob.study.system.dao.ComnCodDao;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Service
public class LecServiceImpl implements LecService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LecDao lecDao;
	
	
	/** 강의 목록 */
	@Override
	public List<LectureModel> lecList(Map<String, Object> paramMap) throws Exception {
		return lecDao.lecList(paramMap);
	}
	
	/** 목록 총 갯수 */
	@Override
	public int totalcnt(Map<String, Object> paramMap) throws Exception {
		return lecDao.totalcnt(paramMap);
	}
	
	/** 강의 등록 */
	@Override
	public String insertLec(Map<String, Object> paramMap) throws Exception {
		
		// 강의실 사용으로 업데이트
		lecDao.clsRoomUpdate(paramMap);
		
		int result = 0;
		result = lecDao.insertLec(paramMap);
		
		String msg = null;
		
		if(result != 0) msg = "저장 성공";
		else msg = "저장 실패";
		
		return msg;
	}

	/** 강의 목록 조회 */
	@Override
	public List<Map> clsRoomList() throws Exception {
		return lecDao.clsRoomList();
	}

	/** 강사 목록 조회 */
	@Override
	public List<Map> insList() throws Exception {
		return lecDao.insList();
	}

	/** 강의 내용 조회*/
	@Override
	public LectureModel selectLec(Map<String, Object> paramMap) throws Exception{
		return lecDao.selectLec(paramMap);
	}

	/** 강의 갱신 */
	@Override
	public String updateLec(Map<String, Object> paramMap) throws Exception {
		
		String cls_room = paramMap.get("cls_room").toString();
		String before_cls_room = paramMap.get("before_cls_room").toString();
		
		if(!cls_room.equals(before_cls_room)){
			// 바뀐 강의실 사용 갱신
			lecDao.clsRoomUpdate(paramMap);
			
			// 기존 강의실 사용 갱신
			lecDao.beforeClsRoomUpdate(paramMap);
			
		}
		
		int result = 0;
		result = lecDao.updateLec(paramMap);
		
		String msg = null;
		
		if(result != 0) msg = "갱신 성공";
		else msg = "갱신 실패";
		
		return msg;
	}

	/** 강의 삭제 */
	@Override
	public String deleteLec(Map<String, Object> paramMap) throws Exception {
	
		lecDao.beforeClsRoomUpdate(paramMap);
		
		int result = 0;
		result = lecDao.deleteLec(paramMap);
		
		String msg = null;
		
		if(result != 0) msg = "삭제 성공";
		else msg = "삭제 실패";
		
		return msg;
	}

	
	/** 학생 목록 조회*/
	@Override
	public List<StdModel> stdList(Map<String, Object> paramMap) throws Exception {
		return lecDao.stdList(paramMap);
	}

	
	/** 학생 목록 갯수 조회*/
	@Override
	public int stdTotalcnt(Map<String, Object> paramMap) throws Exception {
		return lecDao.stdTotalcnt(paramMap);
	}
	
	
	
}
