package kr.happyjob.study.facadm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.facadm.model.EquDtlModel;
import kr.happyjob.study.facadm.model.EquModel;

public interface EquDao {

	
	// 장비 리스트 조회
	public List<EquModel> listEqu(Map<String, Object> paramMap)throws Exception ; // 이걸 xml로 던져버리기
	
	// 장비 목록 카운트 조회
	public int totalCnt(Map<String, Object> paramMap)throws Exception ;
	
	/** 장비 한건 조회 */
	public EquModel selectEqu(Map<String, Object> paramMap) throws Exception;	
	

	/** 장비 등록 */
	public int insertEqu(Map<String, Object> paramMap) throws Exception;
	
	/** 장비 수정 */
	public int updateEqu(Map<String, Object> paramMap) throws Exception;
	/*public int updateUnable(Map<String, Object> paramMap) throws Exception;*/
	
	/** 장비 삭제 */
	public int deleteEqu(Map<String, Object> paramMap) throws Exception;
	
	/////////////////////////////////////////////////////////////////////////
	/** 장비 내역 목록 조회 */
	public List<EquDtlModel> listEquDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 그룹코드 목록 카운트 조회 */
	public int totalCntDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 장비 내역 단건 조회 */
	public EquDtlModel selectEquDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 장비 내역 저장 */
	public int insertEquDtl(Map<String, Object> paramMap) throws Exception;
	// 내역 저장과 동시에 총 사용가능량에서 차감
	public int insertAbleEqu(Map<String, Object> paramMap) throws Exception;
	
	/** 장비 내역 수정 */
	public int updateAbleEqu(Map<String, Object> paramMap) throws Exception;
	public int updateEquDtl(Map<String, Object> paramMap) throws Exception;
	
	/** 장비 내역 삭제 */
	public int deleteAbleEqu(Map<String, Object> paramMap) throws Exception;
	public int deleteEquDtl(Map<String, Object> paramMap) throws Exception;
	
	// 장비 강의실 중복여부
	public int dupRoomCheck(Map<String, Object> paramMap) throws Exception;
	}
