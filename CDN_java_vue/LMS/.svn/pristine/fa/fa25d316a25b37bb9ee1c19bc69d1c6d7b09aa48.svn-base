package kr.happyjob.study.mngins.controller;

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
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.mngins.model.LectureStudentModel;
import kr.happyjob.study.mngins.service.LectureStudentService;
import kr.happyjob.study.sptstd.model.LectureListModel;



@Controller
@RequestMapping("/tut/")
public class LectureStudentController {
   
   @Autowired
   LectureStudentService  lecturestudentservice;


   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   /**
    *화면연결
    */

   @RequestMapping("lectureStudentInfo.do")
   public String LectureStudent(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      
         logger.info("+ Start " + className + ".LectureStudent");
         logger.info("   - paramMap : " + paramMap);
         
         logger.info("+ End " + className + ".LectureStudent");
   
         return  "mngins/LectureStudent";
   }
    
   // Vue.js - 수강생 정보 화면 연결
   @RequestMapping("lectureStudentInfovue.do")
   public String LectureStudentvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		   HttpServletResponse response, HttpSession session) throws Exception {
	   
	   
	   logger.info("+ Start " + className + ".LectureStudent");
	   logger.info("   - paramMap : " + paramMap);
	   
	   logger.info("+ End " + className + ".LectureStudent");
	   
	   return  "mngins/LectureStudentVue";
   }
   

   /**
    * 강의목록 관리 초기화면 
    */

   @RequestMapping("LectureStudentAllList.do")
   public String LectureStudentAllList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
         
         logger.info("+ Start " + className + ".lectureListAll");
         logger.info("   - paramMap : " + paramMap);
         
        int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
         int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));   
         int startpoint = ( currentPage - 1 ) * pageSize;
         
         paramMap.put("pageSize", pageSize);
         paramMap.put("startpoint", startpoint);
         
         List<LectureStudentModel> LectureStudentAllList = lecturestudentservice.liststudentLecture(paramMap);
         
         for(int i = 0; i < LectureStudentAllList.size(); i++){
            System.out.println("LectureStudentAllList::::" + LectureStudentAllList.get(i).getLec_nm());
         }
         
         int totalcnt = lecturestudentservice.totalsutdentLecture(paramMap);
         
         model.addAttribute("LectureStudentAllList", LectureStudentAllList);
         model.addAttribute("totalcnt", totalcnt);
         
         model.addAttribute("loginId",(String) session.getAttribute("loginId"));
         
         
         System.out.println("------------------------------------LectureStudentAllList-----------------------------"+LectureStudentAllList);
         
         System.out.println("------------------------------------totalcnt---------------------------------"+totalcnt);
         
         logger.info("+ End " + className + ".LectureStudentAllList");
   
         return "mngins/LectureStudentAllList";
   }
   
   // Vue.js - 초기화면
   @RequestMapping("LectureStudentAllListvue.do")
   @ResponseBody
   public  Map<String, Object> LectureStudentAllListvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
		   HttpServletResponse response, HttpSession session) throws Exception {
	   
	   logger.info("+ Start " + className + ".lectureListAll");
	   logger.info("   - paramMap : " + paramMap);
	   
	   int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
	   int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));   
	   int startpoint = ( currentPage - 1 ) * pageSize;
	   
	   paramMap.put("loginId",(String) session.getAttribute("loginId"));
	   paramMap.put("pageSize", pageSize);
	   paramMap.put("startpoint", startpoint);
	   
	   List<LectureStudentModel> LectureStudentAllList = lecturestudentservice.liststudentLecture(paramMap);
	   
	   for(int i = 0; i < LectureStudentAllList.size(); i++){
		   System.out.println("LectureStudentAllList::::" + LectureStudentAllList.get(i).getLec_nm());
	   }
	   
	   int totalcnt = lecturestudentservice.totalsutdentLecture(paramMap);
	   
	   Map<String, Object> resultMap = new HashMap<String, Object>();
	   
	   resultMap.put("LectureStudentAllList", LectureStudentAllList);
	   resultMap.put("totalcnt", totalcnt);
	   
	   System.out.println("------------------------------------LectureStudentAllList-----------------------------"+LectureStudentAllList);
	   
	   System.out.println("------------------------------------totalcnt---------------------------------"+totalcnt);
	   
	   logger.info("+ End " + className + ".LectureStudentAllList");
	   
	   return resultMap;
   }
   
   /** SELEC 박스 */
   @ResponseBody
   @RequestMapping("leclist.do")
   public Map<String, Object>leclist (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
           logger.info("+ Start " + className + ".leclist");

         paramMap.put("loginId", (String) session.getAttribute("loginId"));
           
         List<LectureStudentModel> leclist = lecturestudentservice.leclist(paramMap);

         Map<String, Object>resultMap = new HashMap<String, Object>();
         
         resultMap.put("leclist", leclist);
         
         System.out.println("==========leclist==============="+leclist);
         logger.info("+ End " + className + ".leclist");

       
      return resultMap;
   
   }
   
   /** 수강중인 학생 목록 */
   @ResponseBody
   @RequestMapping("studentlist.do")
   public Map<String, Object>studentlist (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
           logger.info("+ Start " + className + ".studentlist");
           logger.info("   - paramMap : " + paramMap);

         paramMap.put("loginId", (String) session.getAttribute("loginId"));
  
         List<LectureStudentModel> studentlist = lecturestudentservice.studentlist(paramMap);

         Map<String, Object>resultMap = new HashMap<String, Object>();
         
         resultMap.put("studentlist", studentlist);
         
         System.out.println("==========studentlist==============="+studentlist);
         logger.info("+ End " + className + ".LectureSelect");

       
      return resultMap;
   
   }
   
   
   /** 강의수락하기 */
   @ResponseBody
   @RequestMapping("studentYes.do")
   public int studentYes(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
	  
	   logger.info("+ Start " + className + ".studentYes");
       logger.info("   - paramMap : " + paramMap);
	   
	   
	  //paramMap.put("loginId", (String) session.getAttribute("loginId"));
	  
      int studentYes = lecturestudentservice.studentYes(paramMap);

      logger.info("+ End " + className + ".studentYes");
      
      return studentYes;
   }
   
   
   /** 강의거절하기 */
   @ResponseBody
   @RequestMapping("studentNO.do")
   public int studentNO(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
	  
	  paramMap.put("loginId", (String) session.getAttribute("loginId"));
	  
      int studentNO = lecturestudentservice.studentNO(paramMap);

      
      return studentNO;
   }
   
   
   /** 수강인원체크하기 */
   @ResponseBody
   @RequestMapping("memberCheck.do")
   public int memberCheck(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
      
     paramMap.put("loginId", (String) session.getAttribute("loginId"));
     
     List<LectureStudentModel> memberCheck = lecturestudentservice.memberCheck(paramMap);

            for(int i = 0; i < memberCheck.size(); i++){
               
                System.out.println("memberCheck::::" + memberCheck.get(i).getApp_cnt());
                System.out.println("memberCheck::::" + memberCheck.get(i).getCapacity());
                
                   if( memberCheck.get(i).getApp_cnt() < memberCheck.get(i).getCapacity() ){
                      
                      return 1;
                      
                   }else{
                      
                       return 0;
                   }
                
             }//for e
            
            return 0;
   }
   
   
}