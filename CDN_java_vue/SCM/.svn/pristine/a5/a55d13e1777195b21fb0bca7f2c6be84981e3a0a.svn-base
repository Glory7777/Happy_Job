package kr.happyjob.study.dlm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.dlm.dao.StockedDao;
import kr.happyjob.study.dlm.model.StockedModel;
import kr.happyjob.study.dlm.model.SupplierInfoModel;

@Service
public class StockedServiceImpl implements StockedService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	StockedDao stockedDao;

	// 입고 처리할 발주 리스트
	@Override
	public List<StockedModel> stockedList(Map<String, Object> paramMap) throws Exception {		
		return stockedDao.stockedList(paramMap);
	}

	// 입금 처리 된 전체 발주 건수 조회
	@Override
	public int totalCnt(Map<String, Object> paramMap) throws Exception {		
		return stockedDao.totalCnt(paramMap);
	}

	// 입고 완료 처리를 위해 발주 정보 업데이트
	@Override
	public int stockUpdate(Map<String, Object> paramMap) throws Exception {		
		return stockedDao.stockUpdate(paramMap);
	}

	// 상품 테이블에 입고 수량만큼 재고 업데이트
	@Override
	public int productStockUpdate(Map<String, Object> paramMap) throws Exception {		
		return stockedDao.productStockUpdate(paramMap);
	}

	// 납품 업체 정보 가져오기
	@Override
	public SupplierInfoModel selectSup(Map<String, Object> paramMap) throws Exception {		
		return stockedDao.selectSup(paramMap);
	}
	
	
	
}
