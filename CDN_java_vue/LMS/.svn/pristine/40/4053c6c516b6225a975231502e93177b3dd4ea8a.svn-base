-- 강의계획
CREATE TABLE `tb_lec_week` (
	`lec_cd`      INT           NOT NULL COMMENT '강의코드', -- 강의코드
	`weekly_no`   VARCHAR(20)   NOT NULL COMMENT '주차수', -- 주차수
	`week_goal`   VARCHAR(1000) NULL     COMMENT '학습목표', -- 학습목표
	`week_ctt`    VARCHAR(4000) NULL     COMMENT '학습내용', -- 학습내용
	`lec_file_no` INT           NULL     COMMENT '등록번호' -- 등록번호
)
COMMENT '강의계획';

-- 강의계획
ALTER TABLE `tb_lec_week`
	ADD CONSTRAINT `PK_tb_lec_week` -- 강의계획 기본키
		PRIMARY KEY (
			`lec_cd`,    -- 강의코드
			`weekly_no`  -- 주차수
		);

-- 강의목록
CREATE TABLE `tb_lec` (
	`lec_cd`         INT           NOT NULL COMMENT '강의코드', -- 강의코드
	`lec_nm`         VARCHAR(30)   NULL     COMMENT '과목', -- 과목
	`lec_ctg`        VARCHAR(5)    NULL     COMMENT '분류', -- 분류
	`loginID`        VARCHAR(50)   NULL     COMMENT '강사ID', -- 강사ID
	`lec_start_date` VARCHAR(20)   NULL     COMMENT '강의시작일', -- 강의시작일
	`lec_end_date`   VARCHAR(20)   NULL     COMMENT '강의종료일', -- 강의종료일
	`lec_days`       INT           NULL     COMMENT '과정일수', -- 과정일수
	`app_cnt`        INT           NULL     COMMENT '신청인원', -- 신청인원
	`capacity`       INT           NULL     COMMENT '정원', -- 정원
	`cls_room`       VARCHAR(10)   NULL     COMMENT '강의실', -- 강의실
	`lec_goal`       VARCHAR(4000) NULL     COMMENT '수업목표', -- 수업목표
	`lec_yn`         VARCHAR(1)    NULL     COMMENT '종료여부', -- 종료여부
	`svy_cd`         VARCHAR(10)   NULL     COMMENT '설문코드' -- 설문코드
)
COMMENT '강의목록';

-- 강의목록
ALTER TABLE `tb_lec`
	ADD CONSTRAINT `PK_tb_lec` -- 강의목록 기본키
		PRIMARY KEY (
			`lec_cd` -- 강의코드
		);

-- 강의실
CREATE TABLE `tb_cls_room` (
	`cls_room_cd`     INT           NOT NULL COMMENT '강의실 코드', -- 강의실 코드
	`cls_room_nm`     VARCHAR(20)   NULL     COMMENT '강의실명', -- 강의실명
	`cls_room_size`   INT           NULL     COMMENT '강의실크기', -- 강의실크기
	`cls_room_seat`   INT           NULL     COMMENT '자리수', -- 자리수
	`cls_room_etc`    VARCHAR(4000) NULL     COMMENT '비고', -- 비고
	`cls_room_use_yn` VARCHAR(1)    NULL     COMMENT '사용여부' -- 사용여부
)
COMMENT '강의실';

-- 강의실
ALTER TABLE `tb_cls_room`
	ADD CONSTRAINT `PK_tb_cls_room` -- 강의실 기본키
		PRIMARY KEY (
			`cls_room_cd` -- 강의실 코드
		);

-- 강의실-장비
CREATE TABLE `tb_cls_room_equ` (
	`cls_room_cd` INT           NOT NULL COMMENT '강의실 코드', -- 강의실 코드
	`equ_cd`      INT           NOT NULL COMMENT '장비코드', -- 장비코드
	`use_cnt`     INT           NULL     COMMENT '사용갯수', -- 사용갯수
	`etc`         VARCHAR(4000) NULL     COMMENT '비고' -- 비고
)
COMMENT '강의실-장비';

-- 강의실-장비
ALTER TABLE `tb_cls_room_equ`
	ADD CONSTRAINT `PK_tb_cls_room_equ` -- 강의실-장비 기본키
		PRIMARY KEY (
			`cls_room_cd`, -- 강의실 코드
			`equ_cd`       -- 장비코드
		);

-- 객관식답변테이블
CREATE TABLE `tb_opt_ans` (
	`lec_cd`     INT NOT NULL COMMENT '강의코드', -- 강의코드
	`svy_que_no` INT NOT NULL COMMENT '질문번호', -- 질문번호
	`svy_opt_no` INT NOT NULL COMMENT '보기번호', -- 보기번호
	`ans_cnt`    INT NULL     DEFAULT 0 COMMENT '응답갯수' -- 응답갯수
)
COMMENT '객관식답변테이블';

-- 객관식답변테이블
ALTER TABLE `tb_opt_ans`
	ADD CONSTRAINT `PK_tb_opt_ans` -- 객관식답변테이블 기본키
		PRIMARY KEY (
			`lec_cd`,     -- 강의코드
			`svy_que_no`, -- 질문번호
			`svy_opt_no`  -- 보기번호
		);

-- 객관식보기
CREATE TABLE `tb_svy_option` (
	`svy_que_no`  INT           NOT NULL COMMENT '질문번호', -- 질문번호
	`svy_opt_no`  INT           NOT NULL COMMENT '보기번호', -- 보기번호
	`svy_opt_ctt` VARCHAR(1000) NULL     COMMENT '보기내용' -- 보기내용
)
COMMENT '객관식보기';

-- 객관식보기
ALTER TABLE `tb_svy_option`
	ADD CONSTRAINT `PK_tb_svy_option` -- 객관식보기 기본키
		PRIMARY KEY (
			`svy_que_no`, -- 질문번호
			`svy_opt_no`  -- 보기번호
		);

