package kr.happyjob.study.dashboard.model;

public class DashboardDlmModel {
	
	//지시서
	private String direc_cd; 
	private String direc_date; 
	private String direc_type; 
	private String direc_note; 
	private String loginid; 
	private String pur_cd; 
	private String pro_cd; 
	private String deli_cd; 
	private String refund_cd; 
	private String order_cd;
	
	//배송
	private String deli_st; 
	private String deli_date; 
	private int deli_cnt;
	
	//주문
	private String order_date; 
	private String order_hope_date; 
	private String order_st;
	private int order_cnt;
	
	//상품
	private String pro_nm;
	//사용자
	private String addr;
	private String addr_dt;
	
	
	public String getDirec_cd() {
		return direc_cd;
	}
	public void setDirec_cd(String direc_cd) {
		this.direc_cd = direc_cd;
	}
	public String getDirec_date() {
		return direc_date;
	}
	public void setDirec_date(String direc_date) {
		this.direc_date = direc_date;
	}
	public String getDirec_type() {
		return direc_type;
	}
	public void setDirec_type(String direc_type) {
		this.direc_type = direc_type;
	}
	public String getDirec_note() {
		return direc_note;
	}
	public void setDirec_note(String direc_note) {
		this.direc_note = direc_note;
	}
	public String getLoginid() {
		return loginid;
	}
	public void setLoginid(String loginid) {
		this.loginid = loginid;
	}
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
	public String getDeli_cd() {
		return deli_cd;
	}
	public void setDeli_cd(String deli_cd) {
		this.deli_cd = deli_cd;
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
	public String getDeli_st() {
		return deli_st;
	}
	public void setDeli_st(String deli_st) {
		this.deli_st = deli_st;
	}
	public String getDeli_date() {
		return deli_date;
	}
	public void setDeli_date(String deli_date) {
		this.deli_date = deli_date;
	}
	public int getDeli_cnt() {
		return deli_cnt;
	}
	public void setDeli_cnt(int deli_cnt) {
		this.deli_cnt = deli_cnt;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getOrder_hope_date() {
		return order_hope_date;
	}
	public void setOrder_hope_date(String order_hope_date) {
		this.order_hope_date = order_hope_date;
	}
	public String getOrder_st() {
		return order_st;
	}
	public void setOrder_st(String order_st) {
		this.order_st = order_st;
	}
	public String getPro_nm() {
		return pro_nm;
	}
	public void setPro_nm(String pro_nm) {
		this.pro_nm = pro_nm;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getAddr_dt() {
		return addr_dt;
	}
	public void setAddr_dt(String addr_dt) {
		this.addr_dt = addr_dt;
	}
	public int getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(int order_cnt) {
		this.order_cnt = order_cnt;
	}
	
	
}
