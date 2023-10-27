package kr.happyjob.study.sptins.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.sptins.model.LecPlanModel;
import kr.happyjob.study.sptins.model.WeeklyModel;

public interface LecPlanDao {

	/** 강의 목록 조회
	 * @param paramMap
	 * @return list, 강의 목록
	 * @author 김정욱
	 */
	List<LectureModel> findLecList(Map<String, Object> paramMap) throws Exception;

		
	/** 강의 목록 총 갯수
	 * @param paramMap
	 * @return int, 조회된 행의 갯수
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
	 * @param paramMap
	 * @throws Exception
	 * @author 김정욱
	 */
	int lecGoal(Map<String, Object> paramMap) throws Exception;


	/** 초기 주차수 정보 넣기, 갯수가 증가 되었을 때
	 * @param weekList
	 * @return 성공 여부 반환
	 * @author 김정욱
	 */
	int inputWeekly(List<Map> weekList) throws Exception;


	/** 갱신 갯수가 같을 때, 기존 갯수 update
	 * @param weekList
	 * @return 성공 여부 반환
	 * @author 김정욱
	 */
	int updateWeeklySame(List<Map> weekList) throws Exception;


	/** 갱신 갯수가 다르고, 줄어들었을 때
	 * @param weekListSep
	 * @return
	 * @throws Exception
	 * @author 김정욱
	 */
	int deleteWeekly(List<Map> weekListSep) throws Exception;

}