-- 게시글
CREATE TABLE `tb_board` (
	`brd_no`        INT           NOT NULL COMMENT '글 번호', -- 글 번호
	`brd_title`     VARCHAR(100)  NULL     COMMENT '제목', -- 제목
	`brd_ctt`       VARCHAR(4000) NULL     COMMENT '내용', -- 내용
	`brd_wt`        VARCHAR(50)   NULL     COMMENT '작성자', -- 작성자
	`loginID`       VARCHAR(50)   NULL     COMMENT '작성자ID', -- 작성자ID
	`brd_reg_date`  VARCHAR(15)   NULL     COMMENT '등록일', -- 등록일
	`brd_veiws_cnt` INT           NULL     COMMENT '조회수', -- 조회수
	`brd_delete_yn` VARCHAR(1)    NULL     COMMENT '삭제여부', -- 삭제여부
	`ctg_cd`        INT           NULL     COMMENT '분류코드', -- 분류코드
	`ans_yn`        VARCHAR(1)    NULL     COMMENT '답변유무' -- 답변유무
)
COMMENT '게시글';

-- 게시글
ALTER TABLE `tb_board`
	ADD CONSTRAINT `PK_tb_board` -- 게시글 기본키
		PRIMARY KEY (
			`brd_no` -- 글 번호
		);

-- 게시글분류
CREATE TABLE `tb_brd_ctg` (
	`ctg_cd` INT         NOT NULL COMMENT '분류코드', -- 분류코드
	`ctg_nm` VARCHAR(10) NULL     COMMENT '분류명' -- 분류명
)
COMMENT '게시글분류';

-- 게시글분류
ALTER TABLE `tb_brd_ctg`
	ADD CONSTRAINT `PK_tb_brd_ctg` -- 게시글분류 기본키
		PRIMARY KEY (
			`ctg_cd` -- 분류코드
		);

-- 공통코드
CREATE TABLE `tb_group_code` (
	`group_code`    VARCHAR(20)   NOT NULL COMMENT '그룹코드', -- 그룹코드
	`group_name`    VARCHAR(200)  NULL     COMMENT '그룹코드명', -- 그룹코드명
	`note`          VARCHAR(2000) NULL     COMMENT '주석', -- 주석
	`use_yn`        VARCHAR(10)   NULL     COMMENT '사용여부', -- 사용여부
	`regId`         VARCHAR(20)   NULL     COMMENT '등록자', -- 등록자
	`reg_date`      DATETIME      NULL     COMMENT '등록일', -- 등록일
	`updateId`      VARCHAR(20)   NULL     COMMENT '수정자', -- 수정자
	`update_date`   DATETIME      NULL     COMMENT '수정일', -- 수정일
	`g_temp_field1` VARCHAR(20)   NULL     COMMENT '임시필드1', -- 임시필드1
	`g_temp_field2` VARCHAR(20)   NULL     COMMENT '임시필드2', -- 임시필드2
	`g_temp_field3` VARCHAR(20)   NULL     COMMENT '입시필드3' -- 입시필드3
)
COMMENT '공통코드';

-- 공통코드
ALTER TABLE `tb_group_code`
	ADD CONSTRAINT `PK_tb_group_code` -- 공통코드 기본키
		PRIMARY KEY (
			`group_code` -- 그룹코드
		);

-- 과제
CREATE TABLE `tb_hwk` (
	`lec_cd`         INT           NOT NULL COMMENT '강의코드', -- 강의코드
	`hwk_no`         INT           NOT NULL COMMENT '과제번호', -- 과제번호
	`hwk_nm`         VARCHAR(100)  NULL     COMMENT '과제명', -- 과제명
	`hwk_ctt`        VARCHAR(4000) NULL     COMMENT '과제내용', -- 과제내용
	`hwk_start_date` VARCHAR(20)   NULL     COMMENT '시작일', -- 시작일
	`hwk_end_date`   VARCHAR(20)   NULL     COMMENT '종료일', -- 종료일
	`hwk_file_no`    INT           NULL     COMMENT '파일번호' -- 파일번호
)
COMMENT '과제';

-- 과제
ALTER TABLE `tb_hwk`
	ADD CONSTRAINT `PK_tb_hwk` -- 과제 기본키
		PRIMARY KEY (
			`lec_cd`, -- 강의코드
			`hwk_no`  -- 과제번호
		);

-- 과제제출
CREATE TABLE `tb_hwk_sm` (
	`lec_cd`     INT           NOT NULL COMMENT '강의코드', -- 강의코드
	`hwk_no`     INT           NOT NULL COMMENT '과제번호', -- 과제번호
	`loginID`    VARCHAR(50)   NOT NULL COMMENT '학생ID', -- 학생ID
	`sm_file_no` INT           NULL     COMMENT '파일번호', -- 파일번호
	`sm_date`    VARCHAR(20)   NULL     COMMENT '제출일', -- 제출일
	`sm_ctt`     VARCHAR(4000) NULL     COMMENT '내용' -- 내용
)
COMMENT '과제제출';

-- 과제제출
ALTER TABLE `tb_hwk_sm`
	ADD CONSTRAINT `PK_tb_hwk_sm` -- 과제제출 기본키
		PRIMARY KEY (
			`lec_cd`,  -- 강의코드
			`hwk_no`,  -- 과제번호
			`loginID`  -- 학생ID
		);

-- 과제제출파일
CREATE TABLE `tb_sm_file` (
	`sm_file_no`      INT          NOT NULL COMMENT '파일번호', -- 파일번호
	`sm_file_path`    VARCHAR(500) NULL     COMMENT '파일경로', -- 파일경로
	`sm_file_nm`      VARCHAR(100) NULL     COMMENT '파일명', -- 파일명
	`sm_file_uuid_nm` VARCHAR(100) NULL     COMMENT 'uuid파일명', -- uuid파일명
	`sm_file_size`    INT          NULL     COMMENT '파일사이즈', -- 파일사이즈
	`sm_file_extend`  VARCHAR(10)  NULL     COMMENT '파일확장자', -- 파일확장자
	`sm_file_logical` VARCHAR(200) NULL     COMMENT '논리경로' -- 논리경로
)
COMMENT '과제제출파일';

-- 과제제출파일
ALTER TABLE `tb_sm_file`
	ADD CONSTRAINT `PK_tb_sm_file` -- 과제제출파일 기본키
		PRIMARY KEY (
			`sm_file_no` -- 파일번호
		);

