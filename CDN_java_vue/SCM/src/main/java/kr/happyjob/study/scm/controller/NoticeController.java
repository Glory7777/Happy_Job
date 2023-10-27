package kr.happyjob.study.scm.controller;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.scm.model.NoticeModel;
import kr.happyjob.study.scm.service.NoticeService;

@Controller
@RequestMapping("/scm/")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	
	/**
	 * 공지사항 관리 초기화면
	 */
	@RequestMapping("noticeMgr.do")
	public String noticeMgr(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticeMgr");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".noticeMgr");

		return "scm/noticeMgr";
	}
	
	/**
	 * 공지사항 관리 초기화면 (Vue)
	 */
	@RequestMapping("noticeMgrvue.do")
	public String noticeMgrVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticeMgrVue");
		logger.info("   - paramMap : " + paramMap);
		
		logger.info("+ End " + className + ".noticeMgrVue");

		return "scm/vueNoticeMgr";
	}
	    
	/**
	 * 공지사항 목록
	 */
	@RequestMapping("listnotice.do")
	public String listnotice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listnotice");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startpoint = ( currntPage - 1 ) * pageSize;
		
		
		String userType = (String) session.getAttribute("userType");
		logger.info("   - userType : " + userType);
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<NoticeModel> listnotice = null;
		int totalcnt = 0;
		String noticeList = "";
		
		if(userType == "S" || userType.equals("S")){
			listnotice = noticeService.listnotice(paramMap);
			totalcnt = noticeService.totalnotice(paramMap);
			noticeList = "scm/noticeList";
		}else{
			listnotice = noticeService.listNoticeDash(paramMap);
			totalcnt = noticeService.totalNoticeDash(paramMap);
			noticeList = "scm/noticeListDash";
		}
		
		model.addAttribute("listnotice", listnotice);
		model.addAttribute("totalcnt", totalcnt);
		
		logger.info("+ End " + className + ".listnotice");

		return noticeList;
	}
	
	/**
	 * 공지사항 목록 (Vue)
	 */
	@RequestMapping("listnoticevue.do")
	@ResponseBody
	public Map<String, Object> listnoticeVue(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".listnoticeVue");
		logger.info("   - paramMap : " + paramMap);
		
		
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));   
		int currntPage = Integer.parseInt((String) paramMap.get("currntPage"));   
		int startpoint = ( currntPage - 1 ) * pageSize;
		
		
		String userType = (String) session.getAttribute("userType");
		logger.info("   - userType : " + userType);
		paramMap.put("pageSize", pageSize);
		paramMap.put("startpoint", startpoint);
		
		List<NoticeModel> listnotice = null;
		int totalcnt = 0;		
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		
		if(userType == "S" || userType.equals("S")){
			listnotice = noticeService.listnotice(paramMap);
			totalcnt = noticeService.totalnotice(paramMap);
			
			returnMap.put("listnotice", listnotice);
			returnMap.put("totalcnt", totalcnt);			
			
		}else{
			listnotice = noticeService.listNoticeDash(paramMap);
			totalcnt = noticeService.totalNoticeDash(paramMap);
			
			returnMap.put("listnotice", listnotice);
			returnMap.put("totalcnt", totalcnt);
		}
				
		logger.info("+ End " + className + ".listnoticeVue");

		return returnMap;
	}
	
	/**
	 * 공지사항 저장
	 */
	@RequestMapping("noticesave.do")
	@ResponseBody
	public Map<String, Object> noticesave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticesave");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		int sqlreturn = 0;
		
		paramMap.put("loginid", session.getAttribute("loginId") );
		
		
		if("I".equals(action)) {
			sqlreturn = noticeService.insertnotice(paramMap);
		} else if("U".equals(action)) {
			sqlreturn = noticeService.updatenotice(paramMap);
		} else if("D".equals(action)) {
			sqlreturn = noticeService.deletenotice(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if(sqlreturn >= 0) {
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}
		
		logger.info("+ End " + className + ".noticesave");

		return returnmap;
	}
	
	/**
	 * 공지사항 저장
	 */
	@RequestMapping("noticeselect.do")
	@ResponseBody
	public Map<String, Object> noticeselect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticeselect");
		logger.info("   - paramMap : " + paramMap);
		
		
		NoticeModel	sectinfo = noticeService.noticeselect(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("sectinfo", sectinfo);
		
		logger.info("+ End " + className + ".noticeselect");

		return returnmap;
	}
	
	/**
	 * 공지사항 저장
	 */
	@RequestMapping("noticesavefile.do")
	@ResponseBody
	public Map<String, Object> noticesavefile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".noticesavefile");
		logger.info("   - paramMap : " + paramMap);
		
		String action = (String) paramMap.get("action");
		int sqlreturn = 0;
		
		paramMap.put("loginid", session.getAttribute("loginId") );
				
		if("I".equals(action)) {
			sqlreturn = noticeService.insertnoticefile(paramMap,request);
		} else if("U".equals(action)) {
			sqlreturn = noticeService.updatenoticefile(paramMap,request);
		} else if("D".equals(action)) {
			sqlreturn = noticeService.deletenoticefile(paramMap);
		}
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		if(sqlreturn > 0) {
			returnmap.put("result", "SUCCESS");
		} else {
			returnmap.put("result", "FAIL");
		}
		
		logger.info("+ End " + className + ".noticesavefile");

		return returnmap;
	}
	
	
	/**
	 * 첨부파일 다운로드
	 */
	@RequestMapping("noticedownload.do")
	public void noticedownload(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
	
		logger.info("+ Start " + className + ".noticedownload");
		logger.info("   - paramMap : " + paramMap);
		
		// 첨부파일 조회
		NoticeModel	sectinfo = noticeService.noticeselect(paramMap);
		
		// sectinfo.getFile_nm()  첨부 파일명
		// sectinfo.getPhysic_path()  물리경로  X:\.....
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(sectinfo.getPhysic_path()));
		
		response.setContentType("application/octet-stream");
	    response.setContentLength(fileByte.length);
	    response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(sectinfo.getFile_nm(),"UTF-8")+"\";");
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    response.getOutputStream().write(fileByte);
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();

		logger.info("+ End " + className + ".noticedownload");
	}
	
	
	////////////////////////////////Vue ////////////////////////////////

	
	/**
	 * 공지사항 저장
	 */
	@RequestMapping("vueNoticeselect.do")
	@ResponseBody
	public Map<String, Object> vueNoticeselect(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {
		
		logger.info("+ Start " + className + ".vueNoticeselect");
		logger.info("   - paramMap : " + paramMap);
		
		
		NoticeModel	sectinfo = noticeService.noticeselect(paramMap);
		
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
	   returnmap.put("sectinfo", sectinfo);
		
		logger.info("+ End " + className + ".vueNoticeselect");

		return returnmap;
	}
}
