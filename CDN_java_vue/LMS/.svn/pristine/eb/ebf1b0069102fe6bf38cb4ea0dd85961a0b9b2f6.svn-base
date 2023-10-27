package kr.happyjob.study.mngwin.controller;

import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.mngins.model.LectureStudentModel;
import kr.happyjob.study.mngwin.model.TestManageModel;
import kr.happyjob.study.mngwin.sercice.TestManageService;
import kr.happyjob.study.sptstd.model.LectureListModel;

@Controller
@RequestMapping("/tut/")
public class TestManageController {

	@Autowired
	TestManageService testmanagementservice;
	
	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();

	   
	   int  lec_cd =0;  // js에서 몬가 얽히고 거지같이 해버려서 어쩔 수 없이 자바에서 해결....ㅠㅠ
	   	
	   String test_cd=""; //시험코그
	   
	   /**
	    *화면연결
	    */
	   @RequestMapping("testControl.do")
	   public String registerList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	      
	      
	         logger.info("+ Start " + className + ".lectureList");
	         logger.info("   - paramMap : " + paramMap);
	         
	         logger.info("+ End " + className + ".lectureList");
	   
	         return  "mngwin/TestManage";
	   }
	   
	   // Vue.js - 시험관리Vue 화면 연결
	   @RequestMapping("testControlvue.do")
	   public String registerListvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception {
		   
		   
		   logger.info("+ Start " + className + ".lectureList");
		   logger.info("   - paramMap : " + paramMap);
		   
		   logger.info("+ End " + className + ".lectureList");
		   
		   return  "mngwin/TestManageVue";
	   }
	   
	   
	   
	   //강의명 가져오기
	   @ResponseBody
	   @RequestMapping("selectlist.do")
	   public Map<String, Object> selectlist (Model model, @RequestParam Map<String, Object> paramMap,HttpServletRequest request,
		         HttpServletResponse response, HttpSession session) throws Exception {

           logger.info("+ Start " + className + ".selectlist");
           logger.info("   - paramMap : " + paramMap);
		   
           String loginId = (String)session.getAttribute("loginId");
           paramMap.put("loginId", loginId);
           
           List<LectureListModel> selectlist = testmanagementservice.selectlist(paramMap);
		   
           Map<String, Object> list = new HashMap<String, Object>();
           
           list.put("loginId", loginId);
           
           list.put("selectlist", selectlist);
           
           logger.info("   - list : " + selectlist);
           
		   return list;
		   
	   }
	   
	   //전체리스트 출력
	   @ResponseBody
	   @RequestMapping("testAllList.do")
	   public Map<String, Object> testAllList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	         
	         logger.info("+ Start " + className + ".testAllList");
	         logger.info("   - paramMap : " + paramMap);
	         
	         String loginId = (String)session.getAttribute("loginId");
	         paramMap.put("loginId", loginId);
	         
	         List<TestManageModel> testAllList = testmanagementservice.testAllList(paramMap);
	         
	         Map<String, Object> resultmap = new HashMap<String, Object>();
	         
	         int totalcnt = testmanagementservice.totaltest(paramMap);
	         
	         resultmap.put("testAllList", testAllList);
	         resultmap.put("totalcnt", String.valueOf(totalcnt));
	         resultmap.put("loginId", (String) session.getAttribute("loginId"));
	         
	         
	         System.out.println("------------------------------------testAllList-----------------------------"+testAllList);
	         
	         System.out.println("------------------------------------totalcnt---------------------------------"+totalcnt);
	         
	         logger.info("+ End " + className + ".testAllList");
	   
	         return resultmap;
	         
	   }
	   
	 
	   
	   //문제은행리스트 화면연결
	   @RequestMapping("testBankList.do")
	   public String testBankList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	         
	         logger.info("+ Start " + className + ".testAllList");
	         logger.info("   - paramMap : " + paramMap);

	         logger.info("+ End " + className + ".testAllList");
	   
	         return  "mngwin/TestBank";
	         
	   }
	   
	   // Vue.js - 문제은행리스트 화면연결
	   @RequestMapping("testBankListvue.do")
	   public String testBankListvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception {
		   
		   logger.info("+ Start " + className + ".testAllList");
		   logger.info("   - paramMap : " + paramMap);
		   
		   logger.info("+ End " + className + ".testAllList");
		   
		   return  "mngwin/TestBankVue";
		   
	   }
	   
	   //문제은행리스트 출력
	   @ResponseBody
	   @RequestMapping("testBankALLList.do")
	   public Map<String, Object> testBankALLList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	         
	         logger.info("+ Start " + className + ".testAllList");
	         logger.info("   - paramMap : " + paramMap);
	         
	         List<TestManageModel> testBankList = testmanagementservice.testBankList(paramMap);
	         
	         Map<String, Object> resultmap = new HashMap<String, Object>();

	         
	         resultmap.put("testBankList", testBankList);
	         resultmap.put("loginId", (String) session.getAttribute("loginId"));
	         
	         
	         System.out.println("------------------------------------testAllList-----------------------------"+testBankList);

	         
	         logger.info("+ End " + className + ".testAllList");
	   
	         return resultmap;
	         
	   }
	   
	   /* 수정 하기 전 단건조회 */
	   @ResponseBody
	   @RequestMapping("selectview.do")
	   public Map<String, Object> selectview(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	         
	         logger.info("+ Start " + className + ".selectview");
	         logger.info("   - paramMap : " + paramMap);
	         
	         List<TestManageModel> selectview = testmanagementservice.selectview(paramMap);
	         
	         Map<String, Object> resultmap = new HashMap<String, Object>();

	         
	         resultmap.put("selectview", selectview);
	         
	         
	         System.out.println("------------------------------------selectview-----------------------------"+selectview);

	         
	         logger.info("+ End " + className + ".selectview");
	   
	         return resultmap;
	         
	   } 
	   
	   
	   /* 저장하기+ 수정하기 */
	   @ResponseBody
	   @RequestMapping("testsave.do")
	   public int testsave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	         
	         logger.info("+ Start " + className + ".testsave");
	         logger.info("   - paramMap : " + paramMap);
	         
	         String action =(String)paramMap.get("action");
	         
	         int testsave=0;
	         
	         if("I".equals(action)) {
	        	 
		          testsave = testmanagementservice.testsave(paramMap);
		         
	         }else if("U".equals(action)) {
	        	
	        	  testsave = testmanagementservice.testupdate(paramMap);

	         }else if("D".equals(action)) {
	        	 
	        	 testsave =	testmanagementservice.testdelete(paramMap);
	         }
	         
	        	
	        System.out.println("------------------------------------testsave-----------------------------"+testsave);

	         
	        logger.info("+ End " + className + ".testsave");
	   
	        return testsave;
	         
	   } 
	   
	   
	   // 시험지만들기위한 작업 + 걍 값 가져오는지 확인하려고 만든 로직......js에서 얘 사용안했음 ㅋㅋ
	   @ResponseBody
	   @RequestMapping(value = "/madepaper", method = RequestMethod.POST)
	   public Map<String, Object> madepaper(HttpSession session, @RequestParam(value="paperList[]")List<String> paperList, Model model)throws Exception{
		   logger.info("   - paramMap : " + paperList);
		   logger.info("+ End " + className + ".madepaper");
		  

		   Map<String, Object> parameterMap = new HashMap<>();
		   List<Integer> testQueCdList = new ArrayList<>();
		   
		   Map<String, Object>resultMap = new HashMap<String,Object>();
		   
		   // 방법 1 select 로 가져와보기 
		   //parameterMap.put("test_que_cd", paperList);
		   
		   //List<TestManageModel> papermade = testmanagementservice.papermade(parameterMap);

		   //방법 2  
		   for(String value: paperList ) { 
			   
			
				   int number =Integer.parseInt(value);
				   
				   testQueCdList.add(number);
				   
				   parameterMap.put("test_que_cd", testQueCdList);
				   
				   List<TestManageModel> papermade = testmanagementservice.papermade(parameterMap);
				   
				   //int testRegiMunJae = testmanagementservice.testRegiMunJae(number);
				   
				   System.out.println("===========================papermade::::"+papermade);
				   
				   resultMap.put("papermade", papermade);

		   }
		   

		   return resultMap;
	   }
	   

	   
	   
	   
	   /* 시험지 저장하기 */
	   @ResponseBody
	   @RequestMapping("testregi.do")
	   public int testregi(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	         
	         logger.info("+ Start " + className + ".testregi");
	         logger.info("   - paramMap : " + paramMap);

	         lec_cd = Integer.parseInt((String) paramMap.get("lec_cd")); 
	         
	         test_cd= (String) paramMap.get("test_cd");
	         
	         
	         int testregi=0;

	         testregi = testmanagementservice.testregi(paramMap);

	         System.out.println("------------------------------------testsave-----------------------------"+testregi);

	         
	         logger.info("+ End " + className + ".testregi");
	   
	         return testregi;
	         
	   } 
	   
	   
	   
	   // 시험지만들기위한 작업 
	   @ResponseBody
	   @RequestMapping(value = "/insertTestCdPaper", method = RequestMethod.POST)
	   public int insertTestCdPaper(HttpSession session, @RequestParam(value="paperList[]")List<String> paperList, Model model)throws Exception{
		   logger.info("   - paramMap : " + paperList);

		   logger.info("+ End " + className + ".insertTestCdPaper");
		  

		   Map<String, Object> parameterMap = new HashMap<>();

		   int insertTestCdPaper=0;
		   
		   //방법 2  
		   for(String value: paperList ) { 
			
			   
				   int number =Integer.parseInt(value);

				   parameterMap.put("score", 20);
				   parameterMap.put("test_que_cd", number);
				   parameterMap.put("lec_cd", lec_cd);
				   parameterMap.put("test_cd", test_cd);
				  

				   insertTestCdPaper = testmanagementservice.insertTestCdPaper(parameterMap);
				   
				   logger.info("+ End " + className + ".이거insertTestCdPaper" +insertTestCdPaper);
		   }
		   

		   
		   return insertTestCdPaper;
	   }
	   
	   
	 //클릭한 시험지의 상세정보보기:::::
	   @ResponseBody
	   @RequestMapping("detailview.do")
	   public Map<String, Object> detailview(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
	         HttpServletResponse response, HttpSession session) throws Exception {
	         
	         logger.info("+ Start " + className + ".detailview");
	         logger.info("   - paramMap : " + paramMap);
	         
	         paramMap.put("lec_cd", lec_cd);
	         
	         List<TestManageModel> detailview = testmanagementservice.detailview(paramMap);
	         
	         Map<String, Object> resultmap = new HashMap<String, Object>();
	         
	         resultmap.put("detailview", detailview);

	         System.out.println("------------------------------------detailview-----------------------------"+detailview);
	         
	         logger.info("+ End " + className + ".selectview");
	   
	         return resultmap;
	         
	   } 
	   
	   // 시험 차수 검색
	   @ResponseBody
	   @RequestMapping("checkTestId.do")
	   public Map<String, Object> checkTestId(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			   HttpServletResponse response, HttpSession session) throws Exception {

	         logger.info("+ Start " + className + ".checkTestId");
	         logger.info("   - paramMap : " + paramMap);
	         
	         String checkTestIdYn = "N";
	         String checkTestId = testmanagementservice.checkTestId(paramMap);
	         
	         logger.info("checkTestId ::: " + checkTestId);
	         
	         if(checkTestId == "" || checkTestId == null) {
	        	 logger.info("checkTestId ::: 값이 없습니다, checkTestId ::: " + checkTestId);
	        	 checkTestIdYn = "Y";
	         }
	         
	         Map<String, Object> resultmap = new HashMap<String, Object>();
	         
	         resultmap.put("checkTestIdYn", checkTestIdYn);
	         
	         
	         System.out.println("------------------------------------checkTestIdYn-----------------------------"+checkTestIdYn);

	         
	         logger.info("+ End " + className + ".checkTestId");
	   
	         return resultmap;
	         
	   }
	   
}