-- 과제파일
CREATE TABLE `tb_hwk_file` (
	`hwk_file_no` INT          NOT NULL COMMENT '파일번호', -- 파일번호
	`hwk_path`    VARCHAR(500) NULL     COMMENT '파일경로', -- 파일경로
	`hwk_file_nm` VARCHAR(100) NULL     COMMENT '파일명', -- 파일명
	`hwk_uuid_nm` VARCHAR(100) NULL     COMMENT 'uuid파일명', -- uuid파일명
	`hwk_size`    INT          NULL     COMMENT '파일사이즈', -- 파일사이즈
	`hwk_extend`  VARCHAR(10)  NULL     COMMENT '파일확장자', -- 파일확장자
	`hwk_logical` VARCHAR(200) NULL     COMMENT '논리경로' -- 논리경로
)
COMMENT '과제파일';

-- 과제파일
ALTER TABLE `tb_hwk_file`
	ADD CONSTRAINT `PK_tb_hwk_file` -- 과제파일 기본키
		PRIMARY KEY (
			`hwk_file_no` -- 파일번호
		);

-- 답변여부
CREATE TABLE `tb_ans_yn` (
	`brd_no` INT        NOT NULL COMMENT '글 번호', -- 글 번호
	`ans_yn` VARCHAR(1) NULL     COMMENT '답변유무' -- 답변유무
)
COMMENT '답변여부';

-- 답변여부
ALTER TABLE `tb_ans_yn`
	ADD CONSTRAINT `PK_tb_ans_yn` -- 답변여부 기본키
		PRIMARY KEY (
			`brd_no` -- 글 번호
		);

-- 댓글
CREATE TABLE `tb_reply` (
	`brd_no`    INT          NOT NULL COMMENT '글 번호', -- 글 번호
	`reply_no`  INT          NOT NULL COMMENT '댓글번호', -- 댓글번호
	`loginID`   VARCHAR(50)  NOT NULL COMMENT '사용자ID', -- 사용자ID
	`reply_ctt` VARCHAR(200) NULL     COMMENT '댓글내용', -- 댓글내용
	`reg_date`  VARCHAR(20)  NULL     COMMENT '등록일자' -- 등록일자
)
COMMENT '댓글';

-- 댓글
ALTER TABLE `tb_reply`
	ADD CONSTRAINT `PK_tb_reply` -- 댓글 기본키
		PRIMARY KEY (
			`brd_no`,   -- 글 번호
			`reply_no`  -- 댓글번호
		);

-- 메뉴권한
CREATE TABLE `tn_usr_mnu_atrt` (
	`user_type` VARCHAR(1) NOT NULL COMMENT '사용자타입', -- 사용자타입
	`MNU_ID`    VARCHAR(5) NOT NULL COMMENT '메뉴ID' -- 메뉴ID
)
COMMENT '메뉴권한';

-- 메뉴권한
ALTER TABLE `tn_usr_mnu_atrt`
	ADD CONSTRAINT `PK_tn_usr_mnu_atrt` -- 메뉴권한 기본키
		PRIMARY KEY (
			`user_type`, -- 사용자타입
			`MNU_ID`     -- 메뉴ID
		);

-- 메뉴마스터
CREATE TABLE `tm_mnu_mst` (
	`MNU_ID`      VARCHAR(5)   NOT NULL COMMENT '메뉴ID', -- 메뉴ID
	`HIR_MNU_ID`  VARCHAR(5)   NULL     COMMENT '상위메뉴ID', -- 상위메뉴ID
	`MNU_NM`      VARCHAR(100) NULL     COMMENT '메뉴명', -- 메뉴명
	`MNU_URL`     VARCHAR(500) NULL     COMMENT '메뉴 URL', -- 메뉴 URL
	`MNU_DVS_COD` VARCHAR(1)   NULL     COMMENT '메뉴 구분 코드rn* M: 관리자, rn* U: 사용자 ', -- 메뉴 구분 코드rn* M: 관리자, rn* U: 사용자 
	`GRP_NUM`     INT(11)      NULL     COMMENT '그룹번호', -- 그룹번호
	`ODR`         INT(11)      NULL     COMMENT '순서', -- 순서
	`LVL`         SMALLINT(6)  NULL     COMMENT '라벨', -- 라벨
	`MNU_ICO_COD` VARCHAR(7)   NULL     COMMENT '메뉴아이콘코드', -- 메뉴아이콘코드
	`USE_POA`     VARCHAR(1)   NULL     COMMENT '사용유무', -- 사용유무
	`DLT_POA`     VARCHAR(1)   NULL     COMMENT '삭제유무' -- 삭제유무
)
COMMENT '메뉴마스터';

-- 메뉴마스터
ALTER TABLE `tm_mnu_mst`
	ADD CONSTRAINT `PK_tm_mnu_mst` -- 메뉴마스터 기본키
		PRIMARY KEY (
			`MNU_ID` -- 메뉴ID
		);

-- 문제지
CREATE TABLE `tb_test_paper` (
	`test_cd`     VARCHAR(10) NOT NULL COMMENT '시험코드', -- 시험코드
	`test_que_cd` INT         NOT NULL COMMENT '문제코드', -- 문제코드
	`score`       INT         NULL     COMMENT '배점' -- 배점
)
COMMENT '문제지';

-- 문제지
ALTER TABLE `tb_test_paper`
	ADD CONSTRAINT `PK_tb_test_paper` -- 문제지 기본키
		PRIMARY KEY (
			`test_cd`,     -- 시험코드
			`test_que_cd`  -- 문제코드
		);

-- 문제타입
CREATE TABLE `tb_que_type` (
	`test_que_type` INT          NOT NULL COMMENT '문제타입', -- 문제타입
	`que_type_nm`   VARCHAR(100) NULL     COMMENT '문제타입명' -- 문제타입명
)
COMMENT '문제타입';

-- 문제타입
ALTER TABLE `tb_que_type`
	ADD CONSTRAINT `PK_tb_que_type` -- 문제타입 기본키
		PRIMARY KEY (
			`test_que_type` -- 문제타입
		);

