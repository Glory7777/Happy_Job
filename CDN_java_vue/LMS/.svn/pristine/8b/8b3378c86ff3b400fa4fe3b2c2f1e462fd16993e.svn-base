package kr.happyjob.study.mngins.service;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mngins.dao.LectureStudentDao;
import kr.happyjob.study.mngins.model.LectureStudentModel;
import kr.happyjob.study.system.dao.ComnCodDao;
import kr.happyjob.study.system.model.ComnGrpCodModel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

@Service
public class LectureStudentServiceImpl implements LectureStudentService {
   
   @Autowired
   LectureStudentDao lecturestudentdao;


   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();

   
   /** select 강의리스트박스 */
   @Override
   public List<LectureStudentModel> leclist(Map<String, Object> paramMap) throws Exception{
      
      return lecturestudentdao.leclist(paramMap);
   }
   
   /** 강의 목록 조회 */
   @Override
   public List<LectureStudentModel> liststudentLecture(Map<String, Object> paramMap) throws Exception{
      
      return lecturestudentdao.liststudentLecture(paramMap);
   } 
   
   
   /** 강의 건수 조회 */
   @Override
   public int totalsutdentLecture(Map<String, Object> paramMap) throws Exception{
      
      return lecturestudentdao.totalsutdentLecture(paramMap);
   }

   
   
   /** 수강중인 학생 목록 */
   public List<LectureStudentModel>studentlist( Map<String, Object> paramMap) throws Exception{
      
      return lecturestudentdao.studentlist(paramMap);
   }
   
   
   /** 강의수락하기 */
   public int studentYes(Map<String, Object> paramMap)throws Exception{
      
      lecturestudentdao.updatecnt(paramMap);
      
      return lecturestudentdao.studentYes(paramMap);
      
   }
   
   
   /** 강의거절하기 */
   public int studentNO(Map<String, Object> paramMap)throws Exception{
      
      lecturestudentdao.downcnt(paramMap);
      
      return lecturestudentdao.studentNO(paramMap);
      
   }
   
   /** 수강인원체크하기 */
   public  List<LectureStudentModel> memberCheck(Map<String, Object> paramMap)throws Exception{
      
      return lecturestudentdao.memberCheck(paramMap);

   }
   
}