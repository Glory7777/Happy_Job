package kr.happyjob.study.mngins.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
   
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.mngins.model.GradesMngModel;
import kr.happyjob.study.mngins.model.StuModel;
import kr.happyjob.study.mngins.service.GradesMngService;

@Controller
@RequestMapping("/tut/")
public class GradesMngController {
	
	@Autowired
	GradesMngService gradesMngService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 성적 관리 초기 화면
	 */
	@RequestMapping("checkGrades.do")
	public String checkGradesMgr(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".checkGradesMgr");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".checkGradesMgr");

		return "mngins/gradesMng";
	}
	
	
	/**
	 * 성적 관리 초기 화면 Vue
	 */
	@RequestMapping("checkGradesvue.do")
	public String checkGradesvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".checkGradesvue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".checkGradesvue");

		return "mngins/gradesMngVue";
	}
	
	
	/**
	 * 성적 강의 목록
	 */
	@RequestMapping("gradesList.do")
	public String gradesList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".gradesList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));
		int startpoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		paramMap.put("loginID", session.getAttribute("loginId").toString());
		
		List<GradesMngModel> gradeList = gradesMngService.gradesList(paramMap);
		
		int totalcnt = gradesMngService.totalcnt(paramMap);
		
		model.addAttribute("gradeList", gradeList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".gradesList");

		return "mngins/gradesList";
	}
	
	
	/**
	 * 성적 강의 목록 Vue
	 */
	@ResponseBody
	@RequestMapping("gradesListVue.do")
	public Map<String, Object> gradesListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".gradesListVue");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));
		int startpoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		paramMap.put("loginID", session.getAttribute("loginId").toString());
		
		List<GradesMngModel> gradeList = gradesMngService.gradesList(paramMap);
		
		int totalcnt = gradesMngService.totalcnt(paramMap);
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("gradeList", gradeList);
		returnMap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".gradesListVue");

		return returnMap;
	}
	

	/**
	 *  학생 성적 목록
	 */
	@RequestMapping("stuList.do")
	public String stuList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".stuList");
		logger.info("   - paramMap : " + paramMap);
		
		int stuPageSize = Integer.parseInt((String) paramMap.get("stuPageSize"));
		int stuCurrentPage = Integer.parseInt((String) paramMap.get("stuCurrentPage"));
		int startpoint = ( stuCurrentPage - 1 ) * stuPageSize;
		
		paramMap.put("stuPageSize", stuPageSize);
		paramMap.put("startpoint", startpoint);
		
		int stuTotalcnt = gradesMngService.stuTotalcnt(paramMap);
		
		List<StuModel> stuList = gradesMngService.stuList(paramMap);
		
		model.addAttribute("stuList", stuList);
		model.addAttribute("stuTotalcnt", stuTotalcnt);
		
		logger.info("+ End " + className + ".stuList");

		return "mngins/stuList";
	}
	
	
	/**
	 *  학생 성적 목록 Vue
	 */
	@ResponseBody
	@RequestMapping("stuListVue.do")
	public Map<String, Object> stuListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".stuListVue");
		logger.info("   - paramMap : " + paramMap);
		
		int stuPageSize = Integer.parseInt((String) paramMap.get("stuPageSize"));
		int stuCurrentPage = Integer.parseInt((String) paramMap.get("stuCurrentPage"));
		int startpoint = ( stuCurrentPage - 1 ) * stuPageSize;
		
		paramMap.put("stuPageSize", stuPageSize);
		paramMap.put("startpoint", startpoint);
		
		int stuTotalcnt = gradesMngService.stuTotalcnt(paramMap);
		
		List<StuModel> stuList = gradesMngService.stuList(paramMap);
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("stuList", stuList);
		returnMap.put("stuTotalcnt", stuTotalcnt);
		
		logger.info("+ End " + className + ".stuListVue");

		return returnMap;
	}
	
}
