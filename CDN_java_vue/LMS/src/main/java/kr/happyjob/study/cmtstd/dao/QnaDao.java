package kr.happyjob.study.cmtstd.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import kr.happyjob.study.cmtstd.model.QnaModel;

public interface QnaDao {
   
   public List<QnaModel> qnaList(  Map<String, Object> paramMap) throws Exception;
   
   public int totalqna(Map<String, Object> paramMap)throws Exception;
   
   
   public QnaModel qnaselect(Map<String, Object> paramMap)throws Exception;
   
   /** qna 조회수 count up */
   public int qnacntup(Map<String, Object> paramMap) throws Exception;   
   
   
   public int  insertqna(Map<String, Object> paramMap)throws Exception;


   public int  updateqna(Map<String, Object> paramMap)throws Exception;
   
   public int commentqna(Map<String, Object> paramMap) throws Exception;
   
   public int ans_yn(Map<String, Object> paramMap) throws Exception;
   
   public int updatecomment(Map<String, Object> paramMap) throws Exception;
   
   public int  deletenotice(Map<String, Object> paramMap)throws Exception;
   
   
   
}