package kr.happyjob.study.scm.controller;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.cus.model.QnaModel;
import kr.happyjob.study.scm.model.AnswerModel;
import kr.happyjob.study.scm.service.AnswerService;


@Controller
@RequestMapping("/scm/")
public class AnswerController {
	
	@Autowired
	AnswerService answerService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 모든 고객 Qna 초기화면
	 */
	@RequestMapping("answer.do")
	public String answer(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qna");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".qna");

		return "scm/Answer";
	}
	
	/**
	 * 모든 Qna 목록
	 */
	@RequestMapping("answerList.do")
	public String answerList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".answerList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startpoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<AnswerModel> answerList = answerService.answerList(paramMap);
		
		int totalcnt = answerService.answerTotalCnt(paramMap);
				
		model.addAttribute("answerList", answerList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".answerList");

		return "scm/AnswerList";
	}
	
	/**
	 * Qna 한건 조회(상세보기)
	 */
	@RequestMapping("answerSelect.do")
	@ResponseBody
	public Map<String, Object> answerSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".answerSelect");
		logger.info("   - paramMap : " + paramMap);
				
		AnswerModel	sectinfo = answerService.answerSelect(paramMap);
				
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	    returnmap.put("sectinfo", sectinfo);
		
		logger.info("+ End " + className + ".answerSelect");

		return returnmap;
	}

	/**
	 * Qna 답변 저장/수정/삭제
	 */
	@RequestMapping("answerSave.do")
	@ResponseBody
	public Map<String, Object> answersave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".answerSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		
		int sqlreturn = 0;
		int updateResult = 0;
		int deleteResult = 0;
		
		// 화면에 답변이 없을 때!
		if("I".equals(action)) {
		    int insertResult = answerService.insertAnswer(paramMap);
		    updateResult = answerService.updateQnaInfo(paramMap);
		    sqlreturn = insertResult + updateResult;
		    
		 // 화면에 이미 답변이 있을때 ! 
		} else if("U".equals(action)) {
			sqlreturn = answerService.updateAnswer(paramMap);
			updateResult = answerService.updateQnaInfo(paramMap);
		}else if("D".equals(action)) {
			sqlreturn = answerService.deleteAnswer(paramMap);
			deleteResult = answerService.deleteQnaInfo(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if(sqlreturn >= 0) {
			// returnmap에 result라는 키로 SUCCESS값을 저장 
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}
		
		returnmap.put("updateResult", updateResult);
		returnmap.put("updateResult", deleteResult);
		
		logger.info("+ End " + className + ".answerSave");

		return returnmap;
	}	
	
	// ----------------------------------------------------vue---------------------------------------------- //
	/**
	 * SCM 관리자 Answer 초기화면
	 */
	@RequestMapping("answervue.do")
	public String vueAnswer(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueAnswer");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".vueAnswer");

		return "scm/vueAnswer";
	}
	
	/**
	 * 모든 Answer 목록
	 */
	@RequestMapping("answerListvue.do")
	@ResponseBody
	public Map<String, Object> vueAnswerList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueAnswerList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startpoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<AnswerModel> answerList = answerService.answerList(paramMap);
		
		int totalcnt = answerService.answerTotalCnt(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
				
		returnmap.put("answerList", answerList);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vueAnswerList");

		return returnmap;
	}

}
