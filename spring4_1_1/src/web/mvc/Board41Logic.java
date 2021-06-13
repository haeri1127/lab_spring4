package web.mvc;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

public class Board41Logic {
	Logger				logger		= Logger.getLogger(Board41Logic.class);
	private Board41MDao	boardMDao	= null;

	public void setBoardMDao(Board41MDao boardMDao) {
		this.boardMDao = boardMDao;
	}

	private Board41SDao boardSDao = null;

	public void setBoardSDao(Board41SDao boardSDao) {
		this.boardSDao = boardSDao;
	}

	public List<Map<String, Object>> getBoardList(Map<String, Object> pmap) {
		logger.info("getBoardLsit 호출 성공");
		List<Map<String, Object>> boardList = null;
		boardList = boardMDao.getBoardList(pmap);
		return boardList;
	}
	
	public void hitCount(Map<String, Object> pmap) {
		logger.info("Board41Logic==> hitCount 호출 성공");
		boardMDao.hitCount(pmap);
	}

	// http://localhost:8000/board/boardInsert.sp4?bm_no=100&bm_title=연습&bs_file=a.txt&bm_writer=이순신&bm_email=test@hot.com&bm_content=내용&bm_pw=123
	public int boardInsert(Map<String, Object> pmap) {
		logger.info("Board41Logic ==> boardInsert() 호출 성공");

		int	result			= 0;
		int	bm_no			= 0;

		//글번호 채번
		bm_no = boardMDao.getBmNo();
		pmap.put("bm_no",bm_no);
		pmap.put("bm_group", 0);
		pmap.put("bm_pos", 0);
		pmap.put("bm_step", 0);
		boardMDao.boardMInsert(pmap);
		
		//첨부파일이 있니?
		//
		if ((pmap.get("bs_file") != null) && (String.valueOf(pmap.get("bs_file")).length() > 0)) {
			pmap.put("bs_seq", 1);
			pmap.put("bs_size", 70);
			boardSDao.boardSInsert(pmap);	
		}
		else {//첨부파일이 없는 경우
			logger.info("이거이거");
			pmap.put("bs_seq", 1);
			pmap.put("bs_file", "파일 없음");
			pmap.put("bs_size", 70);
			boardSDao.boardSInsert(pmap);	
		}
		result = 1;
		return result;
	}

	public void boardDelete(Map<String, Object> pmap) {
		logger.info("Board41Logic ==> boardDelete() 호출 성공");
		boardMDao.boardMDelete(pmap);
		//파일이 있는 글이니? if문 작성해야하나..?
		boardSDao.boardSDelete(pmap);
	}

	public List<Map<String, Object>> boardUpdate(Map<String, Object> pmap) {
		logger.info("Board41Logic ==> boardUpdate() 호출 성공");
		boardMDao.boardMUpdate(pmap); //값 update
		
		List<Map<String, Object>> boardList = null;
		boardList = boardMDao.getBoardList(pmap);
		return boardList;
	}

}
