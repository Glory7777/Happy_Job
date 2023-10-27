package kr.happyjob.study.prsadm.controller;

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

import kr.happyjob.study.prsadm.model.InsModel;
import kr.happyjob.study.prsadm.service.InsService;

@Controller
@RequestMapping("/adm/")// 0. 제일처음 받아옴. 
public class InsController {
	
	@Autowired
	InsService insService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 강사내역 연결
	@RequestMapping("tutorControl.do") // 0. 상위 개체 + insControl.do // 
	public String insControl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".insControl");
		logger.info("   - paramMap : " + paramMap);
		String userType = (String) session.getAttribute("user_type"); // 유저타입 가지고 있기
		paramMap.put("userType", userType);
		String login_ID = (String) session.getAttribute("loginId"); // 로그인 세션에서 로그인 아이디 가지고 있기
		paramMap.put("login_ID", login_ID);
		System.out.println(login_ID);
//		paramMap.put("writer", loginID);
		
		return "prsadm/InsInfo";  // 0. 리턴 경로로 받아온 값들을 줌
	}
	
	// Vue로딩
	@RequestMapping("tutorControlvue.do") // 0. 상위 개체 + insControl.do // 
	public String insControlvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".insControlvue");
		logger.info("   - paramMap : " + paramMap);
		String userType = (String) session.getAttribute("user_type"); // 유저타입 가지고 있기
		paramMap.put("userType", userType);
		String login_ID = (String) session.getAttribute("loginId"); // 로그인 세션에서 로그인 아이디 가지고 있기
		paramMap.put("login_ID", login_ID);
		System.out.println(login_ID);
//		paramMap.put("writer", loginID);
		
		return "prsadm/InsInfovue";  // 0. 리턴 경로로 받아온 값들을 줌
	}
	/**
	 * 강사 목록 카운트
	 */
	@RequestMapping("listIns.do") // 6. fnSearchList 함수에서 값을 받아옴
	public String listIns(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listIns");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startPoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<InsModel> listIns = insService.listIns(paramMap); // 7. listIns를 서비스에서 paramMap값으로실행
		
		int totalCnt = insService.totalCnt(paramMap); // 9. 서비스에서 실행한 토탈값 받아오기
		
		model.addAttribute("listIns", listIns);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".listIns");

		return "prsadm/InsList"; // 11. 이 값들을 다시 리스트 jsp로 ㄱㄱ
	}
	
	// 강사 리스트 받아오기 Vue
	@RequestMapping("listInsvue.do") // 6. fnSearchList 함수에서 값을 받아옴
	@ResponseBody
	public Map<String, Object> listInsvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listInsvue");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));   
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<InsModel> listIns = insService.listIns(paramMap); // 7. listIns를 서비스에서 paramMap값으로실행
		Map<String, Object> returnMap = new HashMap<String, Object>();
		int totalCnt = insService.totalCnt(paramMap); // 9. 서비스에서 실행한 토탈값 받아오기
		
		returnMap.put("listIns", listIns);
		returnMap.put("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".listInsvue");
		
		return returnMap; // 11. 이 값들을 다시 리스트 jsp로 ㄱㄱ
	}
	

	
	/**
	 * 강사 개별 조회 (팝업)
	 */
	@RequestMapping("selectIns.do")
	@ResponseBody
	public Map<String, Object> selectIns(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectIns");
		logger.info("   - paramMap : " + paramMap);
		
		
		InsModel	sectInfo = insService.selectIns(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("sectInfo", sectInfo);
		logger.info("   - paramMap : " + sectInfo);
		logger.info("+ End " + className + ".selectIns");

		return returnmap;
	}
	
	// 강사 신규등록, 업데이트
	@RequestMapping("insSave.do")
	@ResponseBody
	public Map<String, Object> insSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".insSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String resultMsg = "";
		
//		// 사용자 정보 설정
//		paramMap.put("loginId", session.getAttribute("loginId"));
//		logger.info("loginId : " + paramMap.get("loginId"));
//		
//		paramMap.put("userNm", session.getAttribute("userNm"));
//		logger.info("userNm : " + paramMap.get("userNm"));
		
		if ("I".equals(action)) {
			// 강사 신규 저장
			insService.insertIns(paramMap);
			resultMsg = "저장";
		} else if("U".equals(action)) {
			// 강사 수정 저장
			insService.updateIns(paramMap);
			resultMsg = "수정";
			System.out.println(paramMap);
		}else if("D".equals(action)) {
			insService.deleteIns(paramMap);
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
	
	//승인 / 미승인 체인지
	@RequestMapping("changeStatus.do")
	@ResponseBody
	public Map<String, Object> changeStatus(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".changeStatus");
		logger.info("   - paramMap : " + paramMap);
		
		String status_yn = (String)paramMap.get("status_yn");
		String resultMsg = "";
		
		
		if ("Y".equals(status_yn)) {
			// 승인 -> 미승인
			insService.statusN(paramMap);
			resultMsg = "승인 해제";
		} else {
			// 미승인 -> 승인
			insService.statusY(paramMap);
			resultMsg = "승인";
			System.out.println(paramMap);
		}
		
		//결과 값 전송
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);
	    
	    return resultMap;
	}
}
