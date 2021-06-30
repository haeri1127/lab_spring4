package test;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

public class TestDao {
	private SqlSessionTemplate sqlSessionTemplate = null;
	
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	public List<Map<String, Object>> getTest(Map<String, Object> target) {
		List<Map<String, Object>> testList = null;
		//testList = sqlSessionTemplate.selectList("getEmpList",pmap);
		return testList;
	}

}
