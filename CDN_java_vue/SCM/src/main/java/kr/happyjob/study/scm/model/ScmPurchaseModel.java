package kr.happyjob.study.scm.model;

public class ScmPurchaseModel {

	private String pur_cd;		// 발주 코드
	private String pro_cd;		// 상품 코드
	private String pro_nm;	// 상품명
	private String pro_unit_price;		// 납품 단가
	private String pur_cnt;		// 발주 수량
	private String pur_total_unit_price;	// 총 납품액
	private String sup_cd;		// 납품 업체 코드
	private String sup_nm;		// 납품 업체명
	private String pur_appr;		// 발주 승인
	private String pur_nm1;		// 발주자	
	private String pur_date;		// 발주 일자	
	private String admin_nm;		// 승인자
	private String pur_appr_date;		// 승인 일자
	private String pur_nm2;		// 구매 담당
	private String pur_dps_date; 		// 입금 일자
	private String del_nm;		// 배송 담당
	private String pur_stk_date;		// 입고 일자
	private int pur_stk_cnt;		// 입고 수량
	private int pro_stock;		// 재고
	
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
	public String getPro_unit_price() {
		return pro_unit_price;
	}
	public void setPro_unit_price(String pro_unit_price) {
		this.pro_unit_price = pro_unit_price;
	}
	public String getPur_cnt() {
		return pur_cnt;
	}
	public void setPur_cnt(String pur_cnt) {
		this.pur_cnt = pur_cnt;
	}
	public String getPur_total_unit_price() {
		return pur_total_unit_price;
	}
	public void setPur_total_unit_price(String pur_total_unit_price) {
		this.pur_total_unit_price = pur_total_unit_price;
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
	public String getPur_appr() {
		return pur_appr;
	}
	public void setPur_appr(String pur_appr) {
		this.pur_appr = pur_appr;
	}
	public String getPur_nm1() {
		return pur_nm1;
	}
	public void setPur_nm1(String pur_nm1) {
		this.pur_nm1 = pur_nm1;
	}
	public String getPur_date() {
		return pur_date;
	}
	public void setPur_date(String pur_date) {
		this.pur_date = pur_date;
	}
	public String getAdmin_nm() {
		return admin_nm;
	}
	public void setAdmin_nm(String admin_nm) {
		this.admin_nm = admin_nm;
	}
	public String getPur_appr_date() {
		return pur_appr_date;
	}
	public void setPur_appr_date(String pur_appr_date) {
		this.pur_appr_date = pur_appr_date;
	}
	public String getPur_nm2() {
		return pur_nm2;
	}
	public void setPur_nm2(String pur_nm2) {
		this.pur_nm2 = pur_nm2;
	}
	public String getPur_dps_date() {
		return pur_dps_date;
	}
	public void setPur_dps_date(String pur_dps_date) {
		this.pur_dps_date = pur_dps_date;
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
	public int getPur_stk_cnt() {
		return pur_stk_cnt;
	}
	public void setPur_stk_cnt(int pur_stk_cnt) {
		this.pur_stk_cnt = pur_stk_cnt;
	}
	public int getPro_stock() {
		return pro_stock;
	}
	public void setPro_stock(int pro_stock) {
		this.pro_stock = pro_stock;
	}	
	
}
