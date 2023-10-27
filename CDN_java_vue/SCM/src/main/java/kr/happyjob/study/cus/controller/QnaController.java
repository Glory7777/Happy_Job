package kr.happyjob.study.cus.controller;

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
import kr.happyjob.study.cus.service.QnaService;
import kr.happyjob.study.scm.model.NoticeModel;


@Controller
@RequestMapping("/cus/")
public class QnaController {
	
	@Autowired
	QnaService qnaService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 나의 Qna 초기화면
	 */
	@RequestMapping("qna.do")
	public String qna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qna");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".qna");

		return "cus/Qna";
	}
	
	/**
	 * 나의 Qna 목록
	 */
	@RequestMapping("qnaList.do")
	public String qnaList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnaList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startpoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<QnaModel> qnaList = qnaService.qnaList(paramMap);
		
		int totalcnt = qnaService.qnaTotalCnt(paramMap);
				
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("totalcnt", totalcnt);
		model.addAttribute("loginid", session.getAttribute("loginId"));
		model.addAttribute("usernm", session.getAttribute("userNm"));
		
		logger.info("+ End " + className + ".qnaList");

		return "cus/Qnalist";
	}
	
	/**
	 * Qna 한건 조회(상세보기)
	 */
	@RequestMapping("qnaSelect.do")
	@ResponseBody
	public Map<String, Object> qnaSelect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnaSelect");
		logger.info("   - paramMap : " + paramMap);
				
		QnaModel	sectinfo = qnaService.qnaSelect(paramMap);
				
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	    returnmap.put("sectinfo", sectinfo);
		
		logger.info("   - paramMap : " + paramMap);
		logger.info("   - sectinfo : " + sectinfo);
		logger.info("+ End " + className + ".qnaSelect");

		return returnmap;
	}
	
	
	/**
	 * Qna 추가/수정/삭제
	 */
	@RequestMapping("qnaSave.do")
	@ResponseBody
	public Map<String, Object> qnasave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".qnasave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		
		int sqlreturn = 0;
		int delResult = 0;
		
		if("I".equals(action)) {
			sqlreturn = qnaService.insertQna(paramMap);
		} else if("U".equals(action)) {
			sqlreturn = qnaService.updateQna(paramMap);
		// tb_qna에서 글 삭제 시, 그 fk인 tb_answer도 삭제
		}else if("D".equals(action)) {
			sqlreturn = qnaService.deleteQna(paramMap);
			delResult = qnaService.delAnswer(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if(sqlreturn >= 0) {
			// returnmap에 result라는 키로 SUCCESS값을 저장 
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}
		
		logger.info("+ End " + className + ".qnasave");

		return returnmap;
	}
	
	// ----------------------------------------------------vue---------------------------------------------- //
	/**
	 * 나의 Qna 초기화면
	 */
	@RequestMapping("qnavue.do")
	public String vueQna(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueQna");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".vueQna");

		return "cus/vueQna";
	}
	
	/**
	 * 나의 Qna 목록
	 */
	@RequestMapping("qnaListvue.do")
	@ResponseBody
	public Map<String, Object> vueQnaList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueQnaList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startpoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<QnaModel> qnaList = qnaService.qnaList(paramMap);
		
		int totalcnt = qnaService.qnaTotalCnt(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("qnaList", qnaList);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".vueQnaList");

		return returnmap;
	}

}
