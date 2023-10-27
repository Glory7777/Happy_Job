package kr.happyjob.study.exe.model;

public class SpChart {
	
	
	public String gettMonth() {
		return month;
	}
	public void settMonth(String month) {
		this.month = month;
	}
	public String getMonth_profit() {
		return month_profit;
	}
	public void setMonth_profit(String month_profit) {
		this.month_profit = month_profit;
	}
	private String month; // 카테고리별 판매량
	private String month_profit; // 카테고리명


}
