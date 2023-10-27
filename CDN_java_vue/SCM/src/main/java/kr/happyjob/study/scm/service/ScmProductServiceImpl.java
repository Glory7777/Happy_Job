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

import kr.happyjob.study.common.comnUtils.FileUtilCho;
import kr.happyjob.study.scm.dao.ScmProductDao;
import kr.happyjob.study.scm.model.ProductModel;
import kr.happyjob.study.scm.model.SupplierModel;

@Service
public class ScmProductServiceImpl  implements ScmProductService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ScmProductDao productDao;

	// Root path for file upload 
	@Value("${fileUpload.rootPath}")
	private String rootPath;
	
	@Value("${fileUpload.virtualRootPath}")
	private String virtualRootPath;
	
	@Value("${fileUpload.productImage}")
	private String productImage;

	@Override
	public List<ProductModel> productList(Map<String, Object> paramMap) throws Exception {
		return productDao.productList(paramMap);
	}

	@Override
	public int productTotal(Map<String, Object> paramMap) throws Exception {
		return productDao.productTotal(paramMap);
	}

	@Override
	public List<SupplierModel> supList() throws Exception {
		
		
		return productDao.supList();
	}

	@Override
	public ProductModel productSelect(Map<String, Object> paramMap) throws Exception {
		return productDao.productSelect(paramMap);
	}

	@Override
	public int insertProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		String itemFilePath = productImage + File.separator;   // notice/    rootPath : x:\\FileRepository
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
		
		int result = productDao.insertProduct(paramMap);
		
		int supResult = 0;
		if(result >= 0){

			supResult = productDao.insertSup(paramMap);
		}

		String file_nm = (String) fileinfo.get("file_nm");
		
		if(file_nm != "" && file_nm != null) {
			paramMap.put("modiyn","N");	
			productDao.insertProductFile(paramMap);
		}
		
		return supResult;
	}

	@Override
	public int updateProduct(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		ProductModel oldinfo = productDao.productSelect(paramMap);
		
		logger.info(oldinfo.getFile_nm());
		
		String oldfile = oldinfo.getFile_nm();			
		
		
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		
		String itemFilePath = productImage + File.separator;   // notice/    rootPath : x:\\FileRepository
		                                                     // x:\\FileRepository\notice/a.jpg
		
		logger.info("   - rootPath : " + rootPath);
		logger.info("   - itemFilePath : " + itemFilePath);
		logger.info("   - virtualRootPath : " + virtualRootPath);
		
		// multipartHttpServletRequest  파일절보    파일명...     rootPath(x:\\FileRepository) + itemFilePath(notice/) + 파일명
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, rootPath, virtualRootPath, itemFilePath);
		Map<String, Object> fileinfo = fileUtil.uploadFiles();
		
		
		logger.info("   - file_nm : " + fileinfo.get("file_nm"));
		logger.info("   - file_size : " + fileinfo.get("file_size"));
		logger.info("   - file_loc : " + fileinfo.get("file_loc"));
		logger.info("   - vrfile_loc : " + fileinfo.get("vrfile_loc"));
		logger.info("   - fileExtension : " + fileinfo.get("fileExtension"));
		
		paramMap.put("fileinfo", fileinfo);
		
		int result = productDao.updateProduct(paramMap);
		String file_nm = (String) fileinfo.get("file_nm");
		
		if(oldfile != "" && oldfile != null) {
			if(file_nm != "" && file_nm != null) {
				
				File oldphfile = new File(oldinfo.getPhysic_path());
				oldphfile.delete();
				
				productDao.updateProductFile(paramMap);
			}
		} else {
			if(file_nm != "" && file_nm != null) {
				paramMap.put("modiyn","Y");	
				productDao.insertProductFile(paramMap);
			}
		}
		
		return result;
	}
		

	@Override
	public int deleteProduct(Map<String, Object> paramMap) throws Exception {
		
		return productDao.deleteProduct(paramMap);
	}

	@Override
	public List<SupplierModel> selectSupList(Map<String, Object> paramMap) throws Exception {
		return productDao.selectSupList(paramMap);
	}
	
}
