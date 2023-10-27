package kr.happyjob.study.exe.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.exe.dao.ProductStatDao;
import kr.happyjob.study.exe.dao.SalesAnalysisDao;
import kr.happyjob.study.exe.model.CtSales;
import kr.happyjob.study.exe.model.PieChartData;
import kr.happyjob.study.exe.model.ProductModel;
import kr.happyjob.study.exe.model.SalesDetailModel;
import kr.happyjob.study.exe.model.SelProduct;
import kr.happyjob.study.exe.model.SpChart;

@Service
public class SalesAnalysisServiceImpl implements SalesAnalysisService {
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
		
	// Get class name for logger
	private final String className = this.getClass().toString();
		
	@Autowired
	SalesAnalysisDao dao;

	@Override
	public List<CtSales> ctSales() throws Exception {
		return dao.ctSales();
	}

	@Override
	public List<SelProduct> selProduct(Map<String, Object> paramMap) throws Exception {
		return dao.selProduct(paramMap);
	}

	@Override
	public int selProductTotal(Map<String, Object> paramMap) throws Exception {
		return dao.selProductTotal(paramMap);
	}

	@Override
	public List<SpChart> spChart(Map<String, Object> paramMap) throws Exception {
		return dao.spChart(paramMap);
	}



}
