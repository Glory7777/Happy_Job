package kr.happyjob.study.sptstd.service;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.sptstd.model.LectureListModel;

@Service
public interface LectureListService {

   /** 강의 목록 조회 */
   public List<LectureListModel> listLecture(Map<String, Object> paramMap) throws Exception;
   
   /** 강의 건수 조회 */
   public int totaLecture(Map<String, Object> paramMap) throws Exception;

   /**강의목록상세  */
   public LectureListModel  LectureSelect(Map<String, Object> paramMap)throws Exception;
   
   /** 강의주차상세 조회 */
   public List<LectureListModel> LecturePlan(Map<String, Object> paramMap) throws Exception;
   
   /** 시작일자와 종료일자만 구해오기 */ 
   public LectureListModel checkdaty(int lec_cd) throws Exception;
   
   /* 강의신청하기 유효성검사  */
   public int  PossibleSave(Map<String, Object> paramMap)throws Exception;
      
   /* 강의신청하기  */
   public int InsetLec(Map<String, Object> paramMap) throws Exception;

   
   /* 강의 취소하기1  */
   public int deleteLec(Map<String, Object> paramMap) throws Exception;   
   
   
   /* 강의 취소하기2  */
   public int deleteme(Map<String, Object> paramMap) throws Exception;  
   
   /*강의신청여부조회  */
   public int lec_yn(Map<String, Object> paramMap) throws Exception; 
   
   
   /*강의수락여부조회  */
   public String app_yn(Map<String, Object> paramMap) throws Exception;  
   
   
   /*강의 신청취소유효성  */
   public int DeletePossible(Map<String, Object> paramMap) throws Exception;

   
}