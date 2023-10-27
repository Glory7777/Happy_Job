package kr.happyjob.study.mngins.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngins.model.HwkFileModel;
import kr.happyjob.study.mngins.model.HwkModel;
import kr.happyjob.study.mngstd.model.SubmitHwkModel;



public interface ProjectService {
	
	
	/** 진행중인 강의 정보 불러오기
	 * @return 강의 정보(LectureModel)(mngadm.model)
	 * @author 김정욱
	 */
	LectureModel lecInfo(Map<String, Object> paramMap) throws Exception;

	
	/** 과제 목록 조회
	 * @return 과제 목록
	 * @author 김정욱
	 */
	List<HwkModel> findHwkList(Map<String, Object> paramMap) throws Exception;

	
	/** 수강중인 학생 명단
	 * @return 학생명단
	 * @author 김정욱
	 */
	List<Map> findAppStd(Map<String, Object> paramMap) throws Exception;

	/** 제출현황 조회
	 * @return 제출현황(List<Map>)
	 * @author 김정욱
	 */
	List<String> findHwkSmList(Map<String, Object> paramMap) throws Exception;

	
	/** 제출된 과제 조회
	 * @return 제출된 과제 정보(SubmitHwkModel)
	 * @author 김정욱
	 */
	SubmitHwkModel findHwkSmInfo(Map<String, Object> paramMap) throws Exception;

	
	/** 과제 파일 정보 조회
 	 * @return 파일 정보(HwkFileModel)
	 * @author 김정욱
	 */
	HwkFileModel hwkFileInfo(Map<String, Object> paramMap) throws Exception;


	/** 과제 신규 저장
	 * @return 성공여부
	 * @author 김정욱
	 */
	String insertHwk(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;


	/** 과제 갱신
	 * @return 성공여부
	 * @author 김정욱
	 */
	String updateHwk(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;


	/** 과제 삭제
	 * @return 성공여부
	 * @author 김정욱
	 */
	String deleteHwk(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;


	


	


}
