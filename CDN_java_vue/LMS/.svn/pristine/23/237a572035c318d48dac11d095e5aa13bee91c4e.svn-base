package kr.happyjob.study.mngstd.service;

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

import kr.happyjob.study.mngstd.dao.MylecListDao;
import kr.happyjob.study.mngstd.model.MylecListModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;



@Service
public class MylecListServiceImpl implements MylecListService {

		@Autowired
		MylecListDao mylecListDao;
	
	   // Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());
	   
	   // Get class name for logger
	   private final String className = this.getClass().toString();

		/** 수강중인강의 목록 조회 */
	   @Override
		public List<MylecListModel> myLecList(Map<String, Object> paramMap) throws Exception{
			
			return mylecListDao.myLecList(paramMap);
		}
	   
	   
	   
}
