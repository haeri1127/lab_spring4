package prac.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.util.HashMapBinder;

public class PracEmpController extends MultiActionController{
	Logger logger = Logger.getLogger(PracEmpController.class);
	private PracEmpLogic pracEmpLogic = null;
	
	public void setPracEmpLogic(PracEmpLogic pracEmpLogic) {
		this.pracEmpLogic = pracEmpLogic;
	}
	
	public ModelAndView getEmpList(HttpServletRequest req, HttpServletResponse res) throws Exception {
		logger.info("PracEmpController ==> getEmpList 호출 성공");
		HashMapBinder		hmb		= new HashMapBinder(req);
		Map<String, Object>	target	= new HashMap<>();
		hmb.bind(target);
		
		List<Map<String, Object>> empList = null;
		empList = pracEmpLogic.getEmpList(target);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("pracemp/getEmpList");
		mav.addObject("haha",empList);
		return mav;
	}


}
