package kr.happyjob.study.sptins.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mysql.fabric.xmlrpc.base.Array;

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.sptins.dao.LearningMaterialDao;
import kr.happyjob.study.sptins.model.FileInfoModel;
import kr.happyjob.study.sptins.model.LearningMaterialModel;


@Service
public class LearningMaterialServiceImpl implements LearningMaterialService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LearningMaterialDao lmDao;
	
	// 파일 업로드를 위한 경로 설정
	// 물리경로
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	// 상대경로
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	// 이하경로
	@Value("${fileUpload.lecFilePath}")
	private String lecFilePath;
	
	

	/* 주차 목록 조회
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LearningMaterialService#lmFindWeeklyList(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public List<LearningMaterialModel> lmFindWeeklyList(Map<String, Object> paramMap) throws Exception {
		
		int lec_cd = lmDao.findLecCd(paramMap);
		paramMap.put("lec_cd", lec_cd);
		
		return lmDao.lmFindWeeklyList(paramMap);
	}

	
	/* 파일 정보 불러오기
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LearningMaterialService#findFileInfo(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public FileInfoModel findFileInfo(Map<String, Object> paramMap) throws Exception {
		
		// 해당 주차에 파일이 있는지 불러오기
		// 없으면 0 반환
		int lec_file_no = lmDao.findLecFileNo(paramMap);
		paramMap.put("lec_file_no", lec_file_no);
		
		FileInfoModel fileInfo = new FileInfoModel();
		
		if(lec_file_no != 0) {
			fileInfo = lmDao.findFileInfo(paramMap);
		}
		
		return fileInfo;
	}


	/* 신규 저장
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LearningMaterialService#insertFile(java.util.Map, javax.servlet.http.HttpServletRequest)
	 * @author 김정욱
	 */
	@Override
	public String insertFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		int result = 0;
		String msg = null;
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		String itemFilePath = lecFilePath + File.separator;
		// File.separator : 자바 기능. OS에 따라 구분자 선택
		
		logger.info("   - rootPath : " + rootPath);
		logger.info("   - itemFilePath : " + itemFilePath);
		logger.info("   - virtualRootPath : " + virtualRootPath);
		
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileinfo = fileUtil.uploadFiles();
		
		logger.info("   - file_nm : " + fileinfo.get("file_nm"));
		logger.info("   - file_size : " + fileinfo.get("file_size"));
		logger.info("   - file_loc : " + fileinfo.get("file_loc"));
		logger.info("   - vrfile_loc : " + fileinfo.get("vrfile_loc"));
		logger.info("   - fileExtension : " + fileinfo.get("fileExtension"));
		
		paramMap.put("fileinfo", fileinfo);
		
		if(result != 0) msg = "저장 성공";
		else msg = "저장 실패";
		
		return msg;
	}


	/* 파일 갱신
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LearningMaterialService#updateFile(java.util.Map, javax.servlet.http.HttpServletRequest)
	 * @author 김정욱
	 */
	@Override
	public String updateFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	/* 파일 삭제
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LearningMaterialService#deleteFile(java.util.Map, javax.servlet.http.HttpServletRequest)
	 * @author 김정욱
	 */
	@Override
	public String deleteFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


}
