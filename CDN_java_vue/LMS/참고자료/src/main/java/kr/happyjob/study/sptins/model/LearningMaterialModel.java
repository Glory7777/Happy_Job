package kr.happyjob.study.sptins.model;

public class LearningMaterialModel {
	
	// tb_lec_week
	private int lec_cd;
	private String weekly_no;
	private String week_goal;
	private int lec_file_no;
	
	// tb_lec_file
	private String lec_file_upload_date;

	
	public String getWeekly_no() {
		return weekly_no;
	}
	public void setWeekly_no(String weekly_no) {
		this.weekly_no = weekly_no;
	}
	public String getWeek_goal() {
		return week_goal;
	}
	public void setWeek_goal(String week_goal) {
		this.week_goal = week_goal;
	}
	public String getLec_file_upload_date() {
		return lec_file_upload_date;
	}
	public void setLec_file_upload_date(String lec_file_upload_date) {
		this.lec_file_upload_date = lec_file_upload_date;
	}
	public int getLec_cd() {
		return lec_cd;
	}
	public void setLec_cd(int lec_cd) {
		this.lec_cd = lec_cd;
	}
	public int getLec_file_no() {
		return lec_file_no;
	}
	public void setLec_file_no(int lec_file_no) {
		this.lec_file_no = lec_file_no;
	}
	
	
	
	
}






