package web.mvc;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

public class Board41Logic {
	Logger logger = Logger.getLogger(Board41Logic.class);
	private Board41MDao boardMDao = new Board41MDao();
	public void setBoardMDao(Board41MDao boardMDao) {
		this.boardMDao = boardMDao;
	}
	
	private Board41SDao boardSDao = new Board41SDao();
	public void setBoardSDao(Board41SDao boardSDao) {
		this.boardSDao = boardSDao;
	}
	
	public List<Map<String,Object>> getBoardList(Map<String, Object> pmap) {
		logger.info("getBoardLsit 호출 성공");
		List<Map<String, Object>> boardList = null;
		boardList = boardMDao.getBoardList(pmap);
		return boardList;
	}

	//=>board/boardInsert.sp4?bm_no=100&bm_title=연습&bs_file=a.txt&bm_writer=이순신&bm_email=test@hot.com&bm_content=내용&bm_pw=123
	public int boardInsert(Map<String, Object> pmap) {
		logger.info("boardInsert 호출 성공");
		int result = 0;
		int fileOk = 0;
		//첨부파일이 있어?
		if(pmap.containsKey("bs_file")) {
			fileOk = boardMDao.boardMInsert(pmap);
		}
		logger.info("fileOk : "+fileOk);
		result = 1;
		return result;
	}
	
}
