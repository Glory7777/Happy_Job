package kr.happyjob.study.sptadm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import kr.happyjob.study.sptadm.model.NtModel;

public interface NtDao {

	
	// 공지사항 리스트 조회
	public List<NtModel> listNotice(Map<String, Object> paramMap)throws Exception ; // 이걸 xml로 던져버리기
	
	// 공지사항 목록 카운트 조회
	public int totalCnt(Map<String, Object> paramMap)throws Exception ;
	
	/** 공지사항 한건 조회 */
	public NtModel selectNotice(Map<String, Object> paramMap) throws Exception;	
	
	/** 공지사항 조회수 count up */
	public int noticeReadCntUp(Map<String, Object> paramMap) throws Exception;	
	
	/** 공지사항 등록 */
	public int insertNotice(Map<String, Object> paramMap) throws Exception;
	
	public int insertNoticefile(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 수정 */
	public int updateNotice(Map<String, Object> paramMap) throws Exception;
	
	public int updateNoticefile(Map<String, Object> paramMap) throws Exception;
	
	/** 공지사항 삭제 */
	public int deleteNotice(Map<String, Object> paramMap) throws Exception;
	
	
	
	
	}
