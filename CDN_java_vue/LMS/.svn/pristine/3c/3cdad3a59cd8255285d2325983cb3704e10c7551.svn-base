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

import kr.happyjob.study.jobadm.model.ResModel;
import kr.happyjob.study.jobadm.service.ResService;

@Controller
@RequestMapping("/adm/")// 0. 제일처음 받아옴. 
public class ResController {
	
	@Autowired
	ResService resService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 학생내역 연결
	@RequestMapping("c_resumeControl.do") // 0. 상위 개체 + c_resumeControl.do // 
	public String resControl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".resControl");
		logger.info("   - paramMap : " + paramMap);
//		String userType = (String) session.getAttribute("user_type"); // 유저타입 가지고 있기
//		paramMap.put("userType", userType);
//		System.out.println("login userType : " + userType);
		return "jobadm/ResInfo";  // 0. 리턴 경로로 받아온 값들을 줌
	}
	/**
	 * 학생 목록 카운트
	 */
	@RequestMapping("listRes.do") // 6. fnSearchList 함수에서 값을 받아옴
	public String listRes(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listRes");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startPoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<ResModel> listRes = resService.listRes(paramMap); // 7. listRes를 서비스에서 paramMap값으로실행
		
		int totalCnt = resService.totalCnt(paramMap); // 9. 서비스에서 실행한 토탈값 받아오기
		
		model.addAttribute("listRes", listRes);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".listRes");

		return "jobadm/ResList"; // 11. 이 값들을 다시 리스트 jsp로 ㄱㄱ
	}
	
	// 처음 로딩될 때 학생내역 연결 Vue
	@RequestMapping("c_resumeControlvue.do") // 0. 상위 개체 + c_resumeControl.do // 
	public String resControlvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".resControlvue");
		logger.info("   - paramMap : " + paramMap);
		return "jobadm/ResInfovue";  // 0. 리턴 경로로 받아온 값들을 줌
	}
	/**
	 * 학생 목록 카운트 Vue
	 */
	@RequestMapping("listResvue.do") // 6. fnSearchList 함수에서 값을 받아옴
	@ResponseBody
	public Map<String, Object> listResvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listResvue");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startPoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<ResModel> listRes = resService.listRes(paramMap); // 7. listRes를 서비스에서 paramMap값으로실행
		
		int totalCnt = resService.totalCnt(paramMap); // 9. 서비스에서 실행한 토탈값 받아오기
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		returnMap.put("listRes", listRes);
		returnMap.put("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".listResvue");

		return returnMap; // 11. 이 값들을 다시 리스트 jsp로 ㄱㄱ
	}
	/**
	 * 이력서 개별 조회 (팝업)
	 */
	@RequestMapping("selectRes.do")
	@ResponseBody
	public Map<String, Object> selectRes(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectRes");
		logger.info("   - paramMap : " + paramMap);
		
		
		ResModel	sectInfo = resService.selectRes(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("sectInfo", sectInfo);
		logger.info("   - paramMap : " + sectInfo);
		logger.info("+ End " + className + ".selectRes");

		return returnmap;
	}
	
	// 이력서 신규등록, 업데이트
	@RequestMapping("resSave.do")
	@ResponseBody
	public Map<String, Object> resSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".resSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String resultMsg = "";
				
		if ("I".equals(action)) {
			// 이력서 신규 저장
			resService.insertRes(paramMap);
			resultMsg = "저장";
		} else if("U".equals(action)) {
			// 이력서 수정 저장
			resService.updateRes(paramMap);
			resultMsg = "수정";
			System.out.println(paramMap);
		}else if("D".equals(action)) {
			resService.deleteRes(paramMap);
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
