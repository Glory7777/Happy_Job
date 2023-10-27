package kr.happyjob.study.mngstd.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngins.model.HwkFileModel;
import kr.happyjob.study.mngins.model.HwkModel;
import kr.happyjob.study.mngstd.model.SmFileModel;
import kr.happyjob.study.mngstd.model.SubmitHwkModel;



public interface SubmittedWorkDao {

	/** 학생 강의 코드 조회
	 * @return 강의코드(lec_cd)
	 * @author 김정욱
	 */
	int findLecCd(Map<String, Object> paramMap) throws Exception;

	
	/** 강의 정보 조회
	 * @return 강의정보(LectureModel: mngadm.model)
	 * @author 김정욱
	 */
	LectureModel findLecInfo(Map<String, Object> paramMap) throws Exception;


	/** 과제 목록 조회
	 * @return 과제 목록
	 * @author 김정욱
	 */
	List<HwkModel> findHwkList(Map<String, Object> paramMap) throws Exception;
	
	
	/** 과제 목록 총개수
	 * @return int
	 * @author 김정욱
	 */
	int totalcnt(Map<String, Object> paramMap) throws Exception;
	
	
	/** 학생이 제출한 과제 목록 조회
	 * @return 제출한 과제 리스트(hwk_no)
	 * @author 김정욱
	 */
	List<Integer> findSmHwkList(Map<String, Object> paramMap) throws Exception;


	/** 신규저장 파일 넣고, pk 받기
	 * @return 성공여부, sm_file_no
	 * @author 김정욱
	 */
	int insertSmFile(Map<String, Object> paramMap) throws Exception;


	/** 신규저장 과제체출 테이블
	 * @return 성공여부
	 * @author 김정욱
	 */
	int insertHwkSm(Map<String, Object> paramMap) throws Exception;


	/** 과제 제출 여부 조회
	 * @return 제출과제정보(SubmitHwkModel)
	 * @author 김정욱
	 */
	SubmitHwkModel findHwkSm(Map<String, Object> paramMap) throws Exception;


	/** 제출된 파일 정보 조회
	 * @param sm_file_no
	 * @return 제출된 파일 정보(SmFileModel)
	 * @author 김정욱
	 */
	SmFileModel findSmFileInfo(int sm_file_no) throws Exception;


	/** 파일번호 조회
	 * @return 파일번호
	 * @author 김정욱
	 */
	int findSmFileNo(Map<String, Object> paramMap) throws Exception;


	/** 과제 삭제
	 * @return 성공여부
	 * @author 김정욱
	 */
	int deleteHwkSm(Map<String, Object> paramMap) throws Exception;


	/** 제출 파일 삭제
	 * @param sm_file_no
	 * @return 성공여부
	 * @author 김정욱
	 */
	int deleteSmFile(int sm_file_no) throws Exception;


	/** 과제 갱신
	 * @return 성공여부
	 * @author 김정욱
	 */
	int updateHwkSm(Map<String, Object> paramMap) throws Exception;


	


	


	


}


