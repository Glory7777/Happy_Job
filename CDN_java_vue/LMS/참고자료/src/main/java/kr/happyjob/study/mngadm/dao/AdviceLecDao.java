package kr.happyjob.study.mngadm.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngadm.model.AdvStuListModel;
import kr.happyjob.study.mngadm.model.AdviceLecModel;



public interface AdviceLecDao {
		
		// 상담 목록
		public List<AdviceLecModel> lectureAdviceList(Map<String, Object> paramMap) throws Exception;
		
		
		// 목록 총 개수
		public int totalcnt(Map<String, Object> paramMap) throws Exception;

		// 학생 상담 목록
		public List<AdvStuListModel> advStuList(Map<String, Object> paramMap) throws Exception;

		// 학생 상담 목록 총 개수
		public int advTotalcnt(Map<String, Object> paramMap) throws Exception;

/*
		// 강의 내용 조회
		public AdviceModel selectAdv(Map<String, Object> paramMap) throws Exception;

		
		// 상담 등록
		public int insertAdv(Map<String, Object> paramMap) throws Exception;

		// 상담 갱신
		public int updateAdv(Map<String, Object> paramMap) throws Exception;

		// 상담 삭제
		public int deleteAdv(Map<String, Object> paramMap) throws Exception;
*/
}
