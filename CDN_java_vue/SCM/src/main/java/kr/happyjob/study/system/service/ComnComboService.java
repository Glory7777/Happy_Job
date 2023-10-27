package kr.happyjob.study.system.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;
import kr.happyjob.study.system.model.comcombo;

public interface ComnComboService {

	/** 공급처명 목록 조회 */
	public List<comcombo> selectclientlist(Map<String, Object> paramMap) throws Exception;
	
	/** User Type별 목록 */
	public List<comcombo> selectUClist(Map<String, Object> paramMap) throws Exception;
	
	
	/** 제품  목록 조회 */
	public List<comcombo> selectproductlist(Map<String, Object> paramMap) throws Exception;
	
	/** 제품 분류 목록 조회 */
    public List<comcombo> selectlargelist(Map<String, Object> paramMap) throws Exception;
    
    /** 제품 분류 별  목록 조회 */
    public List<comcombo> selectdivproductlist(Map<String, Object> paramMap) throws Exception;
  
    /** 거래처별  목록 조회 */
    public List<comcombo> selectsupproductlist(Map<String, Object> paramMap) throws Exception;
  
    
}