-- 사용자정보
CREATE TABLE `tb_userinfo` (
	`loginID`        VARCHAR(50)   NOT NULL COMMENT '사용자ID', -- 사용자ID
	`user_type`      VARCHAR(1)    NULL     COMMENT '사용자구분', -- 사용자구분
	`name`           VARCHAR(20)   NULL     COMMENT '이름', -- 이름
	`password`       VARCHAR(100)  NULL     COMMENT '비밀번호', -- 비밀번호
	`sex`            VARCHAR(10)   NULL     COMMENT '성별', -- 성별
	`hp`             VARCHAR(15)   NULL     COMMENT '연락처', -- 연락처
	`email`          VARCHAR(100)  NULL     COMMENT '이메일', -- 이메일
	`regdate`        VARCHAR(30)   NULL     COMMENT '가입일자', -- 가입일자
	`addr`           VARCHAR(1000) NULL     COMMENT '주소', -- 주소
	`birthday`       VARCHAR(15)   NULL     COMMENT '생년월일', -- 생년월일
	`lecture`        VARCHAR(15)   NULL     COMMENT '담당반', -- 담당반
	`status_yn`      VARCHAR(1)    NULL     COMMENT '상태(승인여부)', -- 상태(승인여부)
	`secession_date` VARCHAR(30)   NULL     COMMENT '탈퇴일', -- 탈퇴일
	`secession`      VARCHAR(1)    NULL     DEFAULT 'N' COMMENT '탈퇴여부' -- 탈퇴여부
)
COMMENT '사용자정보';

-- 사용자정보
ALTER TABLE `tb_userinfo`
	ADD CONSTRAINT `PK_tb_userinfo` -- 사용자정보 기본키
		PRIMARY KEY (
			`loginID` -- 사용자ID
		);

-- 상담
CREATE TABLE `tb_consulting` (
	`lec_cd`          INT           NOT NULL COMMENT '강의코드', -- 강의코드
	`cst_no`          INT           NOT NULL COMMENT '상담번호', -- 상담번호
	`loginID`         VARCHAR(50)   NOT NULL COMMENT '학생ID', -- 학생ID
	`score`           INT           NULL     COMMENT '점수', -- 점수
	`cst_date`        VARCHAR(20)   NULL     COMMENT '상담일자', -- 상담일자
	`cls_room`        VARCHAR(10)   NULL     COMMENT '상담장소', -- 상담장소
	`cst_ctt`         VARCHAR(4000) NULL     COMMENT '상담내용', -- 상담내용
	`cst_update_date` VARCHAR(20)   NULL     COMMENT '수정일자', -- 수정일자
	`cst_yn`          VARCHAR(1)    NULL     COMMENT '상담여부', -- 상담여부
	`cst_delete_yn`   VARCHAR(1)    NULL     COMMENT '삭제여부' -- 삭제여부
)
COMMENT '상담';

-- 상담
ALTER TABLE `tb_consulting`
	ADD CONSTRAINT `PK_tb_consulting` -- 상담 기본키
		PRIMARY KEY (
			`lec_cd`,  -- 강의코드
			`cst_no`,  -- 상담번호
			`loginID`  -- 학생ID
		);

-- 상세코드
CREATE TABLE `tb_detail_code` (
	`detail_code`   VARCHAR(20)   NOT NULL COMMENT '상세코드', -- 상세코드
	`group_code`    VARCHAR(20)   NOT NULL COMMENT '그룹코드', -- 그룹코드
	`detail_name`   VARCHAR(200)  NULL     COMMENT '상세코드명', -- 상세코드명
	`note`          VARCHAR(2000) NULL     COMMENT '주석', -- 주석
	`use_yn`        VARCHAR(10)   NULL     COMMENT '사용여부', -- 사용여부
	`regId`         VARCHAR(20)   NULL     COMMENT '등록자', -- 등록자
	`reg_date`      DATETIME      NULL     COMMENT '등록일', -- 등록일
	`updateId`      VARCHAR(20)   NULL     COMMENT '수정자', -- 수정자
	`update_date`   DATETIME      NULL     COMMENT '수정일', -- 수정일
	`sequence`      INT(3)        NULL     COMMENT '순서', -- 순서
	`d_temp_field1` VARCHAR(20)   NULL     COMMENT '임시필드1', -- 임시필드1
	`d_temp_field2` VARCHAR(20)   NULL     COMMENT '임시필드2', -- 임시필드2
	`d_temp_field3` VARCHAR(20)   NULL     COMMENT '임시필드3', -- 임시필드3
	`d_temp_field4` VARCHAR(20)   NULL     COMMENT '임시필드4' -- 임시필드4
)
COMMENT '상세코드';

-- 상세코드
ALTER TABLE `tb_detail_code`
	ADD CONSTRAINT `PK_tb_detail_code` -- 상세코드 기본키
		PRIMARY KEY (
			`detail_code`, -- 상세코드
			`group_code`   -- 그룹코드
		);

-- 설문
CREATE TABLE `tb_svy` (
	`svy_cd`     INT NOT NULL COMMENT '설문코드', -- 설문코드
	`svy_que_no` INT NOT NULL COMMENT '질문번호' -- 질문번호
)
COMMENT '설문';

-- 설문
ALTER TABLE `tb_svy`
	ADD CONSTRAINT `PK_tb_svy` -- 설문 기본키
		PRIMARY KEY (
			`svy_cd`,     -- 설문코드
			`svy_que_no`  -- 질문번호
		);

-- 설문지질문
CREATE TABLE `tb_svy_question` (
	`svy_que_no`  INT           NOT NULL COMMENT '질문번호', -- 질문번호
	`svy_que_ctt` VARCHAR(4000) NULL     COMMENT '질문내용' -- 질문내용
)
COMMENT '설문지질문';

-- 설문지질문
ALTER TABLE `tb_svy_question`
	ADD CONSTRAINT `PK_tb_svy_question` -- 설문지질문 기본키
		PRIMARY KEY (
			`svy_que_no` -- 질문번호
		);

-- 설문참여유무
CREATE TABLE `tb_survey` (
	`lec_cd`  INT         NOT NULL COMMENT '강의코드', -- 강의코드
	`loginID` VARCHAR(50) NOT NULL COMMENT '학생ID' -- 학생ID
)
COMMENT '설문참여유무';

