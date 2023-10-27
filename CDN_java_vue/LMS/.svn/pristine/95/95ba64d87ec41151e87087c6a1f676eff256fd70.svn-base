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
		// 없으면 1 반환
		int lec_file_no = lmDao.findLecFileNo(paramMap);
		paramMap.put("lec_file_no", lec_file_no);
		
		FileInfoModel fileInfo = new FileInfoModel();
		
		// 미구현 구현필요
		if(lec_file_no != 1) {
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
		logger.info("   - file_nm_split : " + fileinfo.get("file_nm_split"));
		
		paramMap.put("fileinfo", fileinfo);
		
		
		// 파일 테이블에 파일 신규 등록
		paramMap.put("lec_file_no", "1");
		result = lmDao.insertFile(paramMap);
		
		// 얻어온 파일 pk를 가지고 강의 계획 해당 주차 업데이트
		result = lmDao.updateLecWeek(paramMap);
		
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
		String msg = "갱신 실패";
		int result = 0;
		
		// 갱신 시 파일 변경 X, 자료내용만 수정
		if(paramMap.get("fileYN").toString().equals("N")){
			
			result = lmDao.lecFileCttUpdate(paramMap);
			
			if(result != 0) msg = "갱신 성공";
	
		// 갱신 시 파일 변경 O
		} else{
			// 1. 파일 삭제를 위한 tb_lec_week 등록번호 기본값(1) 업데이트
			result = lmDao.updateLecWeekFile(paramMap);
			
			// 2. tb_lec_week 등록번호 업데이트 성공시
			if(result != 0) {
				
				// 3. tb_lec_file에서 파일 삭제
				result = lmDao.deleteFile(paramMap);
				
				// 4. 파일 삭제 성공 시
				if(result != 0){
					// 5. 새로운(갱신된) 파일 정보 저장하기
					MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
					String itemFilePath = lecFilePath + File.separator;
					FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualRootPath, itemFilePath);
					Map<String, Object> fileinfo = fileUtil.uploadFiles();
					paramMap.put("fileinfo", fileinfo);
					
					// 파일 테이블에 파일 신규 등록
					paramMap.put("lec_file_no", "1");
					result = lmDao.insertFile(paramMap);
					
					// 얻어온 파일 pk를 가지고 강의 계획 해당 주차 업데이트
					result = lmDao.updateLecWeek(paramMap);
					
					if(result != 0) msg = "갱신 성공";
				}
			} 
		}
		
		return msg;
	}


	/* 파일 삭제
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LearningMaterialService#deleteFile(java.util.Map, javax.servlet.http.HttpServletRequest)
	 * @author 김정욱
	 */
	@Override
	public String deleteFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		String msg = null;
		int result = 0;
		
		result = lmDao.updateLecWeekFile(paramMap);
		
		if(result != 0) {
			result = lmDao.deleteFile(paramMap);

			if(result  != 0) msg = "삭제 성공";
			else msg = "삭제 실패";
		} else {
			msg = "삭제 실패";
		}
		
		return msg;
	}


	/* 파일 다운로드
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LearningMaterialService#lecFiledownload(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public FileInfoModel lecFiledownload(Map<String, Object> paramMap) throws Exception {
		return lmDao.findFileInfo(paramMap);
	}


}
