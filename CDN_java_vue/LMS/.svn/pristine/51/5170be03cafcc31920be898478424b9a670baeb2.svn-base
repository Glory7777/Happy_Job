package kr.happyjob.study.sptstd.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.sptins.model.FileInfoModel;
import kr.happyjob.study.sptstd.model.ALearningMaterialModel;


public interface ALearningMaterialDao {


	/** 강의 코드 조회
	 * @return 강의 코드
	 * @author 김정욱
	 */
	int selectLecCd(Map<String, Object> paramMap) throws Exception;
	
	
	/** 강의명 조회
	 * @return 강의명
	 * @author 김정욱
	 */
	String selectLecNm(Map<String, Object> paramMap) throws Exception;

	
	/** 주차 목록 조회
	 * @return 주차 목록
	 * @author 김정욱
	 */
	List<ALearningMaterialModel> lmFindWeeklyList(Map<String, Object> paramMap) throws Exception;


	/** 파일정보 불러오기
	 * @return 파일정보(FileInfoModel)
	 * @author 김정욱
	 */
	FileInfoModel selectWeek(Map<String, Object> paramMap) throws Exception;



}


