package kr.happyjob.study.mngstd.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.mngstd.dao.LevelTestDao;
import kr.happyjob.study.mngstd.dao.MylecListDao;
import kr.happyjob.study.mngstd.model.LevelTestModel;
import kr.happyjob.study.mngstd.model.MylecListModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;



@Service
public class LevelTestServiceImpl implements LevelTestService {

		@Autowired
		LevelTestDao leveltestdao;
	
	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());
	   
	   // Get class name for logger
	   private final String className = this.getClass().toString();

	   
	   
	   //내가 신청한 강의의 개설된 시험 조회하기 
	   @Override
		public List<LevelTestModel> testList(Map<String, Object> paramMap) throws Exception{
			
			return leveltestdao.testList(paramMap);
		}
	   
	   
	   /* 시험제출하기 */ 
	   @Override
		public int TestSubmit(Map<String, Object> paramMap) throws Exception{
		   return leveltestdao.TestSubmit(paramMap);
	   }
	   
		/* 시험제출하기 2*/  
	   @Override
		public int TestSubmit2(Map<String, Object> paramMap) throws Exception{
		   return leveltestdao.TestSubmit2(paramMap);
		}
	   
	   /* 시험결과조회*/ 
	   @Override
	   public List<LevelTestModel> resultList(Map<String, Object> paramMap) throws Exception{
		   return leveltestdao.resultList(paramMap);
	   }
	   
	   /* 시험결과조회2*/ 
	   @Override
	   public List<LevelTestModel> resultList2(Map<String, Object> paramMap) throws Exception{
		   return leveltestdao.resultList2(paramMap);
	   }
	   
}
