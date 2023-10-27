package kr.happyjob.study.facadm.controller;

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

import kr.happyjob.study.facadm.model.EquDtlModel;
import kr.happyjob.study.facadm.model.EquModel;
import kr.happyjob.study.facadm.service.EquService;

@Controller
@RequestMapping("/adm/")// 0. 제일처음 받아옴. 
public class EquController {
	
	@Autowired
	EquService equService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 장비내역 연결
	@RequestMapping("equipmentControl.do") // 0. 상위 개체 + equipmentControl.do // 
	public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".equipmentControl");
		logger.info("   - paramMap : " + paramMap);
		String userType = (String) session.getAttribute("user_type"); // 유저타입 가지고 있기
		paramMap.put("userType", userType);
		String loginID = (String) session.getAttribute("loginId"); // 로그인 세션에서 로그인 아이디 가지고 있기
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);
		
		return "facadm/Equipment";  // 0. 리턴 경로로 받아온 값들을 줌
	}
	/**
	 * 장비 목록 카운트
	 */
	@RequestMapping("listEqu.do") // 6. fnSearchList 함수에서 값을 받아옴
	public String listEqu(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEqu");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startPoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<EquModel> listEqu = equService.listEqu(paramMap); // 7. listEqu를 서비스에서 paramMap값으로실행
		
		int totalCnt = equService.totalCnt(paramMap); // 9. 서비스에서 실행한 토탈값 받아오기
		
		model.addAttribute("listEqu", listEqu);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".listEqu");

		return "facadm/EquList"; // 11. 이 값들을 다시 리스트 jsp로 ㄱㄱ
	}
	
	// 처음 로딩될 때 장비내역 연결 Vue
	@RequestMapping("equipmentControlvue.do") // 0. 상위 개체 + equipmentControl.do // 
	public String equvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".equipmentControlvue");
		logger.info("   - paramMap : " + paramMap);
		
		return "facadm/Equipmentvue";  // 0. 리턴 경로로 받아온 값들을 줌
	}
	/**
	 * 장비 내역  카운트 Vue
	 */
	@RequestMapping("listEquvue.do") // 6. fnSearchList 함수에서 값을 받아옴
	@ResponseBody
	public Map<String, Object> listEquVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEquvue");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startPoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<EquModel> listEqu = equService.listEqu(paramMap); // 7. listEqu를 서비스에서 paramMap값으로실행
		Map<String, Object> returnMap= new HashMap<String, Object>();
		int totalCnt = equService.totalCnt(paramMap); // 9. 서비스에서 실행한 토탈값 받아오기
		
		returnMap.put("listEqu", listEqu);
		returnMap.put("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".listEquvue");

		return returnMap; // 11. 이 값들을 다시 리스트 jsp로 ㄱㄱ
	}
	
	/**
	 * 장비 개별 조회 (팝업)
	 */
	@RequestMapping("selectEqu.do")
	@ResponseBody
	public Map<String, Object> selectEqu(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectEqu");
		logger.info("   - paramMap : " + paramMap);
		
		
		EquModel	sectInfo = equService.selectEqu(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("sectInfo", sectInfo);
		logger.info("   - paramMap : " + sectInfo);
		logger.info("+ End " + className + ".selectEqu");

		return returnmap;
	}
	
	// 장비 신규등록, 업데이트
	@RequestMapping("equSave.do")
	@ResponseBody
	public Map<String, Object> equSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".equSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String resultMsg = "";
		
		// 사용자 정보 설정
		paramMap.put("loginId", session.getAttribute("loginId"));
		logger.info("loginId : " + paramMap.get("loginId"));
		
		paramMap.put("userNm", session.getAttribute("userNm"));
		logger.info("userNm : " + paramMap.get("userNm"));
		
		if ("I".equals(action)) {
			// 장비 신규 저장
			equService.insertEqu(paramMap);
			resultMsg = "저장";
		} else if("U".equals(action)) {
			// 장비 수정 저장
			equService.updateEqu(paramMap);
			resultMsg = "수정";
			System.out.println(paramMap);
		}else if("D".equals(action)) {
			equService.deleteEqu(paramMap);
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
	
	/**
	 * 장비 내역 목록 조회
	 */
	@RequestMapping("listEquDtl.do")
	public String listEquDtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEquDtl");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int startPoint = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		

		paramMap.put("startPoint", startPoint);
		paramMap.put("pageSize", pageSize);
		
		// 내역코드 목록 조회
		List<EquDtlModel> listEquDtlModel = equService.listEquDtl(paramMap);
		model.addAttribute("listEquDtlModel", listEquDtlModel);
		
		// 내역 목록 카운트 조회
		int totalCntEquDtl = equService.totalCntDtl(paramMap);
		model.addAttribute("totalCntEquDtl", totalCntEquDtl);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageDtl",currentPage);
		
		logger.info("+ End " + className + ".listEquDtl");

		return "/facadm/EquDtlList"; // 정보 모아모았당.. ㄱㄱ
	}	
	/**
	 * 장비 내역 목록 조회 Vue
	 */
	@RequestMapping("listEquDtlvue.do")
	@ResponseBody
	public Map<String, Object> listEquDtlvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listEquDtlvue");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int startPoint = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		

		paramMap.put("startPoint", startPoint);
		paramMap.put("pageSize", pageSize);
		
		// 내역코드 목록 조회
		List<EquDtlModel> listEquDtl = equService.listEquDtl(paramMap);
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		// 내역 목록 카운트 조회
		int totalCntDtl = equService.totalCntDtl(paramMap);
		returnMap.put("totalCntDtl", totalCntDtl);
		
		//model.addAttribute("pageSize", pageSize);
		returnMap.put("listEquDtl",listEquDtl);
		returnMap.put("currentPageDtl",currentPage);
		
		logger.info("+ End " + className + ".listEquDtlvue");

		return returnMap; // 정보 모아모았당.. ㄱㄱ
	}	
	// 한개 조회
	@RequestMapping("selectEquDtl.do")
	@ResponseBody
	public Map<String, Object> selectEquDtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectEquDtl");
		logger.info("   - paramMap : " + paramMap);
		
		
		EquDtlModel	sectInfoD = equService.selectEquDtl(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("sectInfoD", sectInfoD);
		logger.info("   - paramMap : " + sectInfoD);
		logger.info("+ End " + className + ".selectEquDtl");

		return returnmap;
	}
	
	// 장비 신규등록, 업데이트
	@RequestMapping("equDtlSave.do")
	@ResponseBody
	public Map<String, Object> equDtlSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".equDtlSave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String resultMsg = "";
		
		// 사용자 정보 설정
		paramMap.put("loginId", session.getAttribute("loginId"));
		logger.info("loginId : " + paramMap.get("loginId"));
		
		paramMap.put("userNm", session.getAttribute("userNm"));
		logger.info("userNm : " + paramMap.get("userNm"));
		
		if ("I".equals(action)) {
			// 장비 신규 저장
			equService.insertEquDtl(paramMap);
			resultMsg = "저장";
		} else if("U".equals(action)) {
			// 장비 수정 저장
			equService.updateEquDtl(paramMap);
			resultMsg = "수정";
			System.out.println(paramMap);
		}else if("D".equals(action)) {
			equService.deleteEquDtl(paramMap);
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
	/**
	 * 장비 강의실 중복 여부
	 */
	@RequestMapping("dupRoomCheck.do")
	@ResponseBody
	public Map<String, Object> dupRoomCheck(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".dupRoomCheck");
		logger.info("   - paramMap : " + paramMap);
		
		
		int	dupYN= equService.dupRoomCheck(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("dupYN", dupYN);
		logger.info("   - paramMap : " + dupYN);
		logger.info("+ End " + className + ".dupRoomCheck");

		return returnmap;
	}

}
