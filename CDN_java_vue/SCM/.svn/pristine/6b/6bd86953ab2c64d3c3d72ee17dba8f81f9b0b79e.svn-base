package kr.happyjob.study.scm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.scm.model.NoticeModel;

public interface NoticeDao {

	/** 공지사항 목록 조회 */
	public List<NoticeModel> listnotice(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 카운트 조회 */
	public int totalnotice(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 한건 조회 */
	public NoticeModel noticeselect(Map<String, Object> paramMap) throws Exception;	
	
	/** 공지사항 조회수 count up */
	public int noticereadcntup(Map<String, Object> paramMap) throws Exception;	
	
	/** 공지사항 등록 */
	public int insertnotice(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 수정 */
	public int updatenotice(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 삭제 */
	public int deletenotice(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 등록 */
	public int insertnoticefile(Map<String, Object> paramMap) throws Exception;
	public int insertnoticefileinfo(Map<String, Object> paramMap) throws Exception;
	
	
	
	/** 공지사항 수정 */
	public int updatenoticefile(Map<String, Object> paramMap) throws Exception;
	
	
	public int updatenoticefileinfo(Map<String, Object> paramMap) throws Exception;
	
	
	
	
}
