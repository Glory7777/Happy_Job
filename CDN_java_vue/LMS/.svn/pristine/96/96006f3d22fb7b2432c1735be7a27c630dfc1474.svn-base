package kr.happyjob.study.sptins.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.sptins.model.FileInfoModel;
import kr.happyjob.study.sptins.model.LearningMaterialModel;


public interface LearningMaterialDao {

	
	/** 로그인 강사가 진행중인 lec_cd 조회
	 * @param paramMap
	 * @return lec_cd
	 * @author 김정욱
	 */
	int findLecCd(Map<String, Object> paramMap) throws Exception;

	
	/** 주차 목록 조회
	 * @param paramMap
	 * @return 진행중인 lec의 주차 목록 조회
	 * @author 김정욱
	 */
	List<LearningMaterialModel> lmFindWeeklyList(Map<String, Object> paramMap) throws Exception;
	
	
	/** 해당 강의와 주차에 입력된 파일이 있는지 조회
	 * @param paramMap
	 * @return 0 또는 lec_file_no
	 * @author 김정욱
	 */
	int findLecFileNo(Map<String, Object> paramMap) throws Exception;


	/** 해당 강의와 주차에 해당하는 파일 정보 불러오기
	 * @param paramMap
	 * @return FileInfoModel
	 * @throws Exception
	 * @author 김정욱
	 */
	FileInfoModel findFileInfo(Map<String, Object> paramMap) throws Exception;


	/** 학습자료 테이블에 파일 신규 등록
	 * @param paramMap
	 * @return tb_lec_file의 pk
	 * @throws Exception
	 * @author 김정욱
	 */
	int insertFile(Map<String, Object> paramMap) throws Exception;


	/** 해당 주차에 파일 pk 등록
	 * @param paramMap
	 * @return 성공여부
	 * @throws Exception
	 * @author 김정욱
	 */
	int updateLecWeek(Map<String, Object> paramMap) throws Exception;

	
	/** 외래키로 인해 tb_lec_week의 파일 기본값(1)로 변경
	 * @return 성공여부
	 * @author 김정욱
	 */
	int updateLecWeekFile(Map<String, Object> paramMap) throws Exception;
	
	
	/** 파일 삭제
	 * @return 성공 여부
	 * @author 김정욱
	 */
	int deleteFile(Map<String, Object> paramMap) throws Exception;


	/** 학습자료 갱신 시, 파일 변경 X, 자료내용 변경 O
	 * @return 성공 여부
	 * @author 김정욱
	 */
	int lecFileCttUpdate(Map<String, Object> paramMap) throws Exception;




	


}


