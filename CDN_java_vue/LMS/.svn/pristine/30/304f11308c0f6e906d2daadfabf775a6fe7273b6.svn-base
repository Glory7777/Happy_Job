package kr.happyjob.study.sptins.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.sptins.model.LecPlanModel;
import kr.happyjob.study.sptins.model.WeeklyModel;


public interface LecPlanService {

	/** 강의 목록 조회
	 * @param paramMap
	 * @author 김정욱
	 */
	List<LectureModel> findLecList(Map<String, Object> paramMap) throws Exception;

	
	/** 강의 목록 총 갯수
	 * @param paramMap
	 * @author 김정욱
	 */
	int totalcnt(Map<String, Object> paramMap) throws Exception;


	/** 강의 정보 조회
	 * @param paramMap
	 * @return 강의 정보
	 * @author 김정욱
	 */
	LecPlanModel selectLec(Map<String, Object> paramMap) throws Exception;


	/** 주차수 목록 조회
	 * @param paramMap
	 * @return 해당 강의 주차 목록
	 * @author 김정욱
	 */
	List<WeeklyModel> findWeeklyList(Map<String, Object> paramMap) throws Exception;


	/** 강의 계획서 저장
	 * @return 성공 여부 메시지
	 * @author 김정욱
	 * @param request 
	 * @param paramMap 
	 */
	String saveLecPlan(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
}
