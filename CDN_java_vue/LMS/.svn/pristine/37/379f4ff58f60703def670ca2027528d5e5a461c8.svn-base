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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngins.model.AdviceModel;
import kr.happyjob.study.mngins.service.AdviceMngService;


@Controller
@RequestMapping("/tut/")
public class AdviceMngController {
	
	@Autowired
	AdviceMngService adviceMngService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 상담 초기 화면
	 */
	@RequestMapping("advice.do")
	public String adviceMng(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".adviceMng");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".adviceMng");

		
		paramMap.put("loginid", session.getAttribute("loginId") );
		
		return "mngins/adviceMng";
	}
	
	

	/**
	 * 상담 초기 화면 Vue
	 */
	@RequestMapping("advicevue.do")
	
	public String adviceMngVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".adviceMngVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".adviceMngVue");

		
		paramMap.put("loginid", session.getAttribute("loginId") );
		
		return "mngins/adviceMngVue";
	}
	
	
	
	
	/**
	 * 상담 목록
	 */
	@RequestMapping("adviceList.do")
	public String adviceList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".adviceList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startpoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		int totalcnt = adviceMngService.totalcnt(paramMap);
		
		List<AdviceModel> adviceList = adviceMngService.adviceList(paramMap);
		
		model.addAttribute("adviceList", adviceList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".adviceList");

		return "mngins/adviceList";

	}
	
	

	/**
	 * 상담 목록 Vue
	 */
	@RequestMapping("adviceListVue.do")
	@ResponseBody
	public Map<String, Object> adviceListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".adviceListVue");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startpoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		paramMap.put("ins_id", (String)session.getAttribute("loginId") );
		
		logger.info("ins+id ::::::" + paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		int totalcnt = adviceMngService.totalcnt(paramMap);
		
		List<AdviceModel> adviceList = adviceMngService.adviceList(paramMap);
		returnmap.put("adviceList", adviceList);
		returnmap.put("totalcnt", totalcnt);
		returnmap.put("ins_id", (String)session.getAttribute("loginId"));
		
		logger.info("+ End " + className + ".adviceListVue");

		return returnmap;

	}
	
	
	


	/**
	 * 상담 내용 조회 (팝업)
	 */
	@ResponseBody
	@RequestMapping("selectAdv.do")
	public Map<String, Object> selectAdv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".selectAdv");
		logger.info("   - paramMap : " + paramMap);
		
		paramMap.put("loginid", session.getAttribute("loginId") );
		
		AdviceModel advModel = adviceMngService.selectAdv(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("advModel", advModel);
		
		logger.info("+ End " + className + ".selectAdv");
		
		return returnmap;
		
	}
	
	
//	
//	
//	
	 // 상담 신규등록, 업데이트
	 
	@ResponseBody
	@RequestMapping("saveAdv.do")
	public Map<String, Object> saveAdv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveAdv");
		logger.info("   - paramMap : " + paramMap);
		
		String action = paramMap.get("action").toString();
		String msg = "";
		
		
		if(action.equals("I")){
			// 신규 저장
			adviceMngService.insertAdv(paramMap);
			msg = "저장";
			
			
		} else if(action.equals("U")){
			//  수정 저장
			adviceMngService.updateAdv(paramMap);
			msg = "수정";
			System.out.println(paramMap);
			
		} else if(action.equals("D")){
			adviceMngService.deleteAdv(paramMap);
			msg = "삭제";
		}
		else {
			msg = "FALSE : 등록에 실패하였습니다.";
		}
		
		
		logger.info("+ End " + className + ".saveAdv");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("msg", msg);
		
		return resultMap;
	}
	
//	
//
//	/**
//	 * 학생 목록 조회
//	 */
//	@ResponseBody
//	@RequestMapping("stdList.do")
//	public List<Map> stdList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//			HttpServletResponse response, HttpSession session) throws Exception{
//		
//		logger.info("+ Start " + className + ".stdList");
//		logger.info("   - paramMap : " + paramMap);
//		
//		List<Map> stdList = adviceMngService.stdList();
//		
//		logger.info("+ End " + className + ".stdList");
//		
//		return stdList;
//		
//	}
	
	
	
}
