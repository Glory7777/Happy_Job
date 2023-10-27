package kr.happyjob.study.mngstd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.mngstd.model.LevelTestModel;
import kr.happyjob.study.mngstd.model.MylecListModel;
import kr.happyjob.study.mngstd.service.LevelTestService;
import kr.happyjob.study.mngstd.service.MylecListService;
import kr.happyjob.study.sptstd.model.LectureListModel;



@Controller
@RequestMapping("/std/")
public class LevelTestController {

	   @Autowired
	   LevelTestService leveltest;
	   
	   
	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   
	   /**
	    *화면연결
	    */
	   @RequestMapping("testApplications.do")
	   public String testApplications(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      
	         logger.info("+ Start " + className + ".testApplications");
	         logger.info("   - paramMap : " + paramMap);
	         
	         logger.info("+ End " + className + ".testApplications");
	   
	         return  "mngstd/LevelTest";
	   }
	   
	   // Vue.js - 화면 연결
	   @RequestMapping("testApplicationsvue.do")
	   public String testApplicationsvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception {

		   logger.info("+ Start " + className + ".testApplications");
		   logger.info("   - paramMap : " + paramMap);
		   
		   logger.info("+ End " + className + ".testApplications");
		   
		   return  "mngstd/LevelTestVue";
	   }
	   
	   //내가 신청한 강의의 개설된 시험 조회하기
	   @RequestMapping("testList.do")
	   @ResponseBody
	   public Map<String, Object>testList2 (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	         logger.info("+ Start " + className + ".testList");
	         logger.info("   - paramMap : " + paramMap);
	           
	         paramMap.put("loginId", (String) session.getAttribute("loginId"));  
	         
	         List<LevelTestModel> testList = leveltest.testList(paramMap);
	         
	         System.out.println("testList:::::"+testList);
	         
	         Map<String, Object> resultMap = new HashMap<String, Object>();
	         
	         resultMap.put("testList", testList);
	         
	         System.out.println("==========MylecList==============="+testList);

	         logger.info("+ End " + className + ".testList");

	       
	      return resultMap;
	   }
	   
	   /* 시험제출하기 */            
	   @ResponseBody
	   @RequestMapping("TestSubmit.do")
	   public int TestSubmit (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	           logger.info("+ Start " + className + ".TestSubmit");
	           logger.info("   - paramMap : " + paramMap);
	      
	           paramMap.put("loginID", (String) session.getAttribute("loginId"));
	           
	           int TestSubmit = leveltest.TestSubmit(paramMap);

	           System.out.println("TestSubmit:::::"+TestSubmit);

	           logger.info("+ End " + className + ".testList");

	       
	      return TestSubmit;
	   
	   }
	   
	   
	   /* 시험제출하기 */            
	   @ResponseBody
	   @RequestMapping("TestSubmit2.do")
	   public Map<String, Object> TestSubmit2(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	           logger.info("+ Start " + className + ".TestSubmit2");
	           logger.info("   - paramMap : " + paramMap);
	           
	           paramMap.put("loginID", (String) session.getAttribute("loginId"));
	      
	           Map<String, Object>resultMap = new HashMap<String, Object>();
	           
	           int TestResult = leveltest.TestSubmit2(paramMap);

	           resultMap.put("TestResult", TestResult);

	           System.out.println("============TestResult================"+TestResult);
	           
	           logger.info("+ End " + className + ".TestSubmit2");

	       
	      return resultMap;
	   
	   } 
	
	   /* 시험제출하기 */            
	   @ResponseBody
	   @RequestMapping("Testconfirm.do")
	   public Map<String, Object> Testconfirm(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	           logger.info("+ Start " + className + ".Testconfirm");
	           logger.info("   - paramMap : " + paramMap);
	      
	           paramMap.put("loginID", (String) session.getAttribute("loginId"));
	           
	           Map<String, Object>resultMap = new HashMap<String, Object>();
	           
	           List<LevelTestModel> resultList = leveltest.resultList(paramMap);

	           List<LevelTestModel> resultList2 = leveltest.resultList2(paramMap);
	           
	           resultMap.put("resultList", resultList);
	           resultMap.put("resultList2", resultList2);

	           System.out.println("============resultList================"+resultList);
	           
	           logger.info("+ End " + className + ".Testconfirm");

	       
	      return resultMap;
	   
	   } 
	   
}
