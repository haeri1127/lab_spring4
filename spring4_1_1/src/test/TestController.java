package test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.util.HashMapBinder;

public class TestController extends MultiActionController {
	private TestLogic testLogic = null;

	public void setTestLogic(TestLogic testLogic) {
		this.testLogic = testLogic;
	}

	public ModelAndView getTest(HttpServletRequest req, HttpServletResponse res) throws Exception {
		HashMapBinder		hmb		= new HashMapBinder(req);
		Map<String, Object>	target	= new HashMap<>();
		hmb.bind(target);

		List<Map<String, Object>> testList = null;
		testList = testLogic.getTest(target);

		ModelAndView mav = new ModelAndView();
		mav.setViewName("test/getTest");
		mav.addObject("testList", testList);
		return mav;
	}
}
