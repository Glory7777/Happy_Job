package kr.happyjob.study.dlm.model;

public class StockedModel {

	private String pur_cd;		// 발주 코드
	private String pro_cd; 	// 상품 코드
	private String pro_nm;	// 상품명
	private String pro_mfc;	// 제조사
	private String sup_cd; 	// 납품 업체 코드
	private String sup_nm;	// 납품 업체명
	private String pro_stock;	// 재고
	private String pur_cnt;	// 발주 수량
	private String pur_appr;		// 발주 승인
	private String del_nm; 	// 배송 담당
	private String pur_stk_date; 	// 입고 일자
	private String pur_stk_cnt;	// 입고 수량
	
	public String getPur_cd() {
		return pur_cd;
	}
	public void setPur_cd(String pur_cd) {
		this.pur_cd = pur_cd;
	}
	public String getPro_cd() {
		return pro_cd;
	}
	public void setPro_cd(String pro_cd) {
		this.pro_cd = pro_cd;
	}
	public String getPro_nm() {
		return pro_nm;
	}
	public void setPro_nm(String pro_nm) {
		this.pro_nm = pro_nm;
	}
	public String getPro_mfc() {
		return pro_mfc;
	}
	public void setPro_mfc(String pro_mfc) {
		this.pro_mfc = pro_mfc;
	}
	public String getSup_cd() {
		return sup_cd;
	}
	public void setSup_cd(String sup_cd) {
		this.sup_cd = sup_cd;
	}
	public String getSup_nm() {
		return sup_nm;
	}
	public void setSup_nm(String sup_nm) {
		this.sup_nm = sup_nm;
	}
	public String getPro_stock() {
		return pro_stock;
	}
	public void setPro_stock(String pro_stock) {
		this.pro_stock = pro_stock;
	}
	public String getPur_cnt() {
		return pur_cnt;
	}
	public void setPur_cnt(String pur_cnt) {
		this.pur_cnt = pur_cnt;
	}
	public String getPur_appr() {
		return pur_appr;
	}
	public void setPur_appr(String pur_appr) {
		this.pur_appr = pur_appr;
	}
	public String getDel_nm() {
		return del_nm;
	}
	public void setDel_nm(String del_nm) {
		this.del_nm = del_nm;
	}
	public String getPur_stk_date() {
		return pur_stk_date;
	}
	public void setPur_stk_date(String pur_stk_date) {
		this.pur_stk_date = pur_stk_date;
	}
	public String getPur_stk_cnt() {
		return pur_stk_cnt;
	}
	public void setPur_stk_cnt(String pur_stk_cnt) {
		this.pur_stk_cnt = pur_stk_cnt;
	}	
		
}
