package kr.happyjob.study.mngadm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngadm.model.StdModel;


public interface LecDao {

	/** 강의 목록
	 * @param paramMap
	 */
	List<LectureModel> lecList(Map<String, Object> paramMap) throws Exception;

	
	/** 목록 총 갯수
	 * @param paramMap
	 */
	int totalcnt(Map<String, Object> paramMap) throws Exception;

	
	/** 강의실 사용으로 업데이트
	 * @param paramMap
	 */
	void clsRoomUpdate(Map<String, Object> paramMap) throws Exception;
	
	/** 기존 강의실 사용 업데이트
	 * @param paramMap
	 */
	void beforeClsRoomUpdate(Map<String, Object> paramMap) throws Exception;


	/** 강의 등록
	 * @param paramMap
	 */
	int insertLec(Map<String, Object> paramMap) throws Exception;


	/** 강의실 목록 조회
	 */
	List<Map> clsRoomList() throws Exception;


	/** 강사 목록 조회
	 */
	List<Map> insList() throws Exception;


	/** 강의 내용 조회
	 */
	LectureModel selectLec(Map<String, Object> paramMap) throws Exception;


	/** 강의 갱신
	 */
	int updateLec(Map<String, Object> paramMap) throws Exception;


	/** 강의 삭제
	 */
	int deleteLec(Map<String, Object> paramMap) throws Exception;


	/** 학생 목록 조회
	 */
	List<StdModel> stdList(Map<String, Object> paramMap) throws Exception;


	/** 학생 목록 갯수 조회
	 */
	int stdTotalcnt(Map<String, Object> paramMap) throws Exception;




}


