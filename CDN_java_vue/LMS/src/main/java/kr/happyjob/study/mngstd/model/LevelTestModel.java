package kr.happyjob.study.mngstd.model;

public class LevelTestModel {

   
   private int lec_cd;               //강의목록
   private String lec_nm;             //과목
   private String lec_ctg;            //분류
   private String loginID;            //내 id
   private String lec_start_date;      //강의시작일
   private String lec_end_date;      //강의종료일
   private String lec_yn;            //종료여부

   private int test_cd;            //시험코드
   private int test_que_cd;         //문제코드
   private int sm_ans;               //제출답
   private  String cor_yn;            //정답여부
   private int score;               //점수
   private String test_nm;            //시험명
   
   private String test_start_date;      //시험시작일
   private String test_end_date;      //시험종료일
   
   private String test_state;		 //시험응시상태
   private String test_sm_date;		 //시험응시일
   
   
	private int test_que_type;		//문제타입
	private String que_type_nm;		//문제타입병

	private String test_que_ctt;	//문제내용
	private String test_opt_1;		//보기1
	private String test_opt_2;		//보기2
	private String test_opt_3;		//보기3
	private String test_opt_4;		//보기4	
	private int test_cor_ans;		//답
	private int test_paper_nm;		//시험자명		
   
	
	
	public int getTest_que_type() {
		return test_que_type;
	}
	public void setTest_que_type(int test_que_type) {
		this.test_que_type = test_que_type;
	}
	public String getQue_type_nm() {
		return que_type_nm;
	}
	public void setQue_type_nm(String que_type_nm) {
		this.que_type_nm = que_type_nm;
	}
	public String getTest_que_ctt() {
		return test_que_ctt;
	}
	public void setTest_que_ctt(String test_que_ctt) {
		this.test_que_ctt = test_que_ctt;
	}
	public String getTest_opt_1() {
		return test_opt_1;
	}
	public void setTest_opt_1(String test_opt_1) {
		this.test_opt_1 = test_opt_1;
	}
	public String getTest_opt_2() {
		return test_opt_2;
	}
	public void setTest_opt_2(String test_opt_2) {
		this.test_opt_2 = test_opt_2;
	}
	public String getTest_opt_3() {
		return test_opt_3;
	}
	public void setTest_opt_3(String test_opt_3) {
		this.test_opt_3 = test_opt_3;
	}
	public String getTest_opt_4() {
		return test_opt_4;
	}
	public void setTest_opt_4(String test_opt_4) {
		this.test_opt_4 = test_opt_4;
	}
	public int getTest_cor_ans() {
		return test_cor_ans;
	}
	public void setTest_cor_ans(int test_cor_ans) {
		this.test_cor_ans = test_cor_ans;
	}
	public int getTest_paper_nm() {
		return test_paper_nm;
	}
	public void setTest_paper_nm(int test_paper_nm) {
		this.test_paper_nm = test_paper_nm;
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

   
   public String getTest_nm() {
      return test_nm;
   }
   public void setTest_nm(String test_nm) {
      this.test_nm = test_nm;
   }
   
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
   public String getLec_yn() {
      return lec_yn;
   }
   public void setLec_yn(String lec_yn) {
      this.lec_yn = lec_yn;
   }
   public int getTest_cd() {
      return test_cd;
   }
   public void setTest_cd(int test_cd) {
      this.test_cd = test_cd;
   }
   public int getTest_que_cd() {
      return test_que_cd;
   }
   public void setTest_que_cd(int test_que_cd) {
      this.test_que_cd = test_que_cd;
   }
   public int getSm_ans() {
      return sm_ans;
   }
   public void setSm_ans(int sm_ans) {
      this.sm_ans = sm_ans;
   }
   public String getCor_yn() {
      return cor_yn;
   }
   public void setCor_yn(String cor_yn) {
      this.cor_yn = cor_yn;
   }
   public int getScore() {
      return score;
   }
   public void setScore(int score) {
      this.score = score;
   }

   
   
}