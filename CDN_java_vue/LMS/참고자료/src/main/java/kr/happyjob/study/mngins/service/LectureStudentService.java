package kr.happyjob.study.mngins.service;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mngins.model.LectureStudentModel;



public interface LectureStudentService {

   /** select 강의리스트박스 */
   public List<LectureStudentModel> leclist(Map<String, Object> paramMap) throws Exception;
   
   
   /** 강의 목록 조회 */
   public List<LectureStudentModel> liststudentLecture(Map<String, Object> paramMap) throws Exception;
   
   
   /** 강의 건수 조회 */
   public int totalsutdentLecture(Map<String, Object> paramMap) throws Exception;


   /** 수강중인 학생 목록 */
   public List<LectureStudentModel>studentlist( Map<String, Object> paramMap) throws Exception;
   

   
   /** 강의수락하기 */
   public int studentYes(Map<String, Object> paramMap)throws Exception;
   
   
   /** 강의거절하기 */
   public int studentNO(Map<String, Object> paramMap)throws Exception;
   
   
   /** 수강인원체크하기 */
   public  List<LectureStudentModel> memberCheck(Map<String, Object> paramMap)throws Exception;
   
}