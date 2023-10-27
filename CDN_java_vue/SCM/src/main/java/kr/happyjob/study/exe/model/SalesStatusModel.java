package kr.happyjob.study.exe.model;

public class SalesStatusModel {
	
	private int order_cd;
	private String pro_nm;
	private String name;
	private int refund_yn;
	private String order_date;
	private String order_cnt;
	private String order_price;
	private String net_profit;
	
	public String getNet_profit() {
		return net_profit;
	}
	public void setNet_profit(String net_profit) {
		this.net_profit = net_profit;
	}
	public int getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(int order_cd) {
		this.order_cd = order_cd;
	}
	public String getPro_nm() {
		return pro_nm;
	}
	public void setPro_nm(String pro_nm) {
		this.pro_nm = pro_nm;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getRefund_yn() {
		return refund_yn;
	}
	public void setRefund_yn(int refund_yn) {
		this.refund_yn = refund_yn;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(String order_cnt) {
		this.order_cnt = order_cnt;
	}
	public String getOrder_price() {
		return order_price;
	}
	public void setOrder_price(String order_price) {
		this.order_price = order_price;
	}

	
	
}