-- 설문참여유무
ALTER TABLE `tb_survey`
	ADD CONSTRAINT `PK_tb_survey` -- 설문참여유무 기본키
		PRIMARY KEY (
			`lec_cd`,  -- 강의코드
			`loginID`  -- 학생ID
		);

-- 수강목록
CREATE TABLE `tb_app_list` (
	`lec_cd`  INT         NOT NULL COMMENT '강의코드', -- 강의코드
	`loginID` VARCHAR(50) NOT NULL COMMENT '학생ID', -- 학생ID
	`app_yn`  VARCHAR(1)  NULL     COMMENT '승인여부', -- 승인여부
	`end_yn`  VARCHAR(1)  NULL     COMMENT '종강여부' -- 종강여부
)
COMMENT '수강목록';

-- 수강목록
ALTER TABLE `tb_app_list`
	ADD CONSTRAINT `PK_tb_app_list` -- 수강목록 기본키
		PRIMARY KEY (
			`lec_cd`,  -- 강의코드
			`loginID`  -- 학생ID
		);

-- 시험
CREATE TABLE `tb_test` (
	`lec_cd`          INT          NOT NULL COMMENT '강의코드', -- 강의코드
	`test_cd`         VARCHAR(10)  NOT NULL COMMENT '시험코드', -- 시험코드
	`test_nm`         VARCHAR(100) NULL     COMMENT '시험명', -- 시험명
	`test_start_date` VARCHAR(20)  NULL     COMMENT '시작일', -- 시작일
	`test_end_date`   VARCHAR(20)  NULL     COMMENT '종료일' -- 종료일
)
COMMENT '시험';

-- 시험
ALTER TABLE `tb_test`
	ADD CONSTRAINT `PK_tb_test` -- 시험 기본키
		PRIMARY KEY (
			`lec_cd`,  -- 강의코드
			`test_cd`  -- 시험코드
		);

-- 시험문제은행
CREATE TABLE `tb_test_bank` (
	`test_que_cd`   INT           NOT NULL COMMENT '문제코드', -- 문제코드
	`test_que_ctt`  VARCHAR(4000) NULL     COMMENT '문제내용', -- 문제내용
	`test_opt_1`    VARCHAR(100)  NULL     COMMENT '보기1', -- 보기1
	`test_opt_2`    VARCHAR(100)  NULL     COMMENT '보기2', -- 보기2
	`test_opt_3`    VARCHAR(100)  NULL     COMMENT '보기3', -- 보기3
	`test_opt_4`    VARCHAR(100)  NULL     COMMENT '보기4', -- 보기4
	`test_cor_ans`  INT           NULL     COMMENT '답', -- 답
	`test_que_type` INT           NULL     COMMENT '문제타입' -- 문제타입
)
COMMENT '시험문제은행';

-- 시험문제은행
ALTER TABLE `tb_test_bank`
	ADD CONSTRAINT `PK_tb_test_bank` -- 시험문제은행 기본키
		PRIMARY KEY (
			`test_que_cd` -- 문제코드
		);

-- 실업분류
CREATE TABLE `tb_job_ctg` (
	`ctg_cd` INT NOT NULL COMMENT '분류코드' -- 분류코드
)
COMMENT '실업분류';

-- 실업분류
ALTER TABLE `tb_job_ctg`
	ADD CONSTRAINT `PK_tb_job_ctg` -- 실업분류 기본키
		PRIMARY KEY (
			`ctg_cd` -- 분류코드
		);

-- 이력서
CREATE TABLE `tb_resume` (
	`loginID`   VARCHAR(50)   NOT NULL COMMENT '학생ID', -- 학생ID
	`portfolio` VARCHAR(1000) NULL     COMMENT '포트폴리오', -- 포트폴리오
	`introduce` VARCHAR(4000) NULL     COMMENT '자기소개', -- 자기소개
	`skills`    VARCHAR(4000) NULL     COMMENT '기술스택' -- 기술스택
)
COMMENT '이력서';

-- 이력서
ALTER TABLE `tb_resume`
	ADD CONSTRAINT `PK_tb_resume` -- 이력서 기본키
		PRIMARY KEY (
			`loginID` -- 학생ID
		);

-- 장비목록
CREATE TABLE `tb_equ_list` (
	`equ_cd`         INT           NOT NULL COMMENT '장비코드', -- 장비코드
	`equ_nm`         VARCHAR(100)  NULL     COMMENT '장비명', -- 장비명
	`equ_total_cnt`  INT           NULL     COMMENT '장비총갯수', -- 장비총갯수
	`equ_use_cnt`    INT           NULL     COMMENT '사용중', -- 사용중
	`equ_unable_cnt` INT           NULL     COMMENT '사용불가', -- 사용불가
	`equ_able_cnt`   INT           NULL     COMMENT '사용가능', -- 사용가능
	`equ_etc`        VARCHAR(4000) NULL     COMMENT '비고' -- 비고
)
COMMENT '장비목록';

-- 장비목록
ALTER TABLE `tb_equ_list`
	ADD CONSTRAINT `PK_tb_equ_list` -- 장비목록 기본키
		PRIMARY KEY (
			`equ_cd` -- 장비코드
		);

-- 제출답안
CREATE TABLE `tb_test_submit` (
	`lec_cd`       INT         NOT NULL COMMENT '강의코드', -- 강의코드
	`loginID`      VARCHAR(50) NOT NULL COMMENT '학생ID', -- 학생ID
	`test_cd`      VARCHAR(10) NOT NULL COMMENT '시험코드', -- 시험코드
	`score`        INT         NULL     COMMENT '점수', -- 점수
	`test_state`   VARCHAR(10) NULL     COMMENT '상태', -- 상태
	`test_sm_date` VARCHAR(20) NULL     COMMENT '응시일' -- 응시일
)
COMMENT '제출답안';

-- 제출답안
ALTER TABLE `tb_test_submit`
	ADD CONSTRAINT `PK_tb_test_submit` -- 제출답안 기본키
		PRIMARY KEY (
			`lec_cd`,  -- 강의코드
			`loginID`, -- 학생ID
			`test_cd`  -- 시험코드
		);

