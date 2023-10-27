package kr.happyjob.study.mngstd.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.util.SystemOutLogger;
import org.springframework.ui.Model;

import kr.happyjob.study.mngstd.model.MylecListModel;
import kr.happyjob.study.sptstd.model.LectureListModel;

public interface MylecListDao {
	
	/** 수강중인강의 목록 조회 */
	public List<MylecListModel>myLecList(Map<String, Object> paramMap) throws Exception;
	
   
}