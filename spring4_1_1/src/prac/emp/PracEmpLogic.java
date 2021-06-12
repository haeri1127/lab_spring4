package prac.emp;

import java.util.List;
import java.util.Map;

public class PracEmpLogic {
	private PracEmpDao pracEmpDao = null;
	
	public void setPracEmpDao(PracEmpDao pracEmpDao) {
		this.pracEmpDao = pracEmpDao;
	}

	public List<Map<String, Object>> getEmpList(Map<String, Object>	pmap) {
		List<Map<String, Object>> empList = pracEmpDao.getEmpList(pmap);
		return empList;
	}

}
