package kr.happyjob.study.sptstd.controller;

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

import kr.happyjob.study.cmtstd.model.QnaModel;
import kr.happyjob.study.cmtstd.service.QnaService;
import kr.happyjob.study.sptstd.model.LectureListModel;
import kr.happyjob.study.sptstd.service.LectureListService;


@Controller
@RequestMapping("/std/")
public class LectureListController {
   
   @Autowired
   LectureListService lectureListService;


   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   /**
    *화면연결
    */
   @RequestMapping("lectureList.do")
   public String lectureList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      
         logger.info("+ Start " + className + ".lectureList");
         logger.info("   - paramMap : " + paramMap);
         
         logger.info("+ End " + className + ".lectureList");
   
         return  "sptstd/LectureList";
   }
    
   
   
   /**
    * 강의목록 관리 초기화면
    */
   @RequestMapping("lectureListAll.do")
   public String lectureListAll(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
         
         logger.info("+ Start " + className + ".lectureListAll");
         logger.info("   - paramMap : " + paramMap);
         
         int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
         int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));   
         int startpoint = ( currentPage - 1 ) * pageSize;
         
         paramMap.put("pageSize", pageSize);
         paramMap.put("startpoint", startpoint);
         
         List<LectureListModel> listLecture = lectureListService.listLecture(paramMap);
         
         int totalcnt = lectureListService.totaLecture(paramMap);
         
         model.addAttribute("listLecture",listLecture);
         model.addAttribute("totalcnt",totalcnt);
         
         model.addAttribute("loginId",(String) session.getAttribute("loginId"));
         
         
         System.out.println("------------------------------------listLecture-----------------------------"+listLecture);
         
         System.out.println("------------------------------------totalcnt---------------------------------"+totalcnt);
         
         logger.info("+ End " + className + ".lectureListAll");
   
         return  "sptstd/LectureAllList";
   }
    /*
   //강의목록상세 
   @ResponseBody
   @RequestMapping("LectureSelect.do")
   public Map<String, Object>LectureSelect (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
           logger.info("+ Start " + className + ".LectureSelect");
           logger.info("   - paramMap : " + paramMap);
      

         LectureListModel lecturemodel = lectureListService.LectureSelect(paramMap); 
         
         System.out.println("lecturemodel:::::"+lecturemodel);
         
         Map<String, Object>resultMap = new HashMap<String, Object>();
         
         resultMap.put("lecturemodel", lecturemodel);
         
         resultMap.put("loginId", (String) session.getAttribute("loginId"));
         
         System.out.println(lecturemodel);
         
         logger.info("+ End " + className + ".LectureSelect");

       
      return resultMap;
   
   }
   */
   //강의목록상세 
   @ResponseBody
   @RequestMapping("LectureSelect.do")
   public Map<String, Object>LectureSelect (Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
           logger.info("+ Start " + className + ".LectureSelect");
           logger.info("   - paramMap : " + paramMap);
      

         LectureListModel lecturemodel = lectureListService.LectureSelect(paramMap); 
         
         List<LectureListModel> LecturePlan = lectureListService.LecturePlan(paramMap);
         
         System.out.println("lecturemodel:::::"+lecturemodel);
         
         Map<String, Object>resultMap = new HashMap<String, Object>();
         
         resultMap.put("lecturemodel", lecturemodel);
         resultMap.put("LecturePlan", LecturePlan);
         resultMap.put("loginId", (String) session.getAttribute("loginId"));
         
         System.out.println("==========lecturemodel==============="+lecturemodel);
         System.out.println("==========lecturemodel==============="+LecturePlan);
         logger.info("+ End " + className + ".LectureSelect");

       
      return resultMap;
   
   }
   
    /* 강의 시작일과 종료일 뽑아내기  */
   @RequestMapping("checkdaty.do")
   @ResponseBody
   public LectureListModel checkdaty(int lec_cd, HttpServletRequest request, HttpServletResponse response, HttpSession session)throws Exception{
      
         LectureListModel lm = lectureListService.checkdaty( lec_cd);
         
         return lm;
   }
   

   
   /* 강의신청하기 유효성검사  */
   @RequestMapping("PossibleSave.do")
   @ResponseBody
   public int PossibleSave(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
      
         int PossibleSave =lectureListService.PossibleSave(paramMap);
         
         return PossibleSave;
   }   
   
   
   
   /* 강의신청하기  */
   @RequestMapping("InsetLec.do")
   @ResponseBody
   public int InsetLec(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
      
         int InsetLec =lectureListService.InsetLec(paramMap);
         
         return InsetLec;
   }
   
   
   
   
    /*강의 취소하기 */
   @RequestMapping("deleteLec.do")
   @ResponseBody
   public int deleteLec(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
      
         int deleteLec =lectureListService.deleteLec(paramMap);
         
         return deleteLec;
   }
   
   
   /*강의신청여부조회  */
   @RequestMapping("lec_yn.do")
   @ResponseBody
   public int lec_yn(@RequestParam Map<String, Object> paramMap, HttpServletRequest request,HttpServletResponse response, HttpSession session) throws Exception {
      
         int lec_yn =lectureListService.lec_yn(paramMap);
         
         return lec_yn;
   }
   
   
}