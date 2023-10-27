package kr.happyjob.study.cus.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.cus.model.CartModel;
import kr.happyjob.study.cus.model.ProductModel;

public interface CartDao {

	/** 장바구니 목록 조회 */
	public List<CartModel> listCart(Map<String, Object> paramMap) throws Exception;
	
	/** 장바구니  카운트 조회 */
	public int totalCart(Map<String, Object> paramMap) throws Exception;
	
	/** 상품 목록 한건 조회 */
	public CartModel selectAccount(Map<String, Object> paramMap) throws Exception;	
	
	/** 장바구니 삭제(단건) */
	public int deleteCart(Map<String, Object> paramMap) throws Exception;
	
	/** 장바구니 삭제 */
	public int selectDeleteCart(Map<String, Object> paramMap) throws Exception;
	
	/** 장바구니 주문 */
	public int orderCart(Map<String, Object> paramMap) throws Exception;
	
}
