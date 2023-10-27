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

import kr.happyjob.study.facadm.dao.RoomDao;
import kr.happyjob.study.facadm.model.RoomDtlModel;
import kr.happyjob.study.facadm.model.RoomModel;

@Service
public class RoomServiceImpl implements RoomService {

	@Autowired
	RoomDao roomDao; // roomDao랑 자동연결

	@Override
	public List<RoomModel> listRoom(Map<String, Object> paramMap) throws Exception{ 

		List<RoomModel> listRoom = roomDao.listRoom(paramMap);//컨트롤에서 받아서 바로  다오로 던지고 받기
		return listRoom;
	}

	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {
		int totalCnt = roomDao.totalCnt(paramMap);
		return totalCnt;
	}

	@Override
	public RoomModel selectRoom(Map<String, Object> paramMap) throws Exception {
		return roomDao.selectRoom(paramMap);
	}

	/** 강의실 등록 */
	public int insertRoom(Map<String, Object> paramMap) throws Exception {
		
		return roomDao.insertRoom(paramMap);
	}
	
	/** 강의실 수정 */
	public int updateRoom(Map<String, Object> paramMap) throws Exception {
		return roomDao.updateRoom(paramMap);
	}
	
	/** 강의실 삭제 */
	public int deleteRoom(Map<String, Object> paramMap) throws Exception {
		
		return roomDao.deleteRoom(paramMap);
	}
	
	
	
	/** 강의실내역 목록 조회 */
	public List<RoomDtlModel> listRoomDtl(Map<String, Object> paramMap) throws Exception {
		
		List<RoomDtlModel> listRoomDtl = roomDao.listRoomDtl(paramMap);
		
		return listRoomDtl;
	}
	
	/** 강의실내역 목록 카운트 조회 */
	public int totalCntDtl(Map<String, Object> paramMap) throws Exception {
		
		int totalCntDtl = roomDao.totalCntDtl(paramMap);
		
		return totalCntDtl;
	}
	
	/** 강의실내역 단건 조회 */
	public RoomDtlModel selectRoomDtl(Map<String, Object> paramMap) throws Exception {
		
		RoomDtlModel RoomDtlModel = roomDao.selectRoomDtl(paramMap);
		return RoomDtlModel;
	}
	// 강의실 강의실 중복여부
	public int dupEquCheck(Map<String, Object> paramMap) throws Exception {
		return roomDao.dupEquCheck(paramMap);
	}	
	public int getAbleCnt(Map<String, Object> paramMap) throws Exception {
		return roomDao.getAbleCnt(paramMap);
	}
	/** 강의실내역 저장 */
	public int insertRoomDtl(Map<String, Object> paramMap) throws Exception {
		roomDao.insertAbleRoom(paramMap);
		return roomDao.insertRoomDtl(paramMap);
	}
	
	/** 강의실내역 수정 */
	public int updateRoomDtl(Map<String, Object> paramMap) throws Exception {
		roomDao.updateRoomDtl(paramMap);
		
		return roomDao.updateAbleRoom(paramMap);
	}
	
	/** 강의실내역 삭제 */
	public int deleteRoomDtl(Map<String, Object> paramMap) throws Exception {
		roomDao.deleteRoomDtl(paramMap);
		return roomDao.deleteAbleRoom(paramMap);
	}
	

}
