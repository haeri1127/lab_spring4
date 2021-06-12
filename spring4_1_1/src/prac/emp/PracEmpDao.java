package prac.emp;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;

public class PracEmpDao {
	Logger logger = Logger.getLogger(PracEmpDao.class);
	private SqlSessionTemplate sqlSessionTemplate = null;
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	public List<Map<String, Object>> getEmpList(Map<String, Object>	pmap) {
		List<Map<String, Object>> empList = null;
		empList = sqlSessionTemplate.selectList("getEmpList",pmap);
		logger.info("호출 성공 ㅋ getEmpList : "+empList);
		return empList;
	}
}
