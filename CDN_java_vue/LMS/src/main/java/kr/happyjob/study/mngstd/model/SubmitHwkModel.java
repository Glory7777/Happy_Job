package kr.happyjob.study.mngstd.model;

public class SubmitHwkModel {
	
	// tb_hwk_sm
	private int lec_cd;
	private int hwk_no;
	private String loginID;
	private int sm_file_no;
	private String sm_date;
	private String sm_ctt;
	
	// tb_sm_file
	private String sm_file_nm;
	
	
	
	public int getLec_cd() {
		return lec_cd;
	}
	public void setLec_cd(int lec_cd) {
		this.lec_cd = lec_cd;
	}
	public int getHwk_no() {
		return hwk_no;
	}
	public void setHwk_no(int hwk_no) {
		this.hwk_no = hwk_no;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getSm_file_no() {
		return sm_file_no;
	}
	public void setSm_file_no(int sm_file_no) {
		this.sm_file_no = sm_file_no;
	}
	public String getSm_date() {
		return sm_date;
	}
	public void setSm_date(String sm_date) {
		this.sm_date = sm_date;
	}
	public String getSm_ctt() {
		return sm_ctt;
	}
	public void setSm_ctt(String sm_ctt) {
		this.sm_ctt = sm_ctt;
	}
	public String getSm_file_nm() {
		return sm_file_nm;
	}
	public void setSm_file_nm(String sm_file_nm) {
		this.sm_file_nm = sm_file_nm;
	}
	
	
}
