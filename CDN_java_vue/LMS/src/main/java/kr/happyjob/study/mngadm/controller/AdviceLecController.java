package kr.happyjob.study.mngadm.controller;

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
import kr.happyjob.study.facadm.model.RoomDtlModel;
import kr.happyjob.study.mngadm.model.AdvStuListModel;
import kr.happyjob.study.mngadm.model.AdviceLecModel;
import kr.happyjob.study.mngadm.service.AdviceLecService;
import kr.happyjob.study.sptadm.model.NtModel;


@Controller
@RequestMapping("/adm/")
public class AdviceLecController {
	
	@Autowired
	AdviceLecService adviceLecService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 상담 초기 화면
	 */
	@RequestMapping("lectureAdvice.do")
	public String lectureAdvice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureAdvice");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lectureAdvice");

		
		paramMap.put("loginid", session.getAttribute("loginId") );
		
		return "mngadm/adviceLec";
	}
	

	/**
	 * 상담 초기 화면
	 */
	@RequestMapping("lectureAdvicevue.do")
	public String lectureAdvicevue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureAdvicevue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".lectureAdvicevue");

		
		paramMap.put("loginid", session.getAttribute("loginId") );
		
		return "mngadm/adviceLecVue";
	}
	
	
	/**
	 * 상담 관리
	 */
	@RequestMapping("lectureAdviceList.do")
	public String lectureAdviceList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureAdviceList");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startpoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		int totalcnt = adviceLecService.totalcnt(paramMap);
		
		List<AdviceLecModel> lectureAdviceList = adviceLecService.lectureAdviceList(paramMap);
		
		model.addAttribute("lectureAdviceList", lectureAdviceList);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".lectureAdviceList");

		return "mngadm/adviceLecList";

	}
	

	
	 // 상담 목록 조회
	 
	@RequestMapping("advStuList.do")
	public String advStuList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".advStuList");
		logger.info("   - paramMap : " + paramMap);
		
		int advPageSize = Integer.parseInt((String) paramMap.get("advPageSize"));
		int advCurrentPage = Integer.parseInt((String) paramMap.get("advCurrentPage"));
		int startpoint = ( advCurrentPage - 1 ) * advPageSize;
		
		paramMap.put("advPageSize", advPageSize);
		paramMap.put("startpoint", startpoint);
		

		// 상담 목록 조회
		List<AdvStuListModel> advStuList = adviceLecService.advStuList(paramMap);
		model.addAttribute("advStuList", advStuList);
		
		
		//  상담목록 카운트 조회
		int advTotalcnt = adviceLecService.advTotalcnt(paramMap);

		model.addAttribute("advTotalcnt", advTotalcnt);
		
		
		logger.info("+ End " + className + ".advStuList");

		return "mngadm/advStuList";

	}

	@RequestMapping("advStuListvue.do")
	@ResponseBody
	public Map<String, Object> advStuListvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".advStuListvue");
		logger.info("   - paramMap : " + paramMap);
		
		int advPageSize = Integer.parseInt((String) paramMap.get("advPageSize"));
		int advCurrentPage = Integer.parseInt((String) paramMap.get("advCurrentPage"));
		int startpoint = ( advCurrentPage - 1 ) * advPageSize;
		
		paramMap.put("advPageSize", advPageSize);
		paramMap.put("startpoint", startpoint);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		// 상담 목록 조회
		List<AdvStuListModel> advStuList = adviceLecService.advStuList(paramMap);
		returnmap.put("advStuList", advStuList);
		
		
		//  상담목록 카운트 조회
		int advTotalcnt = adviceLecService.advTotalcnt(paramMap);

		returnmap.put("advTotalcnt", advTotalcnt);
		
		
		logger.info("+ End " + className + ".advStuListvue");

		return returnmap;

	}	

	/*
	  공지사항 목록 카운트  Vue
	 */
	@RequestMapping("lectureAdviceListvue.do") // 6. fnSearchList 함수에서 값을 받아옴
	@ResponseBody
	public Map<String, Object> lectureAdviceListvue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".lectureAdviceListvue");
		logger.info("   - paramMap : " + paramMap);
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int currentPage = Integer.parseInt((String) paramMap.get("currentPage"));
		int startPoint = ( currentPage - 1 ) * pageSize;
		
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startPoint);
		
		List<AdviceLecModel> lectureAdviceList = adviceLecService.lectureAdviceList(paramMap); // 7. listNotice를 서비스에서 paramMap값으로실행
		
		int totalcnt = adviceLecService.totalcnt(paramMap); // 9. 서비스에서 실행한 토탈값 받아오기
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("lectureAdviceList", lectureAdviceList);
		returnmap.put("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".lectureAdviceListvue");

		return returnmap; // 11. 이 값들을 다시 리스트 jsp로 ㄱㄱ
	}
	
	

	//  상담 내용 조회 (팝업)
	 
	@ResponseBody
	@RequestMapping("selectAdv.do")
	public Map<String, Object> selectAdv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".selectAdv");
		logger.info("   - paramMap : " + paramMap);
		
		//paramMap.put("loginid", session.getAttribute("loginId") );
		
		AdvStuListModel sectInfo = adviceLecService.selectAdv(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("sectInfo", sectInfo);
		logger.info("   - paramMap : " + sectInfo);
		logger.info("+ End " + className + ".selectAdv");
		
		return returnmap;
		
		
	}
//	
//	
//	/** 시작
//	 * 공지사항 개별 조회
//	 */
//	@RequestMapping("selectAdvStu.do")
//	@ResponseBody
//	public Map<String, Object> selectAdvStu(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//			HttpServletResponse response, HttpSession session) throws Exception {
//		
//		logger.info("+ Start " + className + ".selectAdvStu");
//		logger.info("   - paramMap : " + paramMap);
//		
//		
//		AdvStuListModel	selectAdvStu = adviceLecService.selectAdvStu(paramMap);
//		
//		
//		Map<String, Object> returnmap = new HashMap<String, Object>();
//		
//	   returnmap.put("sectInfo", selectAdvStu);
//		logger.info("   - paramMap : " + selectAdvStu);
//		logger.info("+ End " + className + ".selectNotice");
//
//		return returnmap;
//	}

	

	 // 상담 신규등록, 업데이트
	 
	@ResponseBody
	@RequestMapping("saveAdv.do")
	public Map<String, Object> saveAdv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".saveAdv");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String)paramMap.get("action");
		String resultMsg = "";
		
		
		if(action.equals("I")){
			// 신규 저장
			adviceLecService.insertAdv(paramMap);
			resultMsg = "저장";
			
			
		} else if(action.equals("U")){
			//  수정 저장
			adviceLecService.updateAdv(paramMap);
			resultMsg = "수정";
			System.out.println(paramMap);
			
		} else if(action.equals("D")){
			adviceLecService.deleteAdv(paramMap);
			resultMsg = "삭제";
		}
		else {
			resultMsg = "FALSE : 등록에 실패하였습니다.";
		}
		
		
		logger.info("+ End " + className + ".saveAdv");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	

	
	
	
	
	
	
}
