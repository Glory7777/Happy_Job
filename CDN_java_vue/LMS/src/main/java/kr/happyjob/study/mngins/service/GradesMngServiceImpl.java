package kr.happyjob.study.mngins.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.FileUtil;
import kr.happyjob.study.common.comnUtils.FileUtilModel;
import kr.happyjob.study.mngins.dao.GradesMngDao;
import kr.happyjob.study.mngins.model.GradesMngModel;
import kr.happyjob.study.mngins.model.StuModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;

@Service
public class GradesMngServiceImpl implements GradesMngService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	GradesMngDao gradesDao;

	// 성적 강의 목록
	@Override
	public List<GradesMngModel> gradesList(Map<String, Object> paramMap) throws Exception {
		return gradesDao.gradesList(paramMap);
	}

	
	// 목록 총 개수
	@Override
	public int totalcnt(Map<String, Object> paramMap) throws Exception {
		return gradesDao.totalcnt(paramMap);
	}

	// 학생 성적 목록
	@Override
	public List<StuModel> stuList(Map<String, Object> paramMap) throws Exception {
		return gradesDao.stuList(paramMap);
	}

	// 학생 목록 총 개수
	@Override
	public int stuTotalcnt(Map<String, Object> paramMap) throws Exception {
		return gradesDao.stuTotalcnt(paramMap);
	}

}
