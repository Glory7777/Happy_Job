package kr.happyjob.study.facadm.model;

public class RoomDtlModel {
	private int cls_room_cd;
	private String cls_room_nm;
	private int equ_cd;
	private String equ_nm;
	private int use_cnt;
	private String etc;	
	private int equ_able_cnt;
	
	public int getCls_room_cd() {
		return cls_room_cd;
	}
	public void setCls_room_cd(int cls_room_cd) {
		this.cls_room_cd = cls_room_cd;
	}
	public String getCls_room_nm() {
		return cls_room_nm;
	}
	public void setCls_room_nm(String cls_room_nm) {
		this.cls_room_nm = cls_room_nm;
	}
	public int getEqu_cd() {
		return equ_cd;
	}
	public void setEqu_cd(int equ_cd) {
		this.equ_cd = equ_cd;
	}
	public String getEqu_nm() {
		return equ_nm;
	}
	public void setEqu_nm(String equ_nm) {
		this.equ_nm = equ_nm;
	}
	public int getUse_cnt() {
		return use_cnt;
	}
	public void setUse_cnt(int use_cnt) {
		this.use_cnt = use_cnt;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public int getEqu_able_cnt() {
		return equ_able_cnt;
	}
	public void setEqu_able_cnt(int equ_able_cnt) {
		this.equ_able_cnt = equ_able_cnt;
	}

}
