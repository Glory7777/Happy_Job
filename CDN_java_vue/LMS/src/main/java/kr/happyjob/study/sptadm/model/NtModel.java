package kr.happyjob.study.sptadm.model;

public class NtModel {
	
	// 게시판 글 번호
	private String brd_no;
    private String brd_title;
    private String brd_ctt;
    private String brd_wt;
    private String loginID;
	private String brd_reg_date;
	private int brd_veiws_cnt;
	private String brd_delete_yn;
	private String ctg_cd;

	private String sm_file_path;
	private String sm_file_nm;
	private String sm_file_uuid_nm;
	private int sm_file_size;
    private String sm_file_extend;
	private String sm_file_logicalpath;
    
    
	public String getBrd_no() {
		return brd_no;
	}
	public void setBrd_no(String brd_no) {
		this.brd_no = brd_no;
	}
	public String getBrd_title() {
		return brd_title;
	}
	public void setBrd_title(String brd_title) {
		this.brd_title = brd_title;
	}
	public String getBrd_ctt() {
		return brd_ctt;
	}
	public void setBrd_ctt(String brd_ctt) {
		this.brd_ctt = brd_ctt;
	}
	public String getBrd_wt() {
		return brd_wt;
	}
	public void setBrd_wt(String brd_wt) {
		this.brd_wt = brd_wt;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getBrd_reg_date() {
		return brd_reg_date;
	}
	public void setBrd_reg_date(String brd_reg_date) {
		this.brd_reg_date = brd_reg_date;
	}
	public int getBrd_veiws_cnt() {
		return brd_veiws_cnt;
	}
	public void setBrd_veiws_cnt(int brd_veiws_cnt) {
		this.brd_veiws_cnt = brd_veiws_cnt;
	}
	public String getBrd_delete_yn() {
		return brd_delete_yn;
	}
	public void setBrd_delete_yn(String brd_delete_yn) {
		this.brd_delete_yn = brd_delete_yn;
	}
	public String getCtg_cd() {
		return ctg_cd;
	}
	public void setCtg_cd(String ctg_cd) {
		this.ctg_cd = ctg_cd;
	}

	public String getSm_file_path() {
		return sm_file_path;
	}
	public void setSm_file_path(String sm_file_path) {
		this.sm_file_path = sm_file_path;
	}
	public String getSm_file_nm() {
		return sm_file_nm;
	}
	public void setSm_file_nm(String sm_file_nm) {
		this.sm_file_nm = sm_file_nm;
	}
	public String getSm_file_uuid_nm() {
		return sm_file_uuid_nm;
	}
	public void setSm_file_uuid_nm(String sm_file_uuid_nm) {
		this.sm_file_uuid_nm = sm_file_uuid_nm;
	}
	public int getSm_file_size() {
		return sm_file_size;
	}
	public void setSm_file_size(int sm_file_size) {
		this.sm_file_size = sm_file_size;
	}
	public String getSm_file_extend() {
		return sm_file_extend;
	}
	public void setSm_file_extend(String sm_file_extend) {
		this.sm_file_extend = sm_file_extend;
	}
    public String getSm_file_logicalpath() {
		return sm_file_logicalpath;
	}
	public void setSm_file_logicalpath(String sm_file_logicalpath) {
		this.sm_file_logicalpath = sm_file_logicalpath;
	}

}
