package kr.happyjob.study.jobadm.controller;

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

import kr.happyjob.study.jobadm.model.JobModel;
import kr.happyjob.study.jobadm.service.JobService;

@Controller
@RequestMapping("/adm/")// 0. 제일처음 받아옴. 
public class JobController {
	
	@Autowired
	JobService jobService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 학생내역 연결
	@RequestMapping("employmentInfo.do") // 0. 상위 개체 + c_jobumeControl.do // 
	public String jobControl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".jobControl");
		logger.info("   - paramMap : " + paramMap);

		return "jobadm/JobInfo";  // 0. 리턴 경로로 받아온 값들을 줌
	}
	/**
	 * 학생 목록 카운트
	 */
	@RequestMapping("listJob.do") // 6. fnSearchList 함수에서 값을 받아옴
	public String listJob(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listJob");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startPoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<JobModel> listJob = jobService.listJob(paramMap); // 7. listJob를 서비스에서 paramMap값으로실행
		
		int totalCnt = jobService.totalCnt(paramMap); // 9. 서비스에서 실행한 토탈값 받아오기
		
		model.addAttribute("listJob", listJob);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".listJob");

		return "jobadm/JobList"; // 11. 이 값들을 다시 리스트 jsp로 ㄱㄱ
	}
	
	/**
	 * 이력서 개별 조회 (팝업)
	 */
	@RequestMapping("selectJob.do")
	@ResponseBody
	public Map<String, Object> selectJob(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectJob");
		logger.info("   - paramMap : " + paramMap);
		
		
		JobModel	sectInfo = jobService.selectJob(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("sectInfo", sectInfo);
		logger.info("   - paramMap : " + sectInfo);
		logger.info("+ End " + className + ".selectJob");

		return returnmap;
	}
	
	// 이력서 신규등록, 업데이트
	@RequestMapping("jobSave.do")
	@ResponseBody
	public Map<String, Object> jobSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".jobSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String resultMsg = "";
				
		if ("I".equals(action)) {
			// 이력서 신규 저장
			jobService.insertJob(paramMap);
			resultMsg = "저장";
		} else if("U".equals(action)) {
			// 이력서 수정 저장
			jobService.updateJob(paramMap);
			resultMsg = "수정";
			System.out.println(paramMap);
		}else if("D".equals(action)) {
			jobService.deleteJob(paramMap);
			resultMsg = "삭제";
		}		
		else {
			resultMsg = "FALSE : 등록에 실패하였습니다.";
		}
		
		//결과 값 전송
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);
	    
	    return resultMap;
	}
	
}
