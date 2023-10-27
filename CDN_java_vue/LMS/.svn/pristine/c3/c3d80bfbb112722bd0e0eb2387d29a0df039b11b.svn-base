package kr.happyjob.study.cmtstd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.cmtstd.model.QnaModel;
import kr.happyjob.study.cmtstd.service.QnaService;


@Controller
@RequestMapping("/qanda/")
public class QnaController {
   
	private QnaService qnaservice;
   
	@Autowired
	public QnaController(QnaService service) {
		this.qnaservice = service;
	}
   
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
   
   
	//학생 시점 페이지 초기화면
	@RequestMapping("a_qanda.do")
	public String a_qanda(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
		model.addAttribute("loginid",  (String) session.getAttribute("loginId"));
      
		logger.info("+ Start " + className + ".a_qanda");
		logger.info("   - paramMap : " + paramMap);
      
		logger.info("+ End " + className + ".a_qanda");

		return "cmtstd/QnaMgr";
   }
   
   
	//학생 시점 페이지 초기화면 Vue
	@RequestMapping("a_qandavue.do")
	public String a_qandavue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
		model.addAttribute("loginid",  (String) session.getAttribute("loginId"));
      
		logger.info("+ Start " + className + ".a_qandavue");
		logger.info("   - paramMap : " + paramMap);
      
		logger.info("+ End " + className + ".a_qandavue");

		return "cmtstd/QnaMgrVue";
	}

	
	// 강사 시점 페이지 초기화면
	@RequestMapping("b_qanda.do")
	public String b_qanda(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
		logger.info("+ Start " + className + ".b_qanda");
		logger.info("   - paramMap : " + paramMap);
      
		logger.info("+ End " + className + ".b_qanda");

		return "cmtstd/QnaMgr";
	}
   
   
	// 강사 시점 페이지 초기화면 Vue
	@RequestMapping("b_qandavue.do")
	public String b_qandavue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
		logger.info("+ Start " + className + ".b_qandavue");
		logger.info("   - paramMap : " + paramMap);
      
		logger.info("+ End " + className + ".b_qandavue");

		return "cmtstd/QnaMgrVue";
	}
   
   
	//qna 전체 리스트출력 + 페이
	@RequestMapping("listqna.do")
	public String listqna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
		logger.info("+ Start " + className + ".listqna");
		logger.info("   - paramMap : " + paramMap);

		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int ctg_cd =2;  //큐앤에이 게시판은 ctg_cd =2 로 설계
		int startpoint = (currentPage - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		paramMap.put("ctg_cd", ctg_cd);
		String ans_yn= (String) paramMap.get("ans_yn");
       
		List<QnaModel> listqna = qnaservice.qnaList(paramMap);
       
		int totalcnt = qnaservice.totalqna(paramMap);  
       
		model.addAttribute("totalcnt", totalcnt);
		model.addAttribute("listqna", listqna);
		model.addAttribute("ans_yn", ans_yn);
       
		model.addAttribute("loginId",  (String) session.getAttribute("loginId"));
		model.addAttribute("userType",  (String) session.getAttribute("userType"));

		logger.info("+ End " + className + ".listqna");
       
		return "cmtstd/QnaMgrList";
	}
   
   
	//qna 전체 리스트출력 + 페이 Vue
	@ResponseBody
	@RequestMapping("listqnaVue.do")
	public Map<String, Object> listqnaVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
		logger.info("+ Start " + className + ".listqnaVue");
		logger.info("   - paramMap : " + paramMap);

		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int ctg_cd =2;  //큐앤에이 게시판은 ctg_cd =2 로 설계
		int startpoint = (currentPage - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		paramMap.put("ctg_cd", ctg_cd);
		String ans_yn= (String) paramMap.get("ans_yn");
       
		List<QnaModel> listqna = qnaservice.qnaList(paramMap);
       
		int totalcnt = qnaservice.totalqna(paramMap);  
       
		Map<String, Object> returnMap = new HashMap<>();
       
		returnMap.put("totalcnt", totalcnt);
		returnMap.put("listqna", listqna);
		returnMap.put("ans_yn", ans_yn);
		returnMap.put("loginId",  (String) session.getAttribute("loginId"));
		returnMap.put("userType",  (String) session.getAttribute("userType"));

		logger.info("+ End " + className + ".listqnaVue");
       
		return returnMap;
	}
   
   
	//단건조회
	@ResponseBody
	@RequestMapping("qnaselect.do")
	public Map<String, Object> qnaselect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
            HttpServletResponse response, HttpSession session) throws Exception {
         
		logger.info("+ Start " + className + ".qnaselect");
		logger.info("   - paramMap : " + paramMap);
      
		QnaModel sectinfo = qnaservice.qnaselect(paramMap);
      
		Map<String, Object> returnmap = new HashMap<String, Object>();
      
		returnmap.put("sectinfo", sectinfo);
      
		logger.info("+ End " + className + ".qnaselect");
      
		return returnmap;
	}

    
	//저장하기
	@ResponseBody
	@RequestMapping("qnasave.do")
	public Map<String, Object> qnasave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
            HttpServletResponse response, HttpSession session) throws Exception {
         
		logger.info("+ Start " + className + ".qnasave");
		logger.info("   - paramMap : " + paramMap);

		String action = (String) paramMap.get("action");
		paramMap.put("loginid", session.getAttribute("loginId") );
		paramMap.put("userNm", session.getAttribute("userNm") );
      
		String user= (String) paramMap.get("userType");
      
		logger.info("user::::::"+user);
      
		int sqlreturn = 0;
      
		if("I".equals(action)) {//등록의경우
			
			if("A".equals(user)) { //학생의경우
				sqlreturn = qnaservice.insertqna(paramMap);
			}else if("B".equals(user)){ //강사의경우
				sqlreturn = qnaservice.commentqna(paramMap);
			}
			
		} else if("U".equals(action)) { //수정의경우
			
			if("A".equals(user)) { //학생의경우
				sqlreturn = qnaservice.updateqna(paramMap);
			}else if("B".equals(user)){ //강사의경우
				sqlreturn = qnaservice. updatecomment(paramMap);
			}
			
		} else if("D".equals(action)) {
			sqlreturn = qnaservice.deletenotice(paramMap);
		}

		Map<String, Object> returnmap = new HashMap<String, Object>();
      
		if(sqlreturn >= 0) {
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}
      
		logger.info("+ End " + className + ".qnasave");
      
		return returnmap;
	}
    
}