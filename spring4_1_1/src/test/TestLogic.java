package test;

import java.util.List;
import java.util.Map;

import prac.emp.PracEmpDao;

public class TestLogic {
	private TestDao testDao = null;
	
	public void setTestDao(TestDao testDao) {
		this.testDao = testDao;
	}

	public List<Map<String, Object>> getTest(Map<String, Object> target) {
		List<Map<String, Object>> testList = testDao.getTest(target);
		return testList;
	}

}
