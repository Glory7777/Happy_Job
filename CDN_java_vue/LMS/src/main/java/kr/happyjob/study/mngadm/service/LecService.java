package kr.happyjob.study.mngadm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngadm.model.StdModel;


public interface LecService {

	
	/** 강의 목록
	 * @param paramMap
	 */
	List<LectureModel> lecList(Map<String, Object> paramMap) throws Exception;

	/** 목록 총 갯수
	 * @param paramMap
	 */
	int totalcnt(Map<String, Object> paramMap) throws Exception;

	
	/** 강의 저장
	 * @param paramMap
	 */
	String insertLec(Map<String, Object> paramMap) throws Exception;

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
	String updateLec(Map<String, Object> paramMap) throws Exception;

	
	/** 강의 삭제
	 */
	String deleteLec(Map<String, Object> paramMap) throws Exception;

	
	/** 학생 목록 조회
	 */
	List<StdModel> stdList(Map<String, Object> paramMap) throws Exception;

	
	/** 학생 목록 갯수 조회
	 */
	int stdTotalcnt(Map<String, Object> paramMap) throws Exception;
	
	
	/** 강의 삭제 하기
	 * @return 성공여부(msg)
	 * @author 김정욱
	 */
	String closeLec(Map<String, Object> paramMap) throws Exception;

}
