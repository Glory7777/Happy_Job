package kr.happyjob.study.exe.model;

public class SalesDetailModel {
	
	private String order_cd; // 주문번호
	private String pro_cd; // 상품번호
	private String pro_nm; // 상품명
	private String order_date; // 거래일
	private String order_price; // 거래액
	private int order_cnt; // 거래수량
	
	private String name; // 구매자
	
	
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

	public String getPro_nm() {
		return pro_nm;
	}

	public void setPro_nm(String pro_nm) {
		this.pro_nm = pro_nm;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public String getOrder_price() {
		return order_price;
	}

	public void setOrder_price(String order_price) {
		this.order_price = order_price;
	}

	public int getOrder_cnt() {
		return order_cnt;
	}

	public void setOrder_cnt(int order_cnt) {
		this.order_cnt = order_cnt;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


}
