package kr.happyjob.study.facadm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.facadm.model.RoomDtlModel;
import kr.happyjob.study.facadm.model.RoomModel;

public interface RoomDao {

	
	// 강의실 리스트 조회
	public List<RoomModel> listRoom(Map<String, Object> paramMap)throws Exception ; // 이걸 xml로 던져버리기
	
	// 강의실 목록 카운트 조회
	public int totalCnt(Map<String, Object> paramMap)throws Exception ;
	
	/** 강의실 한건 조회 */
	public RoomModel selectRoom(Map<String, Object> paramMap) throws Exception;	
	

	/** 강의실 등록 */
	public int insertRoom(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 수정 */
	public int updateRoom(Map<String, Object> paramMap) throws Exception;
	/*public int updateUnable(Map<String, Object> paramMap) throws Exception;*/
	
	/** 강의실 삭제 */
	public int deleteRoom(Map<String, Object> paramMap) throws Exception;
	
//	/////////////////////////////////////////////////////////////////////////
	/** 강의실 내역 목록 조회 */
	public List<RoomDtlModel> listRoomDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 목록 카운트 조회 */
	public int totalCntDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 단건 조회 */
	public RoomDtlModel selectRoomDtl(Map<String, Object> paramMap) throws Exception;
	
	// 강의실 장비 중복여부
	public int dupEquCheck(Map<String, Object> paramMap) throws Exception;
	// 강의실 장비 사용가능 수량 조회
	public int getAbleCnt(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 저장 */
	public int insertRoomDtl(Map<String, Object> paramMap) throws Exception;
	// 내역 저장과 동시에 총 사용가능량에서 차감
	public int insertAbleRoom(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 수정 */
	public int updateAbleRoom(Map<String, Object> paramMap) throws Exception;
	public int updateRoomDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 강의실 내역 삭제 */
	public int deleteAbleRoom(Map<String, Object> paramMap) throws Exception;
	public int deleteRoomDtl(Map<String, Object> paramMap) throws Exception;
	
	
}
