package kr.happyjob.study.mngadm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngadm.model.StdModel;
import kr.happyjob.study.mngadm.service.LecService;

@Controller
@RequestMapping("/adm/")
public class LecController {
	
	@Autowired
	LecService lecService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	
	/**
	 * 강의 관리 초기화면
	 */
	@RequestMapping("/registerListControl.do")
	public String mngLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".mngLec");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".mngLec");

		return "mngadm/mngadm";
		
	}
	
	
	/**
	 * 강의 관리 초기화면_vue
	 */
	@RequestMapping("/registerListControlvue.do")
	public String registerListControlvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".registerListControlvue");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".registerListControlvue");

		return "mngadm/mngadmvue";
		
	}
	
	
	
	
	
	
	/**
	 * 강의 관리 목록
	 */
	@RequestMapping("lecList.do")
	public String lecList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecList");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));   
		int startpoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<LectureModel> lecList = lecService.lecList(paramMap);
		
		int totalcnt = lecService.totalcnt(paramMap);
		
		// 강의 종료가 N이라면 json 형태로 변환해서 넘기기
		// 강의 종료하기 위한 리스트에 사용
		if(paramMap.get("show").toString().equals("N")){
			Gson gson = new Gson();
			
			String lecListForClose = gson.toJson(lecList);
			
			model.addAttribute("lecListForClose", lecListForClose);
		}
		
		model.addAttribute("lecList", lecList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".lecList");

		return "mngadm/lecList";
	}
	
	
	/**
	 * 강의 관리 목록_vue
	 */
	@ResponseBody
	@RequestMapping("lecListVue.do")
	public Map<String, Object> lecListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecListVue");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));   
		int startpoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<LectureModel> lecList = lecService.lecList(paramMap);
		
		int totalcnt = lecService.totalcnt(paramMap);
		
		// 강의 종료가 N이라면 json 형태로 변환해서 넘기기
		// 강의 종료하기 위한 리스트에 사용
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("lecList", lecList);
		returnMap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".lecListVue");

		return returnMap;
	}
	
	
	/** 
	 * 강의 저장하기
	 */
	@ResponseBody
	@RequestMapping("saveLec.do")
	public Map<String, Object> saveLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveLec");
		logger.info("   - paramMap : " + paramMap);
		
		String action = paramMap.get("action").toString();
		String msg = null;
		
		if(action.equals("I")){
			msg = lecService.insertLec(paramMap);
		} else if(action.equals("U")){
			msg = lecService.updateLec(paramMap);
		} else if(action.equals("D")){
			msg = lecService.deleteLec(paramMap);
		}
		
		logger.info("+ End " + className + ".saveLec");
		
		Map<String, Object> returnmap = new HashMap<>();
		
		returnmap.put("msg", msg);
		
		return returnmap;
	}
	
	/**
	 * 강의실 목록 조회
	 */
	@ResponseBody
	@RequestMapping("clsRoomList.do")
	public List<Map> clsRoomList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".clsRoomList");
		logger.info("   - paramMap : " + paramMap);
		
		List<Map> clsRoomList = lecService.clsRoomList();
		
		logger.info("+ End " + className + ".clsRoomList");
		
		return clsRoomList;
		
	}
	
	
	/**
	 * 강사 목록 조회
	 */
	@ResponseBody
	@RequestMapping("insList.do")
	public List<Map> insList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".insList");
		logger.info("   - paramMap : " + paramMap);
		
		List<Map> insList = lecService.insList();
		
		logger.info("+ End " + className + ".insList");
		
		return insList;
		
	}
	
	
	/**
	 * 강의 내용 조회
	 */
	@ResponseBody
	@RequestMapping("selectLec.do")
	public Map<String, Object> selectLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".selectLec");
		logger.info("   - paramMap : " + paramMap);
		
		LectureModel lecModel = lecService.selectLec(paramMap);
		
		Map<String, Object> returnmap = new HashMap<>();
		
		returnmap.put("lecModel", lecModel);
		
		logger.info("+ End " + className + ".selectLec");
		
		return returnmap;
		
	}
	
	
	
	/** 학생 목록 조회
	 */
	@RequestMapping("stdList.do")
	public String stdList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".stdList");
		logger.info("   - paramMap : " + paramMap);
		
		int stdPageSize = Integer.parseInt((String) paramMap.get("stdPageSize"));   
		int stdCurrentPage = Integer.parseInt((String) paramMap.get("stdCurrentPage"));   
		int startpoint = ( stdCurrentPage - 1 ) * stdPageSize;

		paramMap.put("stdPageSize", stdPageSize);
		paramMap.put("startpoint", startpoint);
		
		int stdTotalcnt = lecService.stdTotalcnt(paramMap);
		
		List<StdModel> stdList = lecService.stdList(paramMap);

		model.addAttribute("stdList", stdList);
		model.addAttribute("stdTotalcnt", stdTotalcnt);
		
		logger.info("+ End " + className + ".stdList");
		
		return "mngadm/stdList";
		
	}
	
	
	/** 학생 목록 조회
	 */
	@ResponseBody
	@RequestMapping("stdListVue.do")
	public Map<String, Object> stdListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".stdListVue");
		logger.info("   - paramMap : " + paramMap);
		
		int stdPageSize = Integer.parseInt((String) paramMap.get("stdPageSize"));   
		int stdCurrentPage = Integer.parseInt((String) paramMap.get("stdCurrentPage"));   
		int startpoint = ( stdCurrentPage - 1 ) * stdPageSize;

		paramMap.put("stdPageSize", stdPageSize);
		paramMap.put("startpoint", startpoint);
		
		int stdTotalcnt = lecService.stdTotalcnt(paramMap);
		
		List<StdModel> stdList = lecService.stdList(paramMap);

		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("stdList", stdList);
		returnMap.put("stdTotalcnt", stdTotalcnt);
		
		logger.info("+ End " + className + ".stdListVue");
		
		return returnMap;
		
	}
	
	
	/**
	 * 강의 종료 시키기
	 */
	@ResponseBody
	@RequestMapping("closeLec.do")
	public Map<String, Object> closeLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".closeLec");
		logger.info("   - paramMap : " + paramMap);
		
		String msg = null;
		
		msg = lecService.closeLec(paramMap);
		
		Map<String, Object> returnmap = new HashMap<>();
		returnmap.put("msg", msg);
		
		logger.info("+ End " + className + ".closeLec");
		
		return returnmap;
		
	}
	

}
