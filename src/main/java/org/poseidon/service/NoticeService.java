package org.poseidon.service;

import java.util.List;

import org.poseidon.dto.NoticeDTO;

public interface NoticeService {

	public List<NoticeDTO> noticeList(int startPpageNo);

	public NoticeDTO detail(int no);

	public int noticeWrite(NoticeDTO dto);

	public int noticeDel(int no);

	public int noticeUpdate(NoticeDTO dto);

	public int totalRecordCount();
}