-- 제출답안상세
CREATE TABLE `tb_sm_ans` (
	`lec_cd`      INT         NOT NULL COMMENT '강의코드', -- 강의코드
	`loginID`     VARCHAR(50) NOT NULL COMMENT '학생ID', -- 학생ID
	`test_que_cd` INT         NOT NULL COMMENT '문제코드', -- 문제코드
	`test_cd`     VARCHAR(10) NOT NULL COMMENT '시험코드', -- 시험코드
	`sm_ans`      INT         NULL     COMMENT '제출답', -- 제출답
	`cor_yn`      VARCHAR(1)  NULL     COMMENT '정답여부', -- 정답여부
	`score`       INT         NULL     COMMENT '점수' -- 점수
)
COMMENT '제출답안상세';

-- 제출답안상세
ALTER TABLE `tb_sm_ans`
	ADD CONSTRAINT `PK_tb_sm_ans` -- 제출답안상세 기본키
		PRIMARY KEY (
			`lec_cd`,      -- 강의코드
			`loginID`,     -- 학생ID
			`test_que_cd`, -- 문제코드
			`test_cd`      -- 시험코드
		);

-- 주관식답변테이블
CREATE TABLE `tb_sub_ans` (
	`lec_cd`     INT           NOT NULL COMMENT '강의코드', -- 강의코드
	`svy_que_no` INT           NOT NULL COMMENT '질문번호', -- 질문번호
	`sub_no`     INT           NOT NULL COMMENT '주관식 답변번호', -- 주관식 답변번호
	`sub_cnt`    VARCHAR(4000) NULL     COMMENT '답변내용' -- 답변내용
)
COMMENT '주관식답변테이블';

-- 주관식답변테이블
ALTER TABLE `tb_sub_ans`
	ADD CONSTRAINT `PK_tb_sub_ans` -- 주관식답변테이블 기본키
		PRIMARY KEY (
			`lec_cd`,     -- 강의코드
			`svy_que_no`, -- 질문번호
			`sub_no`      -- 주관식 답변번호
		);

-- 주차수
CREATE TABLE `tb_weekly` (
	`weekly_no` VARCHAR(20) NOT NULL COMMENT '주차수', -- 주차수
	`weekly_nm` VARCHAR(20) NULL     COMMENT '주차수명' -- 주차수명
)
COMMENT '주차수';

-- 주차수
ALTER TABLE `tb_weekly`
	ADD CONSTRAINT `PK_tb_weekly` -- 주차수 기본키
		PRIMARY KEY (
			`weekly_no` -- 주차수
		);

-- 취업관리
CREATE TABLE `tb_job_mng` (
	`loginID`    VARCHAR(50)  NOT NULL COMMENT '학생ID', -- 학생ID
	`join_date`  VARCHAR(20)  NULL     COMMENT '입사일', -- 입사일
	`leave_date` VARCHAR(20)  NULL     COMMENT '퇴사일', -- 퇴사일
	`com_nm`     VARCHAR(100) NULL     COMMENT '업체명', -- 업체명
	`job_ctg`    VARCHAR(10)  NULL     COMMENT '재직분류', -- 재직분류
	`reg_yn`     VARCHAR(1)   NULL     COMMENT '등록여부' -- 등록여부
)
COMMENT '취업관리';

-- 취업관리
ALTER TABLE `tb_job_mng`
	ADD CONSTRAINT `PK_tb_job_mng` -- 취업관리 기본키
		PRIMARY KEY (
			`loginID` -- 학생ID
		);

-- 학생실업분류
CREATE TABLE `tb_std_job` (
	`loginID` VARCHAR(50) NOT NULL COMMENT '학생ID', -- 학생ID
	`ctg_nm`  VARCHAR(10) NULL     COMMENT '분류명' -- 분류명
)
COMMENT '학생실업분류';

-- 학생실업분류
ALTER TABLE `tb_std_job`
	ADD CONSTRAINT `PK_tb_std_job` -- 학생실업분류 기본키
		PRIMARY KEY (
			`loginID` -- 학생ID
		);

-- 학습자료
CREATE TABLE `tb_lec_file` (
	`lec_file_no`          INT          NOT NULL COMMENT '등록번호', -- 등록번호
	`lec_file_upload_date` VARCHAR(20)  NULL     COMMENT '등록일자', -- 등록일자
	`lec_file_ctt`         VARCHAR(500) NULL     COMMENT '자료내용', -- 자료내용
	`lec_file_path`        VARCHAR(500) NULL     COMMENT '파일경로', -- 파일경로
	`lec_file_nm`          VARCHAR(100) NULL     COMMENT '파일명', -- 파일명
	`lec_file_uuid_nm`     VARCHAR(100) NULL     COMMENT 'uuid파일명', -- uuid파일명
	`lec_file_size`        INT          NULL     COMMENT '파일사이즈', -- 파일사이즈
	`lec_file_extend`      VARCHAR(10)  NULL     COMMENT '파일확장자', -- 파일확장자
	`lec_file_logical`     VARCHAR(200) NULL     COMMENT '논리경로' -- 논리경로
)
COMMENT '학습자료';

-- 학습자료
ALTER TABLE `tb_lec_file`
	ADD CONSTRAINT `PK_tb_lec_file` -- 학습자료 기본키
		PRIMARY KEY (
			`lec_file_no` -- 등록번호
		);

-- 시험정보
CREATE TABLE `tb_testinfo` (
	`test_cd`       VARCHAR(10)  NOT NULL COMMENT '시험코드', -- 시험코드
	`test_paper_nm` VARCHAR(100) NULL     COMMENT '시험지명' -- 시험지명
)
COMMENT '시험정보';

-- 시험정보
ALTER TABLE `tb_testinfo`
	ADD CONSTRAINT `PK_tb_testinfo` -- 시험정보 기본키
		PRIMARY KEY (
			`test_cd` -- 시험코드
		);

