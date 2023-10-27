package kr.happyjob.study.facadm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.facadm.model.RoomDtlModel;
import kr.happyjob.study.facadm.model.RoomModel;

public interface RoomService {

	/** 강의실 목록 조회 */
	public List<RoomModel> listRoom(Map<String, Object> paramMap) throws Exception; 
	
	/** 강의실 카운트 조회 */
	public int totalCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 한건 조회 */
	public RoomModel selectRoom(Map<String, Object> paramMap) throws Exception;
	
	
	/** 강의실 등록 */
	public int insertRoom(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 수정 */
	public int updateRoom(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 삭제 */
	public int deleteRoom(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 목록 조회 */
	public List<RoomDtlModel> listRoomDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 목록 카운트 조회 */
	public int totalCntDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 단건 조회 */
	public RoomDtlModel selectRoomDtl(Map<String, Object> paramMap) throws Exception;
	
	// 강의실 강의실 중복체크
	public int dupEquCheck(Map<String, Object> paramMap) throws Exception;
	public int getAbleCnt(Map<String, Object> paramMap) throws Exception;
	
	
	/** 강의실 내역 저장 */
	public int insertRoomDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 수정 */
	public int updateRoomDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 삭제 */
	public int deleteRoomDtl(Map<String, Object> paramMap) throws Exception;
}
