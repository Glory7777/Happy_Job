package kr.happyjob.study.scm.model;

public class RefundListModel {
	
	private String refund_cd;
	private String order_cd;
	private String pro_cd;
	private int refund_cnt;
	private int refund_price;
	private String refund_date;
	private String refund_st;
	private String refund_text;
	private String pro_mfc;
	private String pro_nm;
	private String pro_model_nm;
	private int order_cnt;
	
	
	public String getPro_model_nm() {
		return pro_model_nm;
	}
	public void setPro_model_nm(String pro_model_nm) {
		this.pro_model_nm = pro_model_nm;
	}
	public int getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(int order_cnt) {
		this.order_cnt = order_cnt;
	}
	public String getPro_mfc() {
		return pro_mfc;
	}
	public void setPro_mfc(String pro_mfc) {
		this.pro_mfc = pro_mfc;
	}
	public String getPro_nm() {
		return pro_nm;
	}
	public void setPro_nm(String pro_nm) {
		this.pro_nm = pro_nm;
	}
	public String getRefund_cd() {
		return refund_cd;
	}
	public void setRefund_cd(String refund_cd) {
		this.refund_cd = refund_cd;
	}
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	public String getPro_cd() {
		return pro_cd;
	}
	public void setPro_cd(String pro_cd) {
		this.pro_cd = pro_cd;
	}
	public int getRefund_cnt() {
		return refund_cnt;
	}
	public void setRefund_cnt(int refund_cnt) {
		this.refund_cnt = refund_cnt;
	}
	public int getRefund_price() {
		return refund_price;
	}
	public void setRefund_price(int refund_price) {
		this.refund_price = refund_price;
	}
	public String getRefund_date() {
		return refund_date;
	}
	public void setRefund_date(String refund_date) {
		this.refund_date = refund_date;
	}
	public String getRefund_st() {
		return refund_st;
	}
	public void setRefund_st(String refund_st) {
		this.refund_st = refund_st;
	}
	public String getRefund_text() {
		return refund_text;
	}
	public void setRefund_text(String refund_text) {
		this.refund_text = refund_text;
	}
	
	
}
