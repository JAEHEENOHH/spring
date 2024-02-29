package org.poseidon.controller;

import java.util.List;

import javax.annotation.Resource;

import org.poseidon.dto.NoticeDTO;
import org.poseidon.service.NoticeService;
import org.poseidon.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class NoticeController {

	@Resource(name = "noticeService")
	private NoticeService noticeService;

	@Autowired
	private Util util;

	// 2024-02-27 요구사항 확인 psd
	@GetMapping("/notice")
	public String notice(@RequestParam(value = "pageNo", required = false) String no, Model model) {
		int currentPageNo = 1;
		if (util.str2Int(no) > 0) {currentPageNo = Integer.parseInt(no);}
		int totalRecordCount = noticeService.totalRecordCount();
		// pagination
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo);// 현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); // 한 페이지에 게시되는 게시물 건 수
		paginationInfo.setPageSize(10); // 페이징 리스트의 사이즈
		paginationInfo.setTotalRecordCount(totalRecordCount);// 전체 게시물 건 수

		List<NoticeDTO> list = noticeService.noticeList(paginationInfo.getFirstRecordIndex());
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNo", currentPageNo);
		return "notice"; // ....../views/notice.jsp
	}

	// 공지 글쓰기 -> admin 관리자 화면에서
	@GetMapping("/admin/noticeWrite")
	public String noticeWrite() {
		return "admin/noticeWrite"; // /views/admin/noticeWrite.jsp
	}

	@PostMapping("/admin/noticeWrite")
	public String noticeWrite(NoticeDTO dto) {
		// System.out.println(dto.getNtitle());
		// System.out.println(dto.getNcontent());
		int result = noticeService.noticeWrite(dto);
		System.out.println("result : " + result);
		return "redirect:/notice";
	}

	// noticeDetail?no=100
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam(value = "no", defaultValue = "0", required = true) int no, Model model) {
		if (no == 0) {
			return "redirect:/error";
		} else {
			NoticeDTO detail = noticeService.detail(no);
			if (detail.getNno() == 0) {
				return "redirect:/error";
			} else {
				model.addAttribute("detail", detail);
				return "noticeDetail";
			}

		}
	}

	// noticeDel230
	@GetMapping("/noticeDel{no}")
	public String noticeDel(@PathVariable("no") int no) {
		noticeService.noticeDel(no);
		return "redirect:/notice";
	}

}
