package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cus.model.QnaModel;
import kr.happyjob.study.scm.dao.AnswerDao;
import kr.happyjob.study.scm.model.AnswerModel;


@Service
public class AnswerServiceImpl implements AnswerService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	AnswerDao answerDao;
	
	
	/** 모든 고객 Qna 목록 조회 */
	public List<AnswerModel> answerList(Map<String, Object> paramMap) throws Exception {
		
		return answerDao.answerList(paramMap);
	}
	
	/** 모든 고객 Qna 카운트 조회 */
	public int answerTotalCnt(Map<String, Object> paramMap) throws Exception {
		
		return answerDao.answerTotalCnt(paramMap);
	}
	
	/** Qna 한건 조회 */
	public AnswerModel answerSelect(Map<String, Object> paramMap) throws Exception  {
		
		answerDao.answerSelect(paramMap);		
		
		return answerDao.answerSelect(paramMap);
	}
	
	/** Qna 답변 등록 */
	public int insertAnswer(Map<String, Object> paramMap) throws Exception {
		
		return answerDao.insertAnswer(paramMap);

	}
	
	/** Qna 답변 수정 */
	public int updateAnswer(Map<String, Object> paramMap) throws Exception {
		
		return answerDao.updateAnswer(paramMap);
	}
	
	/** Qna 답변 삭제 */
	public int deleteAnswer(Map<String, Object> paramMap) throws Exception {
		
		return answerDao.deleteAnswer(paramMap);
	}
	
	/** Qna 답변 상태 수정(답변등록시) */
	public int updateQnaInfo(Map<String, Object> paramMap) throws Exception {
		
		return answerDao.updateQnaInfo(paramMap);
	}
	
	/** Qna 답변 상태 수정(답변삭제시) */
	public int deleteQnaInfo(Map<String, Object> paramMap) throws Exception {
		
		return answerDao.deleteQnaInfo(paramMap);
	}

}
