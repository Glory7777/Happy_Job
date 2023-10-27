package kr.happyjob.study.mngins.model;

public class StuModel {
	
	
	// tb_test_submit
	private String loginId;		// 학생ID
	private int score;			// 점수
	private String test_state;	// 합격 여부
	private String test_sm_date;// 응시일
	
	// tb_userinfo
	private String name;		// 학생 이름
	
	
	
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getTest_state() {
		return test_state;
	}
	public void setTest_state(String test_state) {
		this.test_state = test_state;
	}
	public String getTest_sm_date() {
		return test_sm_date;
	}
	public void setTest_sm_date(String test_sm_date) {
		this.test_sm_date = test_sm_date;
	}
	
	
	
	
	
}
