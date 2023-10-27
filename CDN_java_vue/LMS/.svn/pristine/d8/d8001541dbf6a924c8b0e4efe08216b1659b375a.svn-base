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

import kr.happyjob.study.facadm.model.RoomDtlModel;
import kr.happyjob.study.facadm.model.RoomModel;
import kr.happyjob.study.facadm.service.RoomService;

@Controller
@RequestMapping("/adm/")// 0. 제일처음 받아옴. 
public class RoomController {
	
	@Autowired
	RoomService roomService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	// 처음 로딩될 때 강의실 연결
	@RequestMapping("lectureRoom.do") // 0. 상위 개체 + roomControl.do // 
	public String room(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".roomControl");
		logger.info("   - paramMap : " + paramMap);
		String userType = (String) session.getAttribute("user_type"); // 유저타입 가지고 있기
		paramMap.put("userType", userType);
		String loginID = (String) session.getAttribute("loginId"); // 로그인 세션에서 로그인 아이디 가지고 있기
		paramMap.put("loginID", loginID);
		System.out.println(loginID);
//		paramMap.put("writer", loginID);
		
		return "facadm/RoomInfo";  // 0. 리턴 경로로 받아온 값들을 줌
	}
	/**
	 * 강의실 목록 카운트
	 */
	@RequestMapping("listRoom.do") // 6. fnSearchList 함수에서 값을 받아옴
	public String listRoom(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listRoom");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startPoint = ( currntPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startPoint", startPoint);
		
		List<RoomModel> listRoom = roomService.listRoom(paramMap); // 7. listRoom를 서비스에서 paramMap값으로실행
		
		int totalCnt = roomService.totalCnt(paramMap); // 9. 서비스에서 실행한 토탈값 받아오기
		
		model.addAttribute("listRoom", listRoom);
		model.addAttribute("totalCnt", totalCnt);
		
		logger.info("+ End " + className + ".listRoom");

		return "facadm/RoomList"; // 11. 이 값들을 다시 리스트 jsp로 ㄱㄱ
	}
	
	/**
	 * 강의실 개별 조회 (팝업)
	 */
	@RequestMapping("selectRoom.do")
	@ResponseBody
	public Map<String, Object> selectRoom(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectRoom");
		logger.info("   - paramMap : " + paramMap);
		
		
		RoomModel	sectInfo = roomService.selectRoom(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("sectInfo", sectInfo);
		logger.info("   - paramMap : " + sectInfo);
		logger.info("+ End " + className + ".selectRoom");

		return returnmap;
	}
	
	// 강의실 신규등록, 업데이트
	@RequestMapping("roomSave.do")
	@ResponseBody
	public Map<String, Object> roomSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".roomSave");
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
			roomService.insertRoom(paramMap);
			resultMsg = "저장";
		} else if("U".equals(action)) {
			// 장비 수정 저장
			roomService.updateRoom(paramMap);
			resultMsg = "수정";
			System.out.println(paramMap);
		}else if("D".equals(action)) {
			roomService.deleteRoom(paramMap);
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
	@RequestMapping("listRoomDtl.do")
	public String listRoomDtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listRoomDtl");
		logger.info("   - paramMap : " + paramMap);
		
		
		int currentPage = Integer.parseInt((String)paramMap.get("currentPage"));	// 현재 페이지 번호
		int pageSize = Integer.parseInt((String)paramMap.get("pageSize"));			// 페이지 사이즈
		int pageIndex = (currentPage-1)*pageSize;												// 페이지 시작 row 번호
		

		paramMap.put("pageIndex", pageIndex);
		paramMap.put("pageSize", pageSize);
		
		// 내역코드 목록 조회
		List<RoomDtlModel> listRoomDtlModel = roomService.listRoomDtl(paramMap);
		model.addAttribute("listRoomDtlModel", listRoomDtlModel);
		
		// 내역 목록 카운트 조회
		int totalCntRoomDtl = roomService.totalCntDtl(paramMap);
		model.addAttribute("totalCntRoomDtl", totalCntRoomDtl);
		
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("currentPageDtl",currentPage);
		
		logger.info("+ End " + className + ".listRoomDtl");

		return "/facadm/RoomDtlList"; // 정보 모아모았당.. ㄱㄱ
	}	
	// 한개 조회
	@RequestMapping("selectRoomDtl.do")
	@ResponseBody
	public Map<String, Object> selectRoomDtl(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".selectRoomDtl");
		logger.info("   - paramMap : " + paramMap);
		
		
		RoomDtlModel	sectInfoD = roomService.selectRoomDtl(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("sectInfoD", sectInfoD);
		logger.info("   - paramMap : " + sectInfoD);
		logger.info("+ End " + className + ".selectRoomDtl");

		return returnmap;
	}
	
	// 장비 강의실 중복 여부
	@RequestMapping("dupEquCheck.do")
	@ResponseBody
	public Map<String, Object> dupEquCheck(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".dupEquCheck");
		logger.info("   - paramMap : " + paramMap);
		
		
		int	dupYN= roomService.dupEquCheck(paramMap);
		int	equ_able_cnt= roomService.getAbleCnt(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("dupYN", dupYN);
		returnmap.put("equ_able_cnt", equ_able_cnt);
		logger.info("   - paramMap : " + dupYN);
		logger.info("+ End " + className + ".dupEquCheck");
		
		return returnmap;
	}

	
	// 장비 신규등록, 업데이트
	@RequestMapping("roomDtlSave.do")
	@ResponseBody
	public Map<String, Object> roomDtlSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".roomDtlSave");
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
			roomService.insertRoomDtl(paramMap);
			resultMsg = "저장";
		} else if("U".equals(action)) {
			// 장비 수정 저장
			roomService.updateRoomDtl(paramMap);
			resultMsg = "수정";
			System.out.println(paramMap);
		}else if("D".equals(action)) {
			roomService.deleteRoomDtl(paramMap);
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
