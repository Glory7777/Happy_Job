package kr.happyjob.study.sptstd.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.sptins.model.FileInfoModel;
import kr.happyjob.study.sptstd.model.ALearningMaterialModel;


public interface ALearningMaterialService {

	
	/** 강의 코드 조회
	 * @return 강의코드
	 * @author 김정욱
	 */
	int selectLecCd(Map<String, Object> paramMap) throws Exception;

	
	/** 주차 목록 조회
	 * @param paramMap
	 * @return 주차 목록(List)
	 * @author 김정욱
	 */
	List<ALearningMaterialModel> lmFindWeeklyList(Map<String, Object> paramMap) throws Exception;


	/** 강의명 구하기
	 * @return 강의명
	 * @author 김정욱
	 */
	String selectLecNm(Map<String, Object> paramMap) throws Exception;


	/** 주차에 해당하는 파일 정보 불러오기
	 * @param paramMap
	 * @return 파일정보(FileInfoModel)
	 * @author 김정욱
	 */
	FileInfoModel selectWeek(Map<String, Object> paramMap) throws Exception;

}
