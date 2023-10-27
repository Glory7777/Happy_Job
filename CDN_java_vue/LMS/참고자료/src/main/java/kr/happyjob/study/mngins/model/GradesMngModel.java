package kr.happyjob.study.mngins.model;

public class GradesMngModel {
	
	// tb_test
	private int lec_cd;						
	private String test_nm;
	private String test_start_date;
	private String test_end_date;
	
	// tb_userinfo
	private String name;

	
	
	
	public int getLec_cd() {
		return lec_cd;
	}

	public void setLec_cd(int lec_cd) {
		this.lec_cd = lec_cd;
	}

	public String getTest_nm() {
		return test_nm;
	}

	public void setTest_nm(String test_nm) {
		this.test_nm = test_nm;
	}

	public String getTest_start_date() {
		return test_start_date;
	}

	public void setTest_start_date(String test_start_date) {
		this.test_start_date = test_start_date;
	}

	public String getTest_end_date() {
		return test_end_date;
	}

	public void setTest_end_date(String test_end_date) {
		this.test_end_date = test_end_date;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
}
