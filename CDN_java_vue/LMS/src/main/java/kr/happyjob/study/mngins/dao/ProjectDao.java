package kr.happyjob.study.mngins.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngins.model.HwkFileModel;
import kr.happyjob.study.mngins.model.HwkModel;
import kr.happyjob.study.mngstd.model.SubmitHwkModel;


public interface ProjectDao {

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
	 * @return 학생 명단
	 * @author 김정욱
	 */
	List<Map> findAppStd(Map<String, Object> paramMap) throws Exception;

	
	/** 제출 현황 조회
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
	 * @return 파일정보(HwkFileModel)
	 * @author 김정욱
	 */
	HwkFileModel hwkFileInfo(Map<String, Object> paramMap) throws Exception;


	/** 신규저장(파일X) 
	 * @return 성공여부
	 * @author 김정욱
	 */
	int insertHwk(Map<String, Object> paramMap) throws Exception;
	
	
	/** 과제 파일 테이블에 파일 넣기
	 * @return 성공여부, 파일번호(hwk_file_no)
	 * @author 김정욱
	 */
	int insertHwkFile(Map<String, Object> paramMap) throws Exception;


	/** 과제 갱신
	 * @return 성공여부
	 * @author 김정욱
	 */
	int updateHwk(Map<String, Object> paramMap) throws Exception;


	/** 파일 삭제 전 hwk_file_no 가져오기
	 * @return hwk_file_no
	 * @author 김정욱
	 */
	int findHwkFileNo(Map<String, Object> paramMap) throws Exception;

	
	/** 과제 삭제
	 * @return 성공여부
	 * @author 김정욱
	 */
	int deleteHwk(Map<String, Object> paramMap) throws Exception;


	/** 과제 파일 삭제
	 * @author 김정욱
	 */
	void deleteHwkFile(Map<String, Object> paramMap) throws Exception;


	


}


