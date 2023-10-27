package kr.happyjob.study.sptstd.service;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.happyjob.study.mngins.dao.LectureStudentDao;
import kr.happyjob.study.sptstd.dao.LectureListDao;
import kr.happyjob.study.sptstd.model.LectureListModel;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

@Service
public class LectureListServiceImpl implements LectureListService {
   
   @Autowired
    LectureListDao lectureListDao;

   @Autowired
   LectureStudentDao lecturestudentDao;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());
   
   // Get class name for logger
   private final String className = this.getClass().toString();

   /** 강의 목록 조회 */
   public List<LectureListModel> listLecture(Map<String, Object> paramMap) throws Exception{
      
      return lectureListDao.listLecture(paramMap);
   }
   
   /** 강의 건수 조회 */
   public int totaLecture(Map<String, Object> paramMap) throws Exception{
      
      return lectureListDao.totaLecture(paramMap);
   }

   /** 강의 상세 조회 */
   public LectureListModel LectureSelect(Map<String, Object> paramMap) throws Exception{
      
      return lectureListDao.LectureSelect(paramMap);
   }
   
   
   /** 강의주차상세 조회 */
   public List<LectureListModel> LecturePlan(Map<String, Object> paramMap) throws Exception{
         
         return lectureListDao.LecturePlan(paramMap);
   }

   /** 시작일자와 종료일자만 구해오기 */
   public LectureListModel checkdaty(int lec_cd) throws Exception{
      
      return lectureListDao.checkdaty(lec_cd);
   }
   
   
   /* 강의신청하기  */
   public int InsetLec(Map<String, Object> paramMap) throws Exception{
	   
      return lectureListDao.InsetLec(paramMap);
            
   }
   
   
   
   /* 강의신청하기  */
   public int PossibleSave(Map<String, Object> paramMap) throws Exception{
      
      return lectureListDao.PossibleSave(paramMap);
            
   }

   
   /* 강의 취소하기  */
   public int deleteLec(Map<String, Object> paramMap) throws Exception{
     
	   lecturestudentDao.downcnt(paramMap);
	   
      return lectureListDao.deleteLec(paramMap);
      
   }
   

   /* 강의 취소하기2  */
   public int deleteme(Map<String, Object> paramMap) throws Exception{
      
      return lectureListDao.deleteLec(paramMap);
      
   }
   
   /*강의신청여부조회  */
   public int lec_yn(Map<String, Object> paramMap) throws Exception{
      
      return lectureListDao.lec_yn(paramMap);
   }

   /*강의수락여부조회  */
   public String app_yn(Map<String, Object> paramMap) throws Exception{
	   
	   return lectureListDao.app_yn(paramMap);
   }

   
   /*강의 신청취소유효성  */
   public int DeletePossible(Map<String, Object> paramMap) throws Exception{
	   
	   return lectureListDao.DeletePossible(paramMap);
   }
   
   

}