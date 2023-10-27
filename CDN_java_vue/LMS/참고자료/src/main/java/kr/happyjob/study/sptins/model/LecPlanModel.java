package kr.happyjob.study.sptins.model;

public class LecPlanModel {
	
	// tb_lec table
	private int lec_cd;				// 강의코드
	private String lec_nm;			// 강의명
	private String lec_ctg;			// 분류(실업자, 재직자)
	private String loginID;			// 강사ID
	private String cls_room;		// 강의실
	private String lec_goal;		// 수업목표
	
	// tb_userinfo
	private String name;			// 강사명
	private String email;			// 강사 이메일
	private String hp;				// 강사 연락처
	
	
	public int getLec_cd() {
		return lec_cd;
	}
	public void setLec_cd(int lec_cd) {
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	
	
}
