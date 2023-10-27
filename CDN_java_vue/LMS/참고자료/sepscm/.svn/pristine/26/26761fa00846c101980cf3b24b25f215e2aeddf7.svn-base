package kr.happyjob.study.scm.service;

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
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.scm.dao.NoticeDao;
import kr.happyjob.study.scm.model.NoticeModel;

@Service
public class NoticeServiceImpl implements NoticeService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	NoticeDao noticeDao;
	
	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.noticePath}")
	private String noticePath;
	
	
	/** 공지사항 목록 조회 */
	public List<NoticeModel> listnotice(Map<String, Object> paramMap) throws Exception {
		
		// List<NoticeModel> listComnGrpCod = noticeDao.listnotice(paramMap);
		
		return noticeDao.listnotice(paramMap);
	}
	
	/** 공지사항 카운트 조회 */
	public int totalnotice(Map<String, Object> paramMap) throws Exception {
		
		//int totalCount = noticeDao.totalnotice(paramMap);
		
		return noticeDao.totalnotice(paramMap);
	}
	
	/** 공지사항 한건 조회 */
	public NoticeModel noticeselect(Map<String, Object> paramMap) throws Exception  {
		
		noticeDao.noticereadcntup(paramMap);		
		
		return noticeDao.noticeselect(paramMap);
	}
	
	
	/** 공지사항 등록 */
	public int insertnotice(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.insertnotice(paramMap);
	}
	
	/** 공지사항 수정 */
	public int updatenotice(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.updatenotice(paramMap);
	}
	
	/** 공지사항 삭제 */
	public int deletenotice(Map<String, Object> paramMap) throws Exception {
		
		return noticeDao.deletenotice(paramMap);
	}
	
	/** 공지사항 등록 */
	public int insertnoticefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		String itemFilePath = noticePath + File.separator;   // notice/    rootPath : x:\\FileRepository
		                                                     // x:\\FileRepository\notice/a.jpg
		
		logger.info("   - rootPath : " + rootPath);
		logger.info("   - itemFilePath : " + itemFilePath);
		logger.info("   - virtualRootPath : " + virtualRootPath);
		
		// multipartHttpServletRequest  파일절보    파일명...     rootPath(x:\\FileRepository) + itemFilePath(notice/) + 파일명
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileinfo = fileUtil.uploadFiles();
		
		//fileinfo.put("file_nm", file_nm);
		//fileinfo.put("file_size", file_Size);
		//fileinfo.put("file_loc", file_loc);
		//fileinfo.put("vrfile_loc", vrfile_loc);
		//fileinfo.put("fileExtension", fileExtension);
		
		logger.info("   - file_nm : " + fileinfo.get("file_nm"));
		logger.info("   - file_size : " + fileinfo.get("file_size"));
		logger.info("   - file_loc : " + fileinfo.get("file_loc"));
		logger.info("   - vrfile_loc : " + fileinfo.get("vrfile_loc"));
		logger.info("   - fileExtension : " + fileinfo.get("fileExtension"));
		
		paramMap.put("fileinfo", fileinfo);
		
		int result = noticeDao.insertnoticefile(paramMap);
		String file_nm = (String) fileinfo.get("file_nm");
		
		if(file_nm != "" && file_nm != null) {
			paramMap.put("modiyn","N");	
			noticeDao.insertnoticefileinfo(paramMap);
		}
		
		
		return result;
	}
	
	/** 공지사항 수정 */
	public int updatenoticefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
	 	//               File 첨부(등록시점)   File 미첨부(등록시점)	
		//수정    File 첨부	   파일  처리                            파일 처리	
		//	  File 미첨부      파일 유지                             파일 처리 안함	
		
		paramMap.put("notice_cd",paramMap.get("selnoticecd"));		
		NoticeModel oldinfo = noticeDao.noticeselect(paramMap);
		String oldfile = oldinfo.getFile_nm();
		
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		String itemFilePath = noticePath + File.separator;   // notice/    rootPath : x:\\FileRepository
		                                                     // x:\\FileRepository\notice/a.jpg
		
		logger.info("   - rootPath : " + rootPath);
		logger.info("   - itemFilePath : " + itemFilePath);
		logger.info("   - virtualRootPath : " + virtualRootPath);
		
		// multipartHttpServletRequest  파일절보    파일명...     rootPath(x:\\FileRepository) + itemFilePath(notice/) + 파일명
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileinfo = fileUtil.uploadFiles();
		
		//fileinfo.put("file_nm", file_nm);
		//fileinfo.put("file_size", file_Size);
		//fileinfo.put("file_loc", file_loc);
		//fileinfo.put("vrfile_loc", vrfile_loc);
		//fileinfo.put("fileExtension", fileExtension);
		
		logger.info("   - file_nm : " + fileinfo.get("file_nm"));
		logger.info("   - file_size : " + fileinfo.get("file_size"));
		logger.info("   - file_loc : " + fileinfo.get("file_loc"));
		logger.info("   - vrfile_loc : " + fileinfo.get("vrfile_loc"));
		logger.info("   - fileExtension : " + fileinfo.get("fileExtension"));
		
		paramMap.put("fileinfo", fileinfo);
		
		int result = noticeDao.updatenoticefile(paramMap);
		String file_nm = (String) fileinfo.get("file_nm");
		
		if(oldfile != "" && oldfile != null) {
			if(file_nm != "" && file_nm != null) {
				
				File oldphfile = new File(oldinfo.getPhysic_path());
				oldphfile.delete();
				
				noticeDao.updatenoticefileinfo(paramMap);
			}
		} else {
			if(file_nm != "" && file_nm != null) {
				paramMap.put("modiyn","Y");	
				noticeDao.insertnoticefileinfo(paramMap);
			}
		}
		
		return result;
	}
	
	/** 공지사항 삭제 */
	public int deletenoticefile(Map<String, Object> paramMap) throws Exception {		
	
		// notice_cd   file 첨부 여부
		// 첨부가 되어 잇었다     file 정 삭제      파일 삭제       file_cd
		// 공지사항 정보 삭제
		
		paramMap.put("notice_cd",paramMap.get("selnoticecd"));	
/*		NoticeModel oldinfo = noticeDao.noticeselect(paramMap);
		String oldfile = oldinfo.getFile_nm();
		
		if(oldfile != "" && oldfile != null) {
			File oldphfile = new File(oldinfo.getPhysic_path());
			oldphfile.delete();
			
			noticeDao.deletenoticefileinfo(paramMap);
		}
	*/	
		return noticeDao.deletenotice(paramMap);
	}
}
