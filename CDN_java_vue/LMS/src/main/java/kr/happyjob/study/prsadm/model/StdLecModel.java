package kr.happyjob.study.prsadm.model;

public class StdLecModel {
	
	private int lec_cd; //강의코드
	private String loginID; //학생 ID
	private String app_yn; // 승인여부
	private String end_yn; // 종강여부 // 여기까지 수강목록(tb_app_list)
	
	private String lec_nm; // 과목 // 여기서부터 tb_lec시작
	private String lec_ctg; //분류 
	private String ins_id; //강사 id (tb_lec.loginID)	
	private String ins_nm; //강사 이름 (tb_userinfo.name)	
	private String ins_email; //강사 이메일 (tb_userinfo.name)	
	private String ins_hp; //강사 전화번호	
	private String lec_start_date; //강의 시작일
	private String lec_end_date; // 강의 종료일
	private int lec_days; //과정일수
	private int app_cnt; // 신청인원
	private int capacity; //정원
	private String cls_room; //강의실
	private String lec_goal; //수업목표
	private String lec_yn; // 종료여부
	private String svy_cd; //설문코드
	private String lec_status; // 수강상태 (sql에서 작성)

	public String getIns_email() {
		return ins_email;
	}
	public void setIns_email(String ins_email) {
		this.ins_email = ins_email;
	}
	public String getIns_hp() {
		return ins_hp;
	}
	public void setIns_hp(String ins_hp) {
		this.ins_hp = ins_hp;
	}

	public String getLec_status() {
		return lec_status;
	}
	public void setLec_status(String lec_status) {
		this.lec_status = lec_status;
	}
	public String getIns_nm() {
		return ins_nm;
	}
	public void setIns_nm(String ins_nm) {
		this.ins_nm = ins_nm;
	}
	public int getLec_cd() {
		return lec_cd;
	}
	public void setLec_cd(int lec_cd) {
		this.lec_cd = lec_cd;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getApp_yn() {
		return app_yn;
	}
	public void setApp_yn(String app_yn) {
		this.app_yn = app_yn;
	}
	public String getEnd_yn() {
		return end_yn;
	}
	public void setEnd_yn(String end_yn) {
		this.end_yn = end_yn;
	}
	public String getLec_nm() {
		return lec_nm;
	}
	public void setLec_nm(String lec_nm) {
		this.lec_nm = lec_nm;
	}
	public String getLec_ctg() {
		return lec_ctg;
	}
	public void setLec_ctg(String lec_ctg) {
		this.lec_ctg = lec_ctg;
	}
	public String getIns_id() {
		return ins_id;
	}
	public void setIns_id(String ins_id) {
		this.ins_id = ins_id;
	}
	public String getLec_start_date() {
		return lec_start_date;
	}
	public void setLec_start_date(String lec_start_date) {
		this.lec_start_date = lec_start_date;
	}
	public String getLec_end_date() {
		return lec_end_date;
	}
	public void setLec_end_date(String lec_end_date) {
		this.lec_end_date = lec_end_date;
	}
	public int getLec_days() {
		return lec_days;
	}
	public void setLec_days(int lec_days) {
		this.lec_days = lec_days;
	}
	public int getApp_cnt() {
		return app_cnt;
	}
	public void setApp_cnt(int app_cnt) {
		this.app_cnt = app_cnt;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getCls_room() {
		return cls_room;
	}
	public void setCls_room(String cls_room) {
		this.cls_room = cls_room;
	}
	public String getLec_goal() {
		return lec_goal;
	}
	public void setLec_goal(String lec_goal) {
		this.lec_goal = lec_goal;
	}
	public String getLec_yn() {
		return lec_yn;
	}
	public void setLec_yn(String lec_yn) {
		this.lec_yn = lec_yn;
	}
	public String getSvy_cd() {
		return svy_cd;
	}
	public void setSvy_cd(String svy_cd) {
		this.svy_cd = svy_cd;
	}

}
