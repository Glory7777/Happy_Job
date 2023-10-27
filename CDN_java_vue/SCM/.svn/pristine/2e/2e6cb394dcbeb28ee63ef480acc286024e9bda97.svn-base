package kr.happyjob.study.dashboard.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.dashboard.model.DashboardScmModel;

	public interface DashboardScmService {

		/** SCM(메인대시보드) 미응답 1:1 문의 */
		public int getDataUnanswered(Map<String, Object> paramMap) throws Exception;
		/** SCM(메인대시보드) 미승인 반품 */
		public int getDataUnrefund(Map<String, Object> paramMap) throws Exception;
		/** SCM(메인대시보드) 미발송 배송지시서*/
		public int getDataUndeli(Map<String, Object> paramMap) throws Exception;
		/** SCM(메인대시보드) 상품 누적 판매량*/
		public List<DashboardScmModel> getTotalOrder(Map<String, Object> paramMap) throws Exception;
		/** SCM(메인대시보드) 상품 누적 반품량*/
		public List<DashboardScmModel> getTotalRefund(Map<String, Object> paramMap) throws Exception;
		
	}
