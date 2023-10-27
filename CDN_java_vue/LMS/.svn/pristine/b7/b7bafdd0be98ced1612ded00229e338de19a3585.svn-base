package kr.happyjob.study.mngins.controller;

import java.io.File;
import java.net.URLEncoder;
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

import com.google.gson.Gson;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.mngins.model.HwkFileModel;
import kr.happyjob.study.mngins.model.HwkModel;
import kr.happyjob.study.mngins.service.ProjectService;
import kr.happyjob.study.mngstd.model.SmFileModel;
import kr.happyjob.study.mngstd.model.SubmitHwkModel;
import kr.happyjob.study.mngstd.service.SubmittedWorkService;
import kr.happyjob.study.sptins.model.FileInfoModel;


@Controller
@RequestMapping("/tut/")
public class ProjectController {
	
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	SubmittedWorkService smWorkService;

	
	/** 관제관리 초기 화면
	 * @return view jsp
	 * @author 김정욱
	 */
	@RequestMapping("projectControl.do")
	public String projectControl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".projectControl");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".projectControl");

		return "mngins/project";
		
	}
	
	
	/** 관제관리 초기 화면 Vue
	 * @return view jsp
	 * @author 김정욱
	 */
	@RequestMapping("projectControlvue.do")
	public String projectControlvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".projectControlvue");
		logger.info("   - paramMap : " + paramMap);

		logger.info("+ end " + className + ".projectControlvue");

		return "mngins/projectVue";
		
	}
	
	
	/** 강사 과목 정보 불러오기
	 * @return view jsp
	 * @author 김정욱
	 */
	@RequestMapping("findLecInfo.do")
	public String findLecInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".findLecInfo");
		logger.info("   - paramMap : " + paramMap);
		
		// 접속한 강사 ID
		paramMap.put("loginId", session.getAttribute("loginId").toString());
		
		// 강사가 진행중인 강의 정보 불러오기
		LectureModel lecInfo = projectService.lecInfo(paramMap);
		
		model.addAttribute("lecInfo", lecInfo);

		logger.info("+ end " + className + ".findLecInfo");

		return "mngins/lecInfo";
		
	}
	
	
	/** 강사 과목 정보 불러오기 Vue
	 * @return view jsp
	 * @author 김정욱
	 */
	@ResponseBody
	@RequestMapping("findLecInfoVue.do")
	public Map<String, Object> findLecInfoVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".findLecInfoVue");
		logger.info("   - paramMap : " + paramMap);
		
		// 접속한 강사 ID
		paramMap.put("loginId", session.getAttribute("loginId").toString());
		
		// 강사가 진행중인 강의 정보 불러오기
		LectureModel lecInfo = projectService.lecInfo(paramMap);
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("lecInfo", lecInfo);

		logger.info("+ end " + className + ".findLecInfoVue");

		return returnMap;
		
	}
	
	
	/** 과제 목록 불러오기
	 * @return view jsp
	 * @author 김정욱
	 */
	@RequestMapping("findHwkList.do")
	public String findHwkList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".findHwkList");
		logger.info("   - paramMap : " + paramMap);
		
		List<HwkModel> hwkList = projectService.findHwkList(paramMap);
		
		int totalcnt = hwkList.size();
		
		Gson gson = new Gson();
		
		String hwkListJS = gson.toJson(hwkList);
		
		model.addAttribute("hwkList", hwkList);
		model.addAttribute("hwkListJS", hwkListJS);
		model.addAttribute("totalcnt", totalcnt);

		logger.info("+ end " + className + ".findHwkList");

		return "mngins/hwkList";
		
	}
	
	
	/** 과제 목록 불러오기 Vue
	 * @return view jsp
	 * @author 김정욱
	 */
	@ResponseBody
	@RequestMapping("findHwkListVue.do")
	public Map<String, Object> findHwkListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".findHwkListVue");
		logger.info("   - paramMap : " + paramMap);
		
		List<HwkModel> hwkList = projectService.findHwkList(paramMap);
		
		int totalcnt = hwkList.size();
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("hwkList", hwkList);
		returnMap.put("totalcnt", totalcnt);

		logger.info("+ end " + className + ".findHwkListVue");

		return returnMap;
		
	}
	
	
	/** 제출 명단 불러오기
	 * @return 제출명단(List<Map>)
	 * @author 김정욱
	 */
	@RequestMapping("findHwkSmList.do")
	public String findHwkSmList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".findHwkSmList");
		logger.info("   - paramMap : " + paramMap);
		
		// 강의 학생 명단
		List<Map> appStdList = projectService.findAppStd(paramMap);
		
		// 제출한 명단
		List<String> hwkSmList = projectService.findHwkSmList(paramMap);
		
		//제출 상태 세팅
		for(int i = 0; i < appStdList.size(); i++){
			if(hwkSmList.contains(appStdList.get(i).get("loginID"))){
				appStdList.get(i).put("smState", "제출");
			} else{
				appStdList.get(i).put("smState", "미제출");
			}
		}
		
		model.addAttribute("appStdList", appStdList);

		logger.info("+ end " + className + ".findHwkSmList");

		return "mngins/hwkSmList";
		
	}
	
	
	/** 제출 명단 불러오기
	 * @return 제출명단(List<Map>)
	 * @author 김정욱
	 */
	@ResponseBody
	@RequestMapping("findHwkSmListVue.do")
	public Map<String, Object> findHwkSmListVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".findHwkSmListVue");
		logger.info("   - paramMap : " + paramMap);
		
		// 강의 학생 명단
		List<Map> appStdList = projectService.findAppStd(paramMap);
		
		// 제출한 명단
		List<String> hwkSmList = projectService.findHwkSmList(paramMap);
		
		//제출 상태 세팅
		for(int i = 0; i < appStdList.size(); i++){
			if(hwkSmList.contains(appStdList.get(i).get("loginID"))){
				appStdList.get(i).put("smState", "제출");
			} else{
				appStdList.get(i).put("smState", "미제출");
			}
		}
		
		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("appStdList", appStdList);

		logger.info("+ end " + className + ".findHwkSmListVue");

		return returnMap;
		
	}
	
	
	/** 제출된 과제 조회
	 * @return 제출된 과제 정보(SubmitHwkModel)
	 * @author 김정욱
	 */
	@ResponseBody
	@RequestMapping("findHwkSmInfo.do")
	public Map<String, Object> findHwkSmInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".findHwkSmInfo");
		logger.info("   - paramMap : " + paramMap);
		
		// 제출 과제 정보
		SubmitHwkModel hwkSmInfo = projectService.findHwkSmInfo(paramMap);

		Map<String, Object> returnMap = new HashMap<>();
		
		returnMap.put("hwkSmInfo", hwkSmInfo);
		
		logger.info("+ end " + className + ".findHwkSmInfo");

		return returnMap;
		
	}
	
	
	/**
	 * 제출된 과제 파일 다운로드
	 */
	@RequestMapping("smFiledownload.do")
	public void smFiledownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".smFiledownload");
		logger.info("   - paramMap : " + paramMap);
		
		// 첨부파일 조회
		int sm_file_no = Integer.parseInt(paramMap.get("sm_file_no").toString());
		SmFileModel smFileInfo = smWorkService.findSmFileInfo(sm_file_no);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(smFileInfo.getSm_file_path()));
		
		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(smFileInfo.getSm_file_nm(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("+ End " + className + ".smFiledownload");
	}
	
	
	/** 과제 파일 정보 불러오기
	 * @return 파일정보(HwkFileModel)
	 * @author 김정욱
	 */
	@ResponseBody
	@RequestMapping("hwkFileInfo.do")
	public HwkFileModel hwkFileInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".hwkFileInfo");
		logger.info("   - paramMap : " + paramMap);
		
		HwkFileModel hwkFileInfo = projectService.hwkFileInfo(paramMap);

		logger.info("+ end " + className + ".hwkFileInfo");

		return hwkFileInfo;
		
	}
	
	
	/** 과제 저장하기
	 * @return 성공 여부
	 * @author 김정욱
	 */
	@ResponseBody
	@RequestMapping("saveHwkFile.do")
	public Map<String, Object> saveHwkFile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveHwkFile");
		logger.info("   - paramMap : " + paramMap);
	
		String msg = null;
		String action = paramMap.get("action").toString();
		
		// 신규 저장
		if(action.equals("I")){
			msg = projectService.insertHwk(paramMap,request);
		
		// 과제 갱신	
		} else if(action.equals("U")){
			msg = projectService.updateHwk(paramMap,request);
			
		// 파일 삭제	
		} else {
			msg = projectService.deleteHwk(paramMap,request);
		}
		
		Map<String, Object> returnMap = new HashMap<>();
		returnMap.put("msg", msg);
		
		logger.info("+ end " + className + ".saveHwkFile");

		return returnMap;
		
	} 
	
	
	/**
	 * 첨부파일 다운로드
	 */
	@RequestMapping("hwkFiledownload.do")
	public void hwkFiledownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".hwkFiledownload");
		logger.info("   - paramMap : " + paramMap);
		
		// 첨부파일 조회
		HwkFileModel fileInfo = projectService.hwkFileInfo(paramMap);
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(fileInfo.getHwk_path()));
		
		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileInfo.getHwk_file_nm(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("+ End " + className + ".hwkFiledownload");
	}
	
	
	
	
	
	
}
