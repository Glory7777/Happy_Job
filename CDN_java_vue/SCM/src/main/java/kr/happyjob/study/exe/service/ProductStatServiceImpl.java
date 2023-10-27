package kr.happyjob.study.exe.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.exe.dao.ProductStatDao;
import kr.happyjob.study.exe.model.PieChartData;
import kr.happyjob.study.exe.model.ProductModel;
import kr.happyjob.study.exe.model.SalesDetailModel;

@Service
public class ProductStatServiceImpl implements ProductStatService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
		
	@Autowired
	ProductStatDao dao;

	// 상품 조회
	@Override
	public List<ProductModel> productList(Map<String, Object> paramMap) throws Exception {		
		return dao.productList(paramMap);
	}
	@Override
	public int productTotal(Map<String, Object> paramMap) throws Exception {
		return dao.productTotal(paramMap);
	}
	
	// 발주 리스트 조회
	@Override
	public List<SalesDetailModel> dtList(Map<String, Object> paramMap) throws Exception {		
		return dao.dtList(paramMap);
	}
	@Override
	public int dtTotal(Map<String, Object> paramMap) throws Exception {
		return dao.dtTotal(paramMap);
	}
	@Override
	public List<PieChartData> productPieChart(Map<String, Object> paramMap) throws Exception {
		return dao.productPieChart(paramMap);
	}
	@Override
	public List<SalesDetailModel> dtListvue(Map<String, Object> paramMap) throws Exception {
		return dao.dtListvue(paramMap);
	}


}
