package kr.happyjob.study.mngins.service;

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
import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngins.dao.ProjectDao;
import kr.happyjob.study.mngins.model.HwkFileModel;
import kr.happyjob.study.mngins.model.HwkModel;
import kr.happyjob.study.mngstd.model.SubmitHwkModel;


@Service
public class ProjectServiceImpl implements ProjectService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	ProjectDao projectDao;
	
	// 파일 업로드를 위한 경로 설정
	// 물리경로
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	// 상대경로
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	// 이하경로
	@Value("${fileUpload.hwkFilePath}")
	private String hwkFilePath;
	
	
	
	
	/* 진행중인 강의 정보 불러오기
	 * (non-Javadoc)
	 * @see kr.happyjob.study.mngins.service.ProjectService#lecInfo(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public LectureModel lecInfo(Map<String, Object> paramMap) throws Exception {
		return projectDao.lecInfo(paramMap);
	}


	/* 과제 목록 조회
	 * (non-Javadoc)
	 * @see kr.happyjob.study.mngins.service.ProjectService#findHwkList(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public List<HwkModel> findHwkList(Map<String, Object> paramMap) throws Exception {
		return projectDao.findHwkList(paramMap);
	}

	
	/* 수강 학생 명단
	 * (non-Javadoc)
	 * @see kr.happyjob.study.mngins.service.ProjectService#findAppStd(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public List<Map> findAppStd(Map<String, Object> paramMap) throws Exception {
		return projectDao.findAppStd(paramMap);
	}
	

	/* 제출 현황 조회
	 * (non-Javadoc)
	 * @see kr.happyjob.study.mngins.service.ProjectService#findHwkSmList(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public List<String> findHwkSmList(Map<String, Object> paramMap) throws Exception {
		return projectDao.findHwkSmList(paramMap);
	}

	
	/* 제출된 과제 정보
	 * (non-Javadoc)
	 * @see kr.happyjob.study.mngins.service.ProjectService#findHwkSmInfo(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public SubmitHwkModel findHwkSmInfo(Map<String, Object> paramMap) throws Exception {
		return projectDao.findHwkSmInfo(paramMap);
	}
	

	/* 과제 파일 정보 조회
	 * (non-Javadoc)
	 * @see kr.happyjob.study.mngins.service.ProjectService#hwkFileInfo(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public HwkFileModel hwkFileInfo(Map<String, Object> paramMap) throws Exception {
		return projectDao.hwkFileInfo(paramMap);
	}


	/* 과제 신규 저장
	 * (non-Javadoc)
	 * @see kr.happyjob.study.mngins.service.ProjectService#insertHwkFile(java.util.Map, javax.servlet.http.HttpServletRequest)
	 * @author 김정욱
	 */
	@Override
	public String insertHwk(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		int result = 0;
		String msg = null;
		
		// 신규저장(파일O)
		if(paramMap.get("fileYN").toString().equals("Y")){
			
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
			
			String itemFilePath = hwkFilePath + File.separator;
			
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
			
			// 파일 테이블에 파일 신규 등록
			paramMap.put("hwk_file_no", 1);
			result = projectDao.insertHwkFile(paramMap);
		}
		
		// 신규저장
		result = projectDao.insertHwk(paramMap);

		if(result != 0) msg = "저장 성공";
		else msg = "저장 실패";
		
		return msg;
	}


	/* 과제 갱신
	 * (non-Javadoc)
	 * @see kr.happyjob.study.mngins.service.ProjectService#updateHwkFile(java.util.Map, javax.servlet.http.HttpServletRequest)
	 * @author 김정욱
	 */
	@Override
	public String updateHwk(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		int result = 0;
		String msg = null;
		
		// 등록 파일 번호 조회
		int hwk_file_no = projectDao.findHwkFileNo(paramMap);
		paramMap.put("hwk_file_no", hwk_file_no);

		int pre_hwk_file_no = 0;
		

		// 갱신되는 파일정보가 있을 때
		if(paramMap.get("fileYN").toString().equals("Y")){
			
			// 기존 과제에 등록된 파일이 있는경우
			if(hwk_file_no != 1){
				// 기존 파일 번호 저장. 외래키 조건에 의해 갱신 후 삭제 필요
				pre_hwk_file_no = hwk_file_no;
			}

			// 파일 테이블 갱신 파일 추가
			// 파일 정보
			MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
			
			String itemFilePath = hwkFilePath + File.separator;
			
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
			
			// 파일 테이블에 파일 신규 등록, hwk_file_no 갱신
			result = projectDao.insertHwkFile(paramMap);
			
		}

		// 과제 테이블 갱신
		result = projectDao.updateHwk(paramMap);
		
		// 파일 갱신 && 기존 파일이 있었던 경우
		if(paramMap.get("fileYN").toString().equals("Y") && pre_hwk_file_no != 0){
			
			// paramMap의 hwk_file_no에 기존 파일번호로 갱신
			paramMap.put("hwk_file_no", pre_hwk_file_no);
			
			// 파일 테이블 기존 파일 삭제
			projectDao.deleteHwkFile(paramMap);	
		}
		
		if(result != 0) msg = "갱신 성공";
		else msg = "갱신 실패";
		
		return msg;
	}


	/* 과제 삭제
	 * (non-Javadoc)
	 * @see kr.happyjob.study.mngins.service.ProjectService#deleteHwkFile(java.util.Map, javax.servlet.http.HttpServletRequest)
	 * @author 김정욱
	 */
	@Override
	public String deleteHwk(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		int result = 0;
		String msg = null;
		
		// 삭제 전 등록 파일 번호 조회
		int hwk_file_no = projectDao.findHwkFileNo(paramMap);
		
		// 과제 삭제
		result = projectDao.deleteHwk(paramMap);
		
		// 등록 파일이 있으면 파일 삭제
		if(hwk_file_no != 1){
			paramMap.put("hwk_file_no", hwk_file_no);
			projectDao.deleteHwkFile(paramMap);
		}
		
		if(result != 0) msg = "삭제 성공";
		else msg = "삭제 실패";
		
		return msg;
	}












	

}
