package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.scm.model.AnswerModel;

public interface AnswerService {
	
	/** 모든 고객 Qna 목록 조회 */
	public List<AnswerModel> answerList(Map<String, Object> paramMap) throws Exception;
	
	/** 모든 고객 Qna 카운트 조회 */
	public int answerTotalCnt (Map<String, Object> paramMap) throws Exception;
	
	/** Qna 한건 조회 */
	public AnswerModel answerSelect(Map<String, Object> paramMap) throws Exception;

	/** Qna 답변 등록 */
	public int insertAnswer(Map<String, Object> paramMap) throws Exception;
	
	/** Qna 답변 수정 */
	public int updateAnswer(Map<String, Object> paramMap) throws Exception;
	
	/** Qna 답변 삭제 */
	public int deleteAnswer(Map<String, Object> paramMap) throws Exception;
	
	/** Qna 답변 상태 수정(답변등록시) */
	public int updateQnaInfo(Map<String, Object> paramMap) throws Exception;
	
	/** Qna 답변 상태 수정(답변삭제시) */
	public int deleteQnaInfo(Map<String, Object> paramMap) throws Exception;
}
