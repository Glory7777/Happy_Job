package kr.happyjob.study.mngins.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.mngins.model.GradesMngModel;
import kr.happyjob.study.mngins.model.StuModel;


public interface GradesMngDao {

	// 성적 강의 목록
	public List<GradesMngModel> gradesList(Map<String, Object> paramMap) throws Exception;

	
	// 목록 총 개수
	public int totalcnt(Map<String, Object> paramMap) throws Exception;

	// 학생 성적 목록
	public List<StuModel> stuList(Map<String, Object> paramMap) throws Exception;

	// 학생 성적 목록 총 개수
	public int stuTotalcnt(Map<String, Object> paramMap) throws Exception;
	
}
