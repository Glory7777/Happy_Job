package kr.happyjob.study.mngadm.model;

public class LectureModel {
	
	private String lec_cd;			// 강의 코드
	private String lec_nm;			// 강의명
	private String lec_ctg;			// 분류(실업자, 재직자) 
	private String loginID;			// 강사 ID	
	private String lec_start_date;	// 시작일
	private String lec_end_date;	// 종료일
	private int lec_days;			// 과정 일수
	private String app_cnt;			// 신청 인원수
	private String capacity;		// 정원
	private String cls_room;		// 강의실
	private String lec_goal;		// 수업목표
	private String lec_yn;			// 종료여부
	private String svy_cd;			// 설문코드
	
	// 유저테이블 조인
	private String name;			// 강사 이름 
	
	// 강의실 테이블
	private int cls_room_seat;		// 좌석수
	
	
	
	
	public String getLec_cd() {
		return lec_cd;
	}
	public void setLec_cd(String lec_cd) {
		this.lec_cd = lec_cd;
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
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
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
	public String getApp_cnt() {
		return app_cnt;
	}
	public void setApp_cnt(String app_cnt) {
		this.app_cnt = app_cnt;
	}
	public String getCapacity() {
		return capacity;
	}
	public void setCapacity(String capacity) {
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getCls_room_seat() {
		return cls_room_seat;
	}
	public void setCls_room_seat(int cls_room_seat) {
		this.cls_room_seat = cls_room_seat;
	}
	
	
	
}
