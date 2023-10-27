package kr.happyjob.study.scm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.scm.dao.StockedProductDao;
import kr.happyjob.study.scm.model.StockedProductModel;

@Service
public class StockedProductServiceImpl implements StockedProductService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StockedProductDao stockedProductDao;

	// 상품별 재고 리스트 조회
	@Override
	public List<StockedProductModel> stockedProductList(Map<String, Object> paramMap) throws Exception {		
		return stockedProductDao.stockedProductList(paramMap);
	}

	// 전체 상품 개수 조회
	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {		
		return stockedProductDao.totalCnt(paramMap);
	}
	
	
}
