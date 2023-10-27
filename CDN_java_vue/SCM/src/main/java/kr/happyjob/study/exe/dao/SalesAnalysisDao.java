package kr.happyjob.study.exe.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.exe.model.CtSales;
import kr.happyjob.study.exe.model.PieChartData;
import kr.happyjob.study.exe.model.ProductModel;
import kr.happyjob.study.exe.model.SalesDetailModel;
import kr.happyjob.study.exe.model.SelProduct;
import kr.happyjob.study.exe.model.SpChart;

public interface SalesAnalysisDao {

	List<CtSales> ctSales() throws Exception;

	List<SelProduct> selProduct(Map<String, Object> paramMap) throws Exception;

	int selProductTotal(Map<String, Object> paramMap) throws Exception;

	List<SpChart> spChart(Map<String, Object> paramMap) throws Exception;


}