-- 강의계획
ALTER TABLE `tb_lec_week`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_lec_week` -- 강의목록 -> 강의계획
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 강의계획
ALTER TABLE `tb_lec_week`
	ADD CONSTRAINT `FK_tb_weekly_TO_tb_lec_week` -- 주차수 -> 강의계획
		FOREIGN KEY (
			`weekly_no` -- 주차수
		)
		REFERENCES `tb_weekly` ( -- 주차수
			`weekly_no` -- 주차수
		);

-- 강의계획
ALTER TABLE `tb_lec_week`
	ADD CONSTRAINT `FK_tb_lec_file_TO_tb_lec_week` -- 학습자료 -> 강의계획
		FOREIGN KEY (
			`lec_file_no` -- 등록번호
		)
		REFERENCES `tb_lec_file` ( -- 학습자료
			`lec_file_no` -- 등록번호
		);

-- 강의실-장비
ALTER TABLE `tb_cls_room_equ`
	ADD CONSTRAINT `FK_tb_cls_room_TO_tb_cls_room_equ` -- 강의실 -> 강의실-장비
		FOREIGN KEY (
			`cls_room_cd` -- 강의실 코드
		)
		REFERENCES `tb_cls_room` ( -- 강의실
			`cls_room_cd` -- 강의실 코드
		);

-- 강의실-장비
ALTER TABLE `tb_cls_room_equ`
	ADD CONSTRAINT `FK_tb_equ_list_TO_tb_cls_room_equ` -- 장비목록 -> 강의실-장비
		FOREIGN KEY (
			`equ_cd` -- 장비코드
		)
		REFERENCES `tb_equ_list` ( -- 장비목록
			`equ_cd` -- 장비코드
		);

-- 객관식답변테이블
ALTER TABLE `tb_opt_ans`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_opt_ans` -- 강의목록 -> 객관식답변테이블
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 객관식답변테이블
ALTER TABLE `tb_opt_ans`
	ADD CONSTRAINT `FK_tb_svy_option_TO_tb_opt_ans` -- 객관식보기 -> 객관식답변테이블
		FOREIGN KEY (
			`svy_que_no`, -- 질문번호
			`svy_opt_no`  -- 보기번호
		)
		REFERENCES `tb_svy_option` ( -- 객관식보기
			`svy_que_no`, -- 질문번호
			`svy_opt_no`  -- 보기번호
		);

-- 객관식보기
ALTER TABLE `tb_svy_option`
	ADD CONSTRAINT `FK_tb_svy_question_TO_tb_svy_option` -- 설문지질문 -> 객관식보기
		FOREIGN KEY (
			`svy_que_no` -- 질문번호
		)
		REFERENCES `tb_svy_question` ( -- 설문지질문
			`svy_que_no` -- 질문번호
		);

-- 게시글
ALTER TABLE `tb_board`
	ADD CONSTRAINT `FK_tb_brd_ctg_TO_tb_board` -- 게시글분류 -> 게시글
		FOREIGN KEY (
			`ctg_cd` -- 분류코드
		)
		REFERENCES `tb_brd_ctg` ( -- 게시글분류
			`ctg_cd` -- 분류코드
		);

-- 과제
ALTER TABLE `tb_hwk`
	ADD CONSTRAINT `FK_tb_hwk_file_TO_tb_hwk` -- 과제파일 -> 과제
		FOREIGN KEY (
			`hwk_file_no` -- 파일번호
		)
		REFERENCES `tb_hwk_file` ( -- 과제파일
			`hwk_file_no` -- 파일번호
		);

-- 과제
ALTER TABLE `tb_hwk`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_hwk` -- 강의목록 -> 과제
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 과제제출
ALTER TABLE `tb_hwk_sm`
	ADD CONSTRAINT `FK_tb_hwk_TO_tb_hwk_sm` -- 과제 -> 과제제출
		FOREIGN KEY (
			`lec_cd`, -- 강의코드
			`hwk_no`  -- 과제번호
		)
		REFERENCES `tb_hwk` ( -- 과제
			`lec_cd`, -- 강의코드
			`hwk_no`  -- 과제번호
		);

-- 과제제출
ALTER TABLE `tb_hwk_sm`
	ADD CONSTRAINT `FK_tb_sm_file_TO_tb_hwk_sm` -- 과제제출파일 -> 과제제출
		FOREIGN KEY (
			`sm_file_no` -- 파일번호
		)
		REFERENCES `tb_sm_file` ( -- 과제제출파일
			`sm_file_no` -- 파일번호
		);

-- 과제제출
ALTER TABLE `tb_hwk_sm`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_hwk_sm` -- 강의목록 -> 과제제출
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 답변여부
ALTER TABLE `tb_ans_yn`
	ADD CONSTRAINT `FK_tb_board_TO_tb_ans_yn` -- 게시글 -> 답변여부
		FOREIGN KEY (
			`brd_no` -- 글 번호
		)
		REFERENCES `tb_board` ( -- 게시글
			`brd_no` -- 글 번호
		);

-- 댓글
ALTER TABLE `tb_reply`
	ADD CONSTRAINT `FK_tb_board_TO_tb_reply` -- 게시글 -> 댓글
		FOREIGN KEY (
			`brd_no` -- 글 번호
		)
		REFERENCES `tb_board` ( -- 게시글
			`brd_no` -- 글 번호
		);

-- 메뉴권한
ALTER TABLE `tn_usr_mnu_atrt`
	ADD CONSTRAINT `FK_tm_mnu_mst_TO_tn_usr_mnu_atrt` -- 메뉴마스터 -> 메뉴권한
		FOREIGN KEY (
			`MNU_ID` -- 메뉴ID
		)
		REFERENCES `tm_mnu_mst` ( -- 메뉴마스터
			`MNU_ID` -- 메뉴ID
		);

-- 문제지
ALTER TABLE `tb_test_paper`
	ADD CONSTRAINT `FK_tb_test_bank_TO_tb_test_paper` -- 시험문제은행 -> 문제지
		FOREIGN KEY (
			`test_que_cd` -- 문제코드
		)
		REFERENCES `tb_test_bank` ( -- 시험문제은행
			`test_que_cd` -- 문제코드
		);

-- 문제지
ALTER TABLE `tb_test_paper`
	ADD CONSTRAINT `FK_tb_testinfo_TO_tb_test_paper` -- 시험정보 -> 문제지
		FOREIGN KEY (
			`test_cd` -- 시험코드
		)
		REFERENCES `tb_testinfo` ( -- 시험정보
			`test_cd` -- 시험코드
		);

