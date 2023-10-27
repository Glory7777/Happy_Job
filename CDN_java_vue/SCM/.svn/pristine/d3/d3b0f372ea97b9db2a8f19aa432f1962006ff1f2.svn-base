package kr.happyjob.study.cus.controller;

import java.util.HashMap;
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

import kr.happyjob.study.cus.model.MypageModel;
import kr.happyjob.study.cus.service.MypageService;


@Controller
@RequestMapping("/cus/")
public class MypageController {
	
	@Autowired
	MypageService mypageService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	/**
	 * 회원 정보 변경(마이페이지) 초기 화면
	 */
	@RequestMapping("mypage.do")
	public String formMypage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".formMypage");
		logger.info("   - paramMap : " + paramMap);
		logger.info("세션의 loginid : " + session.getAttribute("loginId"));		
		
		paramMap.put("loginid", session.getAttribute("loginId") );
		
		MypageModel	sectinfo = mypageService.initMypage(paramMap);

		model.addAttribute("sectinfo", sectinfo);
		
		logger.info("   - sectinfo : " + sectinfo);
		logger.info("+ End " + className + ".formMypage");
		
		return "cus/Mypage";
	}
	
	/**
	 * 회원 정보 변경 수정
	 */
	@RequestMapping("updateMypage.do")
	@ResponseBody
	public Map<String, Object> updateMypage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".updateMypage");
		logger.info("   - paramMap : " + paramMap);
		
		String loginid = (String) paramMap.get("loginid");
		
	    int result = 0;
	    
	    if (session.getAttribute("loginId").equals(loginid)) {
	        // 저장 성공
	    	result = mypageService.updateMypage(paramMap);
	    } else {
	        // 저장 실패
	    }
	    
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if(result >= 0) {
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}
	    	    
		logger.info("   - result : " + result);
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".updateMypage");

		return returnmap;
	}
	
	/**
	 * 회원 탈퇴(update 탈퇴여부:Y)
	 */
	@RequestMapping("delMember.do")
	@ResponseBody
	public Map<String, Object> delMember(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".delMember");
		logger.info("   - paramMap : " + paramMap);
		
		String loginid = (String) paramMap.get("loginid");
		
	    int result = 0;
	    
	    if (session.getAttribute("loginId").equals(loginid)) {
	        // 저장 성공
	    	result = mypageService.delMember(paramMap);
	    } else {
	        // 저장 실패
	    }
	    
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if(result >= 0) {
			returnmap.put("result", "탈퇴 SUCCESS");
		} else {
			returnmap.put("result", "탈퇴 FAIL");
		}
	    	    
		logger.info("   - result : " + result);
		logger.info("   - paramMap : " + paramMap);
		logger.info("+ End " + className + ".delMember");

		return returnmap;
	}

	// ----------------------------------------------------vue---------------------------------------------- //
	/**
	 * 빈 div화면
	 */
	@RequestMapping("mypagevue.do")
	public String vueFormMypageInit(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueFormMypageInit");
		logger.info("   - paramMap : " + paramMap);	
		
		logger.info("+ End " + className + ".vueFormMypageInit");
		
		return "cus/vueMypage";
	}
	
	/**
	 * 회원 정보 변경(마이페이지) 초기 화면
	 */
	@RequestMapping("mypagevueInfo.do")
	@ResponseBody
	public Map<String, Object> vueFormMypage(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueFormMypage");
		logger.info("   - paramMap : " + paramMap);	
		
		MypageModel	sectinfo = mypageService.initMypage(paramMap);
		
		Map<String, Object> initmap = new HashMap<String, Object>();

		initmap.put("sectinfo", sectinfo);
		
		logger.info("   - sectinfo : " + sectinfo);
		logger.info("+ End " + className + ".vueFormMypage");
		
		return initmap;
	}
	
}
