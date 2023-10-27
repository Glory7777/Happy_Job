package kr.happyjob.study.sptins.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
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


	/* 강의 계획서 저장 Vue
	 * (non-Javadoc)
	 * @see kr.happyjob.study.sptins.service.LecPlanService#saveLecPlanVue(java.util.Map)
	 * @author 김정욱
	 */
	@Override
	public String saveLecPlanVue(Map<String, Object> paramMap) throws Exception {

		int result = 0;
		String msg = null;
		
		// tb_lec에 수업 목표 저장
		result = lecPlanDao.lecGoal(paramMap);
		
		
		// weekly 업데이트하기
		List<Map> weekList = new ArrayList<>();
		
		// JSON parsing
		JSONParser temp = new JSONParser();
		JSONArray arr = (JSONArray)temp.parse(paramMap.get("weekly_data").toString());
		weekList = arr;

		
		// 신규저장은 그냥 insert
		if(paramMap.get("action").toString().equals("I")){
			
			result = lecPlanDao.inputWeekly(weekList);
		
		// 갱신
		} else {

			int preWeeklySize = Integer.parseInt(paramMap.get("preWeeklySize").toString()); 	// DB에 저장되어 있던 weekly 갯수
			int currentWeeklySize = weekList.size();											// 새롭게 입력한 weekly 갯수
			
			
			// 기존 갯수와 새롭게 작성된 갯수가 같을 때
			if(preWeeklySize == currentWeeklySize){
				result = lecPlanDao.updateWeeklySame(weekList);
				
			// 기존 갯수와 새로 작성한 갯수의 변동이 있을 때
			} else if(preWeeklySize != currentWeeklySize){
				
				// 기존 개수 < 갱신 후 개수 (업데이트, 인서트) : 갯수가 많아졌기 때문에 업데이트시 에러 발생
				// 기존 개수 > 갱신 후 개수 (업데이트, 삭제)
				
				// 업데이트할 list
				List<Map> UList = new ArrayList<>();
				// 추가 혹은 삭제할 값을 담은 리스트 
				List<Map> IDList = new ArrayList<>();
				
				
				// 업데이트, 인서트
				if(preWeeklySize < currentWeeklySize){
					
					// weekList에서 기존에 있던 수만큼 UList에 추가
					for(int i = 0; i < preWeeklySize; i++){
						UList.add(weekList.get(i));
					}
					
					// 업데이트 진행
					lecPlanDao.updateWeeklySame(UList);
					
					
					// weekList에서 기존에 있던 수만큼 지우고 나머지를 IDList에 추가
					for(int i = preWeeklySize; i < currentWeeklySize; i++){
						IDList.add(weekList.get(i));
					}
					
					// 인서트 진행( == 추가된 주차)
					lecPlanDao.inputWeekly(IDList);
					
					
				
				// 업데이트, 삭제
				} else if(preWeeklySize > currentWeeklySize) {
					lecPlanDao.updateWeeklySame(weekList);		// 업데이트 되는 개수가 기존의 양보다 적으니 업데이트 에러가 안난다
					
					// 기존 - 현재 = DB에서 지워야할 행의 개수
					// 갱신된 수 + 1씩하여 DB에서 지우기 => 지우려는 weekly_no 만들기
					// 삭제시 필요한 값 = lec_cd , weekly_no
					for(int i = currentWeeklySize + 1; i <= preWeeklySize; i++){
						Map<String,Object> map = new HashMap<>();
						map.put("lec_cd", Integer.parseInt(paramMap.get("lec_cd").toString()));
						map.put("weekly_no", i + "주차");
						
						IDList.add(map);
					}
					
					/* 로직설명
					 * 기존 주차		:	1주차, 2주차, 3주차, 4주차, 5주차
					 * 현재(갱신후)		:	1주차, 2주차, 3주차
					 * 삭제해야할 주차	:	4주차, 5주차
					 * 
					 * 받은 list.size() == currentWeeklySize == 3
					 * for문의 i의 시작 = list.size() + 1 = 4
					 * preWeeklySize = 5 
					 * ==> map에 4주차에서 5주차까지 담긴다.
					 * */
					
					// 남은 인덱스( == 제거된 주차) 삭제
					result = lecPlanDao.deleteWeekly(IDList);
					
				}
			}
		}
		
		if(result != 0) msg = "저장 성공";
		else  msg = "저장 실패";
		
		return msg;
		
	}
	
}
