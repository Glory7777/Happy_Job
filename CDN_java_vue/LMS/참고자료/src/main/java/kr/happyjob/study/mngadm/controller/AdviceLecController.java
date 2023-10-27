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
		List<AdvStuListModel> advstuList = adviceLecService.advStuList(paramMap);
		model.addAttribute("advstuList", advstuList);
		
		
		//  상담목록 카운트 조회
		int advTotalcnt = adviceLecService.advTotalcnt(paramMap);

		model.addAttribute("advTotalcnt", advTotalcnt);
		
		
		logger.info("+ End " + className + ".advstuList");

		return "mngadm/advStuList";

	}

	
/*
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
	*/

	
	
	/*
	//  상담 내용 조회 (팝업)
	 
	@ResponseBody
	@RequestMapping("selectAdv.do")
	public Map<String, Object> selectAdv(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception{
		
		logger.info("+ Start " + className + ".selectAdv");
		logger.info("   - paramMap : " + paramMap);
		
		//paramMap.put("loginid", session.getAttribute("loginId") );
		
		AdviceModel advModel = adviceMngService.selectAdv(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("advModel", advModel);
		
		logger.info("+ End " + className + ".selectAdv");
		
		return returnmap;
		
	}
	
	
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
	*/

	
	
}