-- 상담
ALTER TABLE `tb_consulting`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_consulting` -- 강의목록 -> 상담
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 상담
ALTER TABLE `tb_consulting`
	ADD CONSTRAINT `FK_tb_userinfo_TO_tb_consulting` -- 사용자정보 -> 상담
		FOREIGN KEY (
			`loginID` -- 학생ID
		)
		REFERENCES `tb_userinfo` ( -- 사용자정보
			`loginID` -- 사용자ID
		);

-- 상세코드
ALTER TABLE `tb_detail_code`
	ADD CONSTRAINT `FK_tb_group_code_TO_tb_detail_code` -- 공통코드 -> 상세코드
		FOREIGN KEY (
			`group_code` -- 그룹코드
		)
		REFERENCES `tb_group_code` ( -- 공통코드
			`group_code` -- 그룹코드
		);

-- 설문
ALTER TABLE `tb_svy`
	ADD CONSTRAINT `FK_tb_svy_question_TO_tb_svy` -- 설문지질문 -> 설문
		FOREIGN KEY (
			`svy_que_no` -- 질문번호
		)
		REFERENCES `tb_svy_question` ( -- 설문지질문
			`svy_que_no` -- 질문번호
		);

-- 설문참여유무
ALTER TABLE `tb_survey`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_survey` -- 강의목록 -> 설문참여유무
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 설문참여유무
ALTER TABLE `tb_survey`
	ADD CONSTRAINT `FK_tb_userinfo_TO_tb_survey` -- 사용자정보 -> 설문참여유무
		FOREIGN KEY (
			`loginID` -- 학생ID
		)
		REFERENCES `tb_userinfo` ( -- 사용자정보
			`loginID` -- 사용자ID
		);

-- 수강목록
ALTER TABLE `tb_app_list`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_app_list` -- 강의목록 -> 수강목록
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 수강목록
ALTER TABLE `tb_app_list`
	ADD CONSTRAINT `FK_tb_userinfo_TO_tb_app_list` -- 사용자정보 -> 수강목록
		FOREIGN KEY (
			`loginID` -- 학생ID
		)
		REFERENCES `tb_userinfo` ( -- 사용자정보
			`loginID` -- 사용자ID
		);

-- 시험
ALTER TABLE `tb_test`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_test` -- 강의목록 -> 시험
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 시험문제은행
ALTER TABLE `tb_test_bank`
	ADD CONSTRAINT `FK_tb_que_type_TO_tb_test_bank` -- 문제타입 -> 시험문제은행
		FOREIGN KEY (
			`test_que_type` -- 문제타입
		)
		REFERENCES `tb_que_type` ( -- 문제타입
			`test_que_type` -- 문제타입
		);

-- 이력서
ALTER TABLE `tb_resume`
	ADD CONSTRAINT `FK_tb_userinfo_TO_tb_resume` -- 사용자정보 -> 이력서
		FOREIGN KEY (
			`loginID` -- 학생ID
		)
		REFERENCES `tb_userinfo` ( -- 사용자정보
			`loginID` -- 사용자ID
		);

-- 제출답안
ALTER TABLE `tb_test_submit`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_test_submit` -- 강의목록 -> 제출답안
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 제출답안
ALTER TABLE `tb_test_submit`
	ADD CONSTRAINT `FK_tb_test_TO_tb_test_submit` -- 시험 -> 제출답안
		FOREIGN KEY (
			`lec_cd`,  -- 강의코드
			`test_cd`  -- 시험코드
		)
		REFERENCES `tb_test` ( -- 시험
			`lec_cd`,  -- 강의코드
			`test_cd`  -- 시험코드
		);

-- 제출답안상세
ALTER TABLE `tb_sm_ans`
	ADD CONSTRAINT `FK_tb_test_submit_TO_tb_sm_ans` -- 제출답안 -> 제출답안상세
		FOREIGN KEY (
			`lec_cd`,  -- 강의코드
			`loginID`, -- 학생ID
			`test_cd`  -- 시험코드
		)
		REFERENCES `tb_test_submit` ( -- 제출답안
			`lec_cd`,  -- 강의코드
			`loginID`, -- 학생ID
			`test_cd`  -- 시험코드
		);

-- 제출답안상세
ALTER TABLE `tb_sm_ans`
	ADD CONSTRAINT `FK_tb_test_paper_TO_tb_sm_ans` -- 문제지 -> 제출답안상세
		FOREIGN KEY (
			`test_cd`,     -- 시험코드
			`test_que_cd`  -- 문제코드
		)
		REFERENCES `tb_test_paper` ( -- 문제지
			`test_cd`,     -- 시험코드
			`test_que_cd`  -- 문제코드
		);

-- 주관식답변테이블
ALTER TABLE `tb_sub_ans`
	ADD CONSTRAINT `FK_tb_lec_TO_tb_sub_ans` -- 강의목록 -> 주관식답변테이블
		FOREIGN KEY (
			`lec_cd` -- 강의코드
		)
		REFERENCES `tb_lec` ( -- 강의목록
			`lec_cd` -- 강의코드
		);

-- 주관식답변테이블
ALTER TABLE `tb_sub_ans`
	ADD CONSTRAINT `FK_tb_svy_question_TO_tb_sub_ans` -- 설문지질문 -> 주관식답변테이블
		FOREIGN KEY (
			`svy_que_no` -- 질문번호
		)
		REFERENCES `tb_svy_question` ( -- 설문지질문
			`svy_que_no` -- 질문번호
		);

-- 취업관리
ALTER TABLE `tb_job_mng`
	ADD CONSTRAINT `FK_tb_userinfo_TO_tb_job_mng` -- 사용자정보 -> 취업관리
		FOREIGN KEY (
			`loginID` -- 학생ID
		)
		REFERENCES `tb_userinfo` ( -- 사용자정보
			`loginID` -- 사용자ID
		);

-- 학생실업분류
ALTER TABLE `tb_std_job`
	ADD CONSTRAINT `FK_tb_userinfo_TO_tb_std_job` -- 사용자정보 -> 학생실업분류
		FOREIGN KEY (
			`loginID` -- 학생ID
		)
		REFERENCES `tb_userinfo` ( -- 사용자정보
			`loginID` -- 사용자ID
		);