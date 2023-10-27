package kr.happyjob.study.exe.model;

public class CtSales {
	
	
	private String ct_total; // 카테고리별 판매량
	private String ct_nm; // 카테고리명
	private int percentage; // 퍼센트
	
	public String getCt_total() {
		return ct_total;
	}
	public void setCt_total(String ct_total) {
		this.ct_total = ct_total;
	}
	public String getCt_nm() {
		return ct_nm;
	}
	public void setCt_nm(String ct_nm) {
		this.ct_nm = ct_nm;
	}
	public int getPercentage() {
		return percentage;
	}
	public void setPercentage(int percentage) {
		this.percentage = percentage;
	}
	

}
