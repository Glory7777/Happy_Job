package kr.happyjob.study.mngwin.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.happyjob.study.mngwin.model.TestManageModel;
import kr.happyjob.study.sptstd.model.LectureListModel;

public interface TestManageDao {

	
	//강의명 가져오기
		public List<LectureListModel> selectlist(Map<String, Object> paramMap)throws Exception;
		
	   /** 시험목록 목록 조회 */
	   public List<TestManageModel> testAllList(Map<String, Object> paramMap) throws Exception;
	   
	   
	   /** 강의 건수 조회 */
	   public int totaltest(Map<String, Object> paramMap) throws Exception;
		
	   
	   /** 문제은행 전체 목록 조회 */
	   public List<TestManageModel> testBankList(Map<String, Object> paramMap) throws Exception;
	   
	   
	   
	   /* 수정 하기 전 단건조회 */
	   public List<TestManageModel> selectview(Map<String, Object> paramMap) throws Exception;
	   
	   
	   /* 저장하기 */
	   public int testsave(Map<String, Object> paramMap) throws Exception;
	   
	   
	   /* 수정하기 */
	   public int testupdate(Map<String, Object> paramMap) throws Exception;
	    
	   
	   /* 삭제하기 */
	   public int testdelete(Map<String, Object> paramMap) throws Exception;	
	   
	   
	   /* 시험지만들기 */
	   public  List<TestManageModel> papermade(Map<String, Object> parameterMap)throws Exception;


	   /* 시험등록하기 */
	   public int testregi(Map<String, Object> paramMap) throws Exception;

	   /* 시험 */
	   public int insertTestCdPaper(Map<String, Object> paramMap)throws Exception;
	   
	   /* 시험지의 상세정보보기*/

	   public List<TestManageModel> detailview(Map<String, Object> parameterMap) throws Exception;
	   
	   /* 시험 차수 체크 */
	   public String checkTestId(Map<String, Object> paramMap) throws Exception;
}
