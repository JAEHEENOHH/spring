package org.poseidon.service;

import java.util.List;

import org.poseidon.dao.NoticeDAO;
import org.poseidon.dto.NoticeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("noticeService")
public class NoticeServiceImpl extends AbstractService implements NoticeService {
	
	@Autowired
	private NoticeDAO noticeDAO;
		
	@Override
	public List<NoticeDTO> noticeList(int startPpageNo) {
		return noticeDAO.noticeList(startPpageNo);
	}

	@Override
	public NoticeDTO detail(int no) {
		return noticeDAO.detail(no);
	}

	@Override
	public int noticeWrite(NoticeDTO dto) {
		return noticeDAO.noticeWrite(dto);
	}

	@Override
	public int noticeDel(int no) {
		return noticeDAO.noticeDel(no);
	}

	@Override
	public int noticeUpdate(NoticeDTO dto) {
		return 0;
	}

	@Override
	public int totalRecordCount() {
		return noticeDAO.totalRecordCount();
	}

	

}
