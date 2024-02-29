package org.poseidon.dao;

import java.util.List;

import org.poseidon.dto.NoticeDTO;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO extends AbstractDAO {

	public List<NoticeDTO> noticeList(int startPpageNo) {
		return sqlSession.selectList("notice.noticeList", startPpageNo);
	}

	public int noticeWrite(NoticeDTO dto) {
		return sqlSession.insert("notice.noticeWrite", dto);
	}

	public NoticeDTO detail(int no) {
		return sqlSession.selectOne("notice.detail", no);
	}

	public int noticeDel(int no) {
		return sqlSession.update("notice.noticeDel", no);
	}

	public int totalRecordCount() {
		return sqlSession.selectOne("notice.totalRecordCount");
	}
	
}
