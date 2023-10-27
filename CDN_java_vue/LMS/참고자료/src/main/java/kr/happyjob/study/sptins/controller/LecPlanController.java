package kr.happyjob.study.sptins.controller;

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

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.sptins.model.LecPlanModel;
import kr.happyjob.study.sptins.model.WeeklyModel;
import kr.happyjob.study.sptins.service.LecPlanService;


@Controller
@RequestMapping("/tut/")
public class LecPlanController {
	
	@Autowired
	LecPlanService lecPlanService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	
	/** 강의 계획서 초기 화면
	 * @return view jsp
	 * @author 김정욱
	 */
	@RequestMapping("lecturePlan.do")
	public String lecturePlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lecturePlan");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".lecturePlan");

		return "sptins/lecPlan";
		
	}
	
	/** 강의 목록 조회
	 * @return table body jsp
	 * @author 김정욱
	 */
	@RequestMapping("findLecList.do")
	public String findLecList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".findLecList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));   
		int startpoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		paramMap.put("loginId", session.getAttribute("loginId").toString());
		
		List<LectureModel> lecList = lecPlanService.findLecList(paramMap);

		int totalcnt = lecPlanService.totalcnt(paramMap);
			
		
		model.addAttribute("lecList", lecList);
		model.addAttribute("totalcnt", totalcnt);

		logger.info("+ end " + className + ".findLecList");

		return "sptins/lecPlanList";
		
	}
	
	
	/** 강의 정보 조회
	 * @return 강의 정보
	 * @author 김정욱
	 */
	@ResponseBody
	@RequestMapping("selectLec.do")
	public Map<String, Object> selectLec(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectLec");
		logger.info("   - paramMap : " + paramMap);
		
		LecPlanModel selectLec = lecPlanService.selectLec(paramMap);
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("selectLec", selectLec);
		
		if(session.getAttribute("loginId").toString().equals(selectLec.getLoginID().toString())){
			returnMap.put("correct", "Y");
		} else{
			returnMap.put("correct", "N");
		}

		logger.info("+ end " + className + ".selectLec");

		return returnMap;
		
	}
	

	/** 주차수 목록 조회
	 * @return 해당 강의 주차 목록
	 * @author 김정욱
	 */
	@RequestMapping("findWeeklyList.do")
	public String findWeeklyList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".findWeeklyList");
		logger.info("   - paramMap : " + paramMap);

		List<WeeklyModel> weeklyList = lecPlanService.findWeeklyList(paramMap);
		
		System.out.println("weeklyListSize:::" + weeklyList.size());
		
		model.addAttribute("weeklyList", weeklyList);
		model.addAttribute("preWeeklySize", weeklyList.size());
		
		logger.info("+ end " + className + ".findWeeklyList");

		return "sptins/weeklyList";
		
	}
	
	
	/** 강의계획서 저장
	 * @return 내용 저장 성공 여부
	 * @throws Exception
	 * @author 김정욱
	 */
	@ResponseBody
	@RequestMapping("saveLecPlan.do")
	public Map<String, Object> saveLecPlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveLecPlan");
		logger.info("   - paramMap : " + paramMap);
		
		String msg = lecPlanService.saveLecPlan(paramMap, request);
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("msg", msg);
		
		logger.info("+ end " + className + ".saveLecPlan");

		return returnMap;
		
	}
	
}
