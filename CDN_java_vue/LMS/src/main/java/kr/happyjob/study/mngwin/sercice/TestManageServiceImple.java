package kr.happyjob.study.mngwin.sercice;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mngwin.dao.TestManageDao;
import kr.happyjob.study.mngwin.model.TestManageModel;
import kr.happyjob.study.sptstd.model.LectureListModel;
@Service
public class TestManageServiceImple implements TestManageService{
	
	@Autowired
	TestManageDao testmanagedao;

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();
	
	//강의명 가져오기
   @Override
	public List<LectureListModel> selectlist(Map<String, Object> paramMap)throws Exception{
		
		return testmanagedao.selectlist(paramMap);
	}
		
	
   /** 시험목록 목록 조회 */
   @Override
   public List<TestManageModel> testAllList(Map<String, Object> paramMap) throws Exception{
	   
	   return testmanagedao.testAllList(paramMap);
   }
   
   
   /** 강의 건수 조회 */
   @Override
   public int totaltest(Map<String, Object> paramMap) throws Exception{
	   
	   return testmanagedao.totaltest(paramMap);
   }
   
   
   /** 문제은행 전체 목록 조회 */
   @Override
   public List<TestManageModel> testBankList(Map<String, Object> paramMap) throws Exception{
	   
	   return testmanagedao.testBankList(paramMap);
   }
   
   
   
   /** 문제은행 전체 목록 조회 */
   @Override
   public List<TestManageModel> selectview(Map<String, Object> paramMap) throws Exception{
	   
	   return testmanagedao.selectview(paramMap);
   }
   
   
   /* 저장하기 */
   @Override
   public int testsave(Map<String, Object> paramMap) throws Exception{
	   
	   return testmanagedao.testsave(paramMap);
	   
   }
   
   
   /* 수정하기 */
   @Override
   public int testupdate(Map<String, Object> paramMap) throws Exception{
	   
	   return testmanagedao.testupdate(paramMap);
   }
   
   
   /* 삭제하기 */
   @Override
   public int testdelete(Map<String, Object> paramMap) throws Exception{
	   
	   return testmanagedao.testdelete(paramMap);
   }
   
   /* 시험지만들기 */
   @Override
   public List<TestManageModel>papermade (Map<String, Object> parameterMap)throws Exception{
	   
	   return testmanagedao.papermade(parameterMap);
   }
   
   
   
   /* 시험등록하기 */
   @Override
   public int testregi(Map<String, Object> paramMap) throws Exception{
	   
	   return testmanagedao.testregi(paramMap);
   }
   
   /* 시험 문제 등록하기 (브릿지 테이블)*/
   @Override
   public int insertTestCdPaper(Map<String, Object> parameterMap) throws Exception{
	   
	   return testmanagedao.insertTestCdPaper(parameterMap);
	   
   }
   
   /* 시험지의 상세정보보기*/
   @Override
   public List<TestManageModel> detailview(Map<String, Object> parameterMap) throws Exception{
	   
	   return testmanagedao.detailview(parameterMap);
   }


	@Override
	public String checkTestId(Map<String, Object> paramMap) throws Exception {
		
		return testmanagedao.checkTestId(paramMap);
	}
   
}
