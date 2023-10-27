package kr.happyjob.study.sptins.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.sptins.model.FileInfoModel;
import kr.happyjob.study.sptins.model.LearningMaterialModel;
import kr.happyjob.study.sptins.model.WeeklyModel;


public interface LearningMaterialService {

	/**
	 * @return 주차수 목록
	 * @author 김정욱
	 * @param paramMap 
	 */
	List<LearningMaterialModel> lmFindWeeklyList(Map<String, Object> paramMap) throws Exception;

	
	/** 주차 관련 파일 정보 불러오기
	 * @param paramMap
	 * @return FileInfoModel
	 * @throws Exception
	 * @author 김정욱
	 */
	FileInfoModel findFileInfo(Map<String, Object> paramMap) throws Exception;


	/** 신규 저장
	 * @param paramMap
	 * @param request
	 * @return 성공 여부
	 * @author 김정욱
	 */
	String insertFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;

	
	/** 파일 갱신
	 * @param paramMap
	 * @param request
	 * @return 성공 여부
	 * @author 김정욱
	 */
	String updateFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;


	/** 파일 삭제
	 * @param paramMap
	 * @param request
	 * @return 성공 여부
	 * @author 김정욱
	 */
	String deleteFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
}
