package kr.happyjob.study.cus.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cus.model.QnaModel;


public interface QnaDao {
	
	/** Qna 목록 조회 */
	public List<QnaModel> qnaList(Map<String, Object> paramMap) throws Exception;
	
	/** Qna 카운트 조회 */
	public int qnaTotalCnt (Map<String, Object> paramMap) throws Exception;
	
	/** Qna 한건 조회 */
	public QnaModel qnaSelect(Map<String, Object> paramMap) throws Exception;
	
	/** Qna 등록 */
	public int insertQna(Map<String, Object> paramMap) throws Exception;
	
	/** Qna 수정 */
	public int updateQna(Map<String, Object> paramMap) throws Exception;
	
	/** Qna 삭제 */
	public int deleteQna(Map<String, Object> paramMap) throws Exception;
	
	/** Qna 삭제 시 해당 answer 값도 삭제 */
	public int delAnswer(Map<String, Object> paramMap) throws Exception;
}
