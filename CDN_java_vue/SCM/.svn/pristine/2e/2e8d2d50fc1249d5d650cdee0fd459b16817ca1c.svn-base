package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.system.dao.ComnComboDao;
import kr.happyjob.study.system.model.comcombo;

@Service
public class ComnComboServiceImpl implements ComnComboService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ComnComboDao comnComboDao;	
	
	
		
	/** 공급처명 목록 조회 */
	public List<comcombo> selectclientlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectclientlist(paramMap);
		
		return list;
	}
	
	/** User Type별 목록 */
	public List<comcombo> selectUClist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectUClist(paramMap);
		
		return list;
	}
	
	
	/** 상품 목록 조회 */
	public List<comcombo> selectproductlist(Map<String, Object> paramMap) throws Exception {
		
		List<comcombo> list = comnComboDao.selectproductlist(paramMap);
		
		return list;
	}	

	
	
	/** 제품 분류 목록 조회 */
    public List<comcombo> selectlargelist(Map<String, Object> paramMap) throws Exception {
    
       List<comcombo> list = comnComboDao.selectlargelist(paramMap);
    
       return list;
   }
    
    
   /** 제품 분류별  목록 조회 */
   public List<comcombo> selectdivproductlist(Map<String, Object> paramMap) throws Exception {
    
      List<comcombo> list = comnComboDao.selectdivproductlist(paramMap);
    
      return list;
   }
  
   /** 거래처별  목록 조회 */
   public List<comcombo> selectsupproductlist(Map<String, Object> paramMap) throws Exception {
	   
	   List<comcombo> list = comnComboDao.selectsupproductlist(paramMap);
	    
	   return list;
   }
 

}
