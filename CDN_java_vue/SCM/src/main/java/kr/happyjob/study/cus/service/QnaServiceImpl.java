package kr.happyjob.study.cus.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.cus.dao.QnaDao;
import kr.happyjob.study.cus.model.QnaModel;


@Service
public class QnaServiceImpl implements QnaService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	QnaDao qnaDao;
	
	
	/** Qna 목록 조회 */
	public List<QnaModel> qnaList(Map<String, Object> paramMap) throws Exception {
		
		return qnaDao.qnaList(paramMap);
	}
	
	/** Qna 카운트 조회 */
	public int qnaTotalCnt(Map<String, Object> paramMap) throws Exception {
		
		return qnaDao.qnaTotalCnt(paramMap);
	}
	
	/** Qna 한건 조회 */
	public QnaModel qnaSelect(Map<String, Object> paramMap) throws Exception  {
		
		qnaDao.qnaSelect(paramMap);		
		
		return qnaDao.qnaSelect(paramMap);
	}
	
	/** Qna 등록 */
	public int insertQna(Map<String, Object> paramMap) throws Exception {
		
		return qnaDao.insertQna(paramMap);
	}
	
	/** Qna 수정 */
	public int updateQna(Map<String, Object> paramMap) throws Exception {
		
		return qnaDao.updateQna(paramMap);
	}
	
	/** Qna 삭제 */
	public int deleteQna(Map<String, Object> paramMap) throws Exception {
		
		return qnaDao.deleteQna(paramMap);
	}
		
	/** Qna 삭제 시 해당 answer 값도 삭제 */
	public int delAnswer(Map<String, Object> paramMap) throws Exception {
		
		return qnaDao.delAnswer(paramMap);
	}	

}
