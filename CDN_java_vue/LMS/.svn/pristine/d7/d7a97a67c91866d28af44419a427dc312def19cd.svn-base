package kr.happyjob.study.sptins.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.fabric.xmlrpc.base.Array;

import kr.happyjob.study.mngadm.model.LectureModel;
import kr.happyjob.study.sptins.dao.LecPlanDao;
import kr.happyjob.study.sptins.model.LecPlanModel;
import kr.happyjob.study.sptins.model.WeeklyModel;

@Service
public class LecPlanServiceImpl implements LecPlanService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	LecPlanDao lecPlanDao;

	/* 강의 목록 조회
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LecPlanService#findLecList(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public List<LectureModel> findLecList(Map<String, Object> paramMap) throws Exception {
		return lecPlanDao.findLecList(paramMap);
	}

	
	/* 강의 목록 총 갯수
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LecPlanService#totalcnt(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public int totalcnt(Map<String, Object> paramMap) throws Exception {
		return lecPlanDao.totalcnt(paramMap);
	}


	/* 강의 정보 조회
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LecPlanService#selectLec(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public LecPlanModel selectLec(Map<String, Object> paramMap) throws Exception {
		return lecPlanDao.selectLec(paramMap);
	}


	/* 주차수 목록 조회
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LecPlanService#findWeeklyList(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public List<WeeklyModel> findWeeklyList(Map<String, Object> paramMap) throws Exception {
		return lecPlanDao.findWeeklyList(paramMap);
	}


	/* 강의 계획서 저장
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LecPlanService#saveLecPlan()
	 * @author 김정욱
	 */
	@Override
	public String saveLecPlan(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		
		int result = 0;
		String msg = null;
		
		// tb_lec에 수업 목표 저장
		result = lecPlanDao.lecGoal(paramMap);
		
		
		// weekly 업데이트하기
		List<Map> weekList = new ArrayList<>();
		
		String action =  paramMap.get("action").toString();
		
		// 신규저장은 그냥 insert
		if(action.equals("I")){
			// weekly 값 리스트에 넣기(크기제한X)
			weekList = weeklyData(paramMap, request);
			
			result = lecPlanDao.inputWeekly(weekList);
		  // 기존 내용 업데이트
		} else {

			int preWeeklySize = Integer.parseInt(paramMap.get("preWeeklySize").toString()); 	// DB에 저장되어 있던 weekly 갯수
			int currentWeeklySize = Integer.parseInt(paramMap.get("currentWeeklySize").toString()); 		// 새롭게 입력한 weekly 갯수
			
			// 기존 갯수와 새롭게 작성된 갯수가 같을 때
			if(preWeeklySize == currentWeeklySize){
				weekList = weeklyData(paramMap, request);
				result = lecPlanDao.updateWeeklySame(weekList);
				
			// 기존 갯수와 새로 작성한 갯수의 변동이 있을 때
			} else if(preWeeklySize != currentWeeklySize){

				weekList = weeklyData(paramMap, request);
				
				List<Map> weekListSep = new ArrayList<>();
				
				// 기존 갯수 만큼 update
				weekListSep = weekListSep(weekList, currentWeeklySize, preWeeklySize, "U");
				result = lecPlanDao.updateWeeklySame(weekList);
				
				// 갯수 변화에 따른 insert, delete
				weekListSep = weekListSep(weekList, currentWeeklySize, preWeeklySize, "ID");
				if(currentWeeklySize > preWeeklySize) result = lecPlanDao.inputWeekly(weekListSep);
				else if(currentWeeklySize < preWeeklySize) result = lecPlanDao.deleteWeekly(weekListSep);
			}
		}
		
		if(result != 0) msg = "저장 성공";
		else  msg = "저장 실패";
		
		return msg;
	}
	
	
	
	/** 추가 삭제된 갯수 구하여 분리하기
	 * @param weekList
	 * @param currentWeeklySize
	 * @param preWeeklySize
	 * @return
	 * @author 김정욱
	 */
	private List<Map> weekListSep(List<Map> weekList, int currentWeeklySize, int preWeeklySize, String action) {
		
		List<Map> weekListSep = new ArrayList<>();
		
		int min = (currentWeeklySize > preWeeklySize)? preWeeklySize : currentWeeklySize;
		int lim = ((currentWeeklySize - preWeeklySize) < 0)? (currentWeeklySize - preWeeklySize) * (-1) : (currentWeeklySize - preWeeklySize);

		if(action.equals("U")){
			for(int i = 0; i < min; i++){
				weekListSep.add(weekList.get(i));
			}
			
			return weekListSep;
			
		} else if(currentWeeklySize > preWeeklySize) {
			for(int i = min; i < min + lim; i++){
				weekListSep.add(weekList.get(i));
			}
			
			return weekListSep;
			
		} else {
			// 현재 weekly 갯수 + 1씩하여 수정 전 weekly 갯수와의 차만큼 주차수 만들기
			int lec_cd = Integer.parseInt(weekList.get(0).get("lec_cd").toString());
			for(int i = currentWeeklySize + 1; i < currentWeeklySize + 1 + lim; i++){
				Map<String, Object> map = new HashMap<>();
				map.put("lec_cd", lec_cd);
				map.put("weekly_no", i + "주차");
				
				weekListSep.add(map);
				
			}
			
			return weekListSep;
		}
		
	}


	/** weekly 값 리스트에 넣기
	 * @param paramMap
	 * @param request
	 * @return List<Map>
	 * @author 김정욱
	 */
	public List<Map> weeklyData(Map<String, Object> paramMap, HttpServletRequest request){
		
		// 동일한 name값이 복수형태
		String[] weekly_no = request.getParameterValues("weekly_no");
		String[] week_goal = request.getParameterValues("week_goal");
		String[] week_ctt = request.getParameterValues("week_ctt");
		
		List<Map> weekList = new ArrayList<>();
		
		for(int i = 0; i < weekly_no.length; i++){
			Map<String, Object> weekMap = new HashMap<String, Object>();

			weekMap.put("lec_cd", Integer.parseInt(paramMap.get("lec_cd").toString()));
			weekMap.put("weekly_no", weekly_no[i]);
			weekMap.put("week_goal", week_goal[i]);
			weekMap.put("week_ctt", week_ctt[i]);
			
			weekList.add(weekMap);
		}
		
		return weekList;
	}
}
